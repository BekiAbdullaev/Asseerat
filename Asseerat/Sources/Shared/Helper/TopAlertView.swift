//
//  File.swift
//  MyLibrary
//
//  Created by Bekzod Abdullaev on 10/06/25.
//

import SwiftUI
import SnapKit
import SwiftEntryKit


public func showTopAlert(title: String, status:TopAlertType = .error) {
    let errorView = TopAlertView(title: title, status: status)
    var attributes = EKAttributes.topFloat
    attributes.displayDuration = 2.5
    attributes.windowLevel = .normal
    attributes.entryBackground =  .clear
    attributes.screenInteraction = .dismiss
    attributes.entryInteraction = .absorbTouches
    attributes.scroll = .enabled(
        swipeable: true,
        pullbackAnimation: .jolt
    )
    attributes.positionConstraints.verticalOffset = 20
    attributes.positionConstraints.size.width = .offset(value: 0)
    attributes.entranceAnimation = .init(
        translate: .init( duration: 0.7, spring: .init(damping: 0.7, initialVelocity: 0)),
        scale: .init( from: 0.7, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)
        )
    )
    attributes.exitAnimation = .init(
        translate: .init(duration: 0.2)
    )
    if title.isNotEmpty {
        SwiftEntryKit.display(entry: errorView, using: attributes)
    }
}

public enum TopAlertType {
    case error
    case success
    case info
    case warning
    case custom(image:UIImage, textColor:Color, bgColor:Color)
}

class TopAlertView: UIView {
    private let title:String
    private let status:TopAlertType
    let holderView:UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 12.0
        return view
    }()
    let icon:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    let titleLabel:UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 15, weight: .regular)
        lbl.textColor = .white
        lbl.textAlignment = .left
        return lbl
    }()

    init(title:String, status:TopAlertType) {
        self.title = title
        self.status = status
        super.init(frame: .zero)
        initUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initUI() {
        self.addItems()
        titleLabel.text = title.localized
        switch status {
        case .error:
            holderView.backgroundColor = UIColor(Colors.alertError)
            titleLabel.textColor = UIColor(Colors.textError)
            icon.image = UIImage(named: "ic_alert_error")
        case .success:
            holderView.backgroundColor = UIColor(Colors.alertSuccess)
            titleLabel.textColor = UIColor(Colors.textSuccess)
            icon.image = UIImage(named: "ic_alert_success")
        case .info:
            holderView.backgroundColor = UIColor(Colors.alertInfo)
            titleLabel.textColor = UIColor(Colors.text)
            icon.image = UIImage(named: "ic_alert_info")
        case .warning:
            holderView.backgroundColor = UIColor(Colors.alertWarning)
            titleLabel.textColor = UIColor(Colors.textWarning)
            icon.image = UIImage(named: "ic_alert_warning")
        case .custom(image: let image, textColor: let textColor, bgColor: let bgColor):
            holderView.backgroundColor = UIColor(bgColor)
            titleLabel.textColor = UIColor(textColor)
            icon.image = image
        }
    }
    
    func addItems(){
        addSubview(holderView)
        holderView.addSubview(icon)
        holderView.addSubview(titleLabel)
        holderView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(24)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(12)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}

