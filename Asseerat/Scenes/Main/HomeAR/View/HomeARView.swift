//
//  HomeARView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 20/06/25.
//
import SwiftUI
import SceneKit
import ARKit

struct HomeARView: View {
    
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    private let arView = ARSCNView(frame: .zero)
    private var navTitle:String
    
    init( navTitle: String) {
        self.navTitle = navTitle
    }
    
    var body: some View {
        ZStack {
            ARViewController(arView: arView).edgesIgnoringSafeArea(.all)
        }.navigationBarHidden(false)
            .navigationTitle(self.navTitle.removeNewLine())
            .onAppear {
                let configuration = ARWorldTrackingConfiguration()
                arView.session.run(configuration)
            }
            .onDisappear {
                arView.session.pause()
            }
    }
}


struct ARViewController:UIViewRepresentable {
    
    let arView: ARSCNView
    func updateUIView(_ uiView: ARSCNView, context: Context) {}
    func makeUIView(context: Context) -> ARSCNView {
      
        let sphere = SCNSphere(radius: 0.2)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "earth.jpg")
        sphere.materials = [material]
            
        let node = SCNNode()
        node.position = SCNVector3(x: 0, y: 0.1, z: -0.5)
        node.geometry = sphere
        arView.scene.rootNode.addChildNode(node)
        arView.automaticallyUpdatesLighting = true
       
        return arView
    }
}



