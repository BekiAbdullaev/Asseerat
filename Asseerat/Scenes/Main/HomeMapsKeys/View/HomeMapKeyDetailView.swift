//
//  HomeMapKeyDetailView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 26/06/25.
//

import SwiftUI
import AVKit
import AVFoundation
struct HomeMapKeyDetailView: View {
    
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    @ObservedObject private var viewModel = HomeMapKeyViewModel()
    private var navTitle:String
    private var detailid:Int
    @State private var detailText = ""
    
    @State private var playerURL = AVPlayer()
    //AVPlayer(url: URL(string: "https://embed-ssl.wistia.com/deliveries/cc8402e8c16cc8f36d3f63bd29eb82f99f4b5f88/accudvh5jy.mp4")!)
    
    init(title: String, id:Int) {
        self.navTitle = title
        self.detailid = id
    }
    
    var body: some View {
        VStack {
            VideoPlayerView(player: playerURL)
                .frame(height: 200) // Adjust size as needed
                .frame(maxWidth:.infinity)
                .padding([.horizontal, .top],16)
                .onAppear {
                }
                .onTapGesture {
                    playerURL.play()
                }
                .onDisappear {
                    playerURL.pause()
                }
            
            UITextViewRepresentable(text: detailText)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .lineSpacing(6)
                .padding(16)
               
        }.background(Colors.background)
            .navigationBarHidden(false)
            .navigationTitle(navTitle.removeNewLine())
            .onDidLoad {
                self.viewModel.getMapsAndLocationsClient(id: "\(self.detailid)") { detail in
                    if let det = detail {
                        self.detailText = det.description_uz ?? ""
                        self.playerURL = AVPlayer(url: URL(string: det.file_download_url ?? "")!)
                    }
                }
            }
    }
}



struct VideoPlayerView: UIViewControllerRepresentable {
    let player: AVPlayer

        func makeUIViewController(context: Context) -> AVPlayerViewController {
            let controller = AVPlayerViewController()
            controller.player = player
            controller.view.backgroundColor = UIColor.setBackColor
            controller.view.layer.cornerRadius = 16
            controller.view.clipsToBounds = true
            return controller
        }

        func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
            uiViewController.player = player
        }
}


struct UITextViewRepresentable: UIViewRepresentable {
    
    let text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.text = text
        textView.textColor = .white
        textView.showsVerticalScrollIndicator = false
        textView.isEditable = false // Read-only
        textView.isScrollEnabled = true // Scrollable
        textView.backgroundColor = UIColor.setBackColor
        textView.font = .systemFont(ofSize: 16)
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.backgroundColor = UIColor.setBackColor
    }
}
