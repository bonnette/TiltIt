//
//  ContentView.swift
//  TiltIt
//
//  Created by Larry Bonnette on 3/15/23.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    @State var isTilted = false
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    
    var body: some View {
        VStack {
            Text("Tilt your phone forward more than 45 degrees")
            Spacer()
        }
        .foregroundColor(isTilted ? .black : .red)
        .onAppear {
            motionManager.startDeviceMotionUpdates(to: queue) { (data, error) in
                guard let data = data else { return }
                let pitch = abs(data.attitude.pitch * 180 / .pi)
                if pitch > 45 {
                    isTilted = true
                } else {
                    isTilted = false
                }
            }
        }
        .onDisappear {
            motionManager.stopDeviceMotionUpdates()
        }
    }
}
