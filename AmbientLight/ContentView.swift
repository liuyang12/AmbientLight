//
//  ContentView.swift
//  AmbientLight
//
//  Created by Yang Liu on 3/21/22.
//

import SwiftUI
import DarkModeBuddyCore

let LOG_FILE_EXT =    ".csv"
let MIN_TO_SECOND: Double  = 60*1000   // minutes to seconds

struct ContentView: View {
    // ambient light sensor reader -> ObservableObject
    @ObservedObject var lightReader: DMBAmbientLightSensorReader
    @State private var emailed: Bool = false
    @State private var recordTime: Double = 17.5
    @State private var fileName: String = "light_log"
    private var logFile: FileHandle? = nil
    
    let NUM_FORMATTER = NumberFormatter()
    
    public init(lightReader: DMBAmbientLightSensorReader = DMBAmbientLightSensorReader(frequency: .realtime))
    {
        lightReader.activate()
        self.lightReader = lightReader
        
        NUM_FORMATTER.numberStyle = .decimal
    }
    
    var body: some View {
        Group {
            if lightReader.isSensorReady {
                SensorRecordingView
            } else {
                UnsupportedSensorView()
            }
        }
    }
    
    private var SensorRecordingView: some View {
        VStack(alignment: .center, spacing: 5) {
            Text(String(format:"Light intensity %.1f lux", lightReader.ambientLightValue))
                .padding()
            
            HStack (spacing: 5) {
                Text("Recording time: ")
                TextField("time in min", value: $recordTime, formatter: NUM_FORMATTER)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .frame(width: 50, alignment: .center)
                Text(" min  ")
                Text(String(format: "(recorded %.1f min)", Double(lightReader.elapsedTimeMs)/MIN_TO_SECOND)
                    )
                .frame(width: 200, alignment: .trailing)
            }
            .padding(.horizontal)
            
            HStack (spacing: 0) {
                Text("Log file name: ")
                TextField("filename", text: $fileName)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .frame(width: 281, alignment: .center)
                Text(".csv")
            }
            .padding(.horizontal)
            
            
            HStack (spacing: 40) {
                VStack(alignment: .center, spacing: 30){
                    Button("Start recording",
                            action: startRecording)
                            .disabled(lightReader.isRecording)
//                    Button("Email log file",
//                            action: emailLogFile)
//                            .disabled(!lightReader.recorded)
                }
                VStack(alignment: .center, spacing: 30){
                    Button("Stop recording",
                            action: stopRecording)
                            .disabled(!lightReader.isRecording)
//                    Button("Clear log file",
//                            action: clearLogFile)
//                            .disabled(!emailed)
                }
            }
            .buttonStyle(.bordered)
            .padding()
        }
    }
    
    func startRecording() {
        lightReader.startRecording(filename: fileName+LOG_FILE_EXT, recordtime: recordTime)
    }
    
    func stopRecording() {
        lightReader.stopRecording()
    }
        
     func emailLogFile() {
          
        emailed = true
    }
    
    func clearLogFile() {
        
        emailed = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(idealWidth: 500, idealHeight: 150, alignment: .center)
            .environmentObject(DMBAmbientLightSensorReader(frequency: .realtime))
            .previewLayout(.sizeThatFits)
    }
}
