//
//  CheckMarkerWithSound.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 29/09/25.
//

import SwiftUI
import AVFoundation

struct CheckMarkerWithSound: View {
    
    @State private var drawProgress: CGFloat = 0
    @State private var scale: CGFloat = 0.85
    @State private var showGlow: Bool = false
    @State private var audioPlayer: AVAudioPlayer?
    
    private var size: CGFloat
    private var line: CGFloat
    private var needSound: Bool
    
    init(size: CGFloat = 80, line:CGFloat = 8, needSound: Bool = true){
        self.size = size
        self.needSound = needSound
        self.line = line
    }
    
    var body: some View {
        VStack {
            CheckmarkShape()
                .trim(from: 0, to: drawProgress)
                .stroke(style: StrokeStyle(lineWidth: line, lineCap: .round, lineJoin: .round))
                .foregroundColor(Colors.btnColor)
                .frame(width: size, height: size)
                .shadow(color: Color.green.opacity(0.25), radius: 6, x: 0, y: 3)
                .animation(.linear(duration: 0.35), value: drawProgress)
        }.onAppear {
            animateIn()
            if needSound {
                playSound()
            }
        }
    }
    
    func animateIn() {
        withAnimation(.easeInOut(duration: 0.4)) {
            withAnimation(.spring(response: 0.45, dampingFraction: 0.7)) {
                scale = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                withAnimation(.easeOut(duration: 0.28)) {
                    drawProgress = 1.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) {
                    withAnimation(.easeOut(duration: 0.25)) {
                        showGlow = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        withAnimation(.easeOut(duration: 0.25)) {
                            showGlow = false
                        }
                    }
                }
            }
        }
    }
    
    func playSound() {
        if let path = Bundle.main.path(forResource: "default", ofType: "wav") {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        }
    }
}
