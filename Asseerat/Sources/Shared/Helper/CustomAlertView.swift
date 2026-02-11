//
//  CustomAlertView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 22/06/25.
//

import SwiftUI
import SnapKit
import SwiftEntryKit


public func infoActionAlert(title: String, subtitle:String, lBtn:String, rBtn:String, lBtnOnClick:@escaping(()->()) = {}, rBtnOnClick:@escaping(()->())) {
    let errorView = CustomAlertView(title: title, subtitle: subtitle, lBtn: lBtn, rBtn: rBtn, lBtnOnClick: lBtnOnClick, rBtnOnClick: rBtnOnClick)
    var attributes = EKAttributes.centerFloat
    attributes.displayDuration = .infinity
    attributes.windowLevel = .normal
    attributes.entryBackground = .clear
    attributes.screenBackground = .color(color: .black.with(alpha: 0.3))
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

class CustomAlertView: UIView {
    private let title:String
    private let subtitle:String
    private let lBtn:String
    private let rBtn:String
    private let lBtnOnClick:()->Void
    private let rBtnOnClick:()->Void
    
    let holderView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorWithHexString("#0F362E")
        view.layer.cornerRadius = 15.0
        return view
    }()
   
    let titleLabel:UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        lbl.font = .systemFont(ofSize: 22, weight: .medium)
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    
    let subtitleLabel:UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 3
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        lbl.textColor = UIColor.colorWithHexString("#9AAAA7")
        lbl.textAlignment = .center
        return lbl
    }()
    
    let btnL:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.textColor = .white
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        btn.layer.cornerRadius = 15
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.colorWithHexString("#3F5E58").cgColor
        btn.backgroundColor = UIColor.colorWithHexString("#0F362E")
        return btn
    }()
    
    let btnR:UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.colorWithHexString("#0F362E"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = UIColor.colorWithHexString("#20C590")
        return btn
    }()
    
    let stackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    

    init(title: String, subtitle:String, lBtn:String, rBtn:String, lBtnOnClick:@escaping(()->()) = {}, rBtnOnClick:@escaping(()->())) {
        self.title = title
        self.subtitle = subtitle
        self.lBtn = lBtn
        self.rBtn = rBtn
        self.lBtnOnClick = lBtnOnClick
        self.rBtnOnClick = rBtnOnClick
        super.init(frame: .zero)
        initUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initUI() {
        self.addItems()
        titleLabel.text = title.localized
        subtitleLabel.text = subtitle.localized
        btnL.setTitle(lBtn, for: .normal)
        btnR.setTitle(rBtn, for: .normal)
        btnL.addTarget(self, action: #selector(btnLHide), for: .touchUpInside)
        btnR.addTarget(self, action: #selector(btnRHide), for: .touchUpInside)

    }
    
    func addItems(){
        addSubview(holderView)
        holderView.addSubview(titleLabel)
        holderView.addSubview(subtitleLabel)
        stackView.addArrangedSubview(btnL)
        stackView.addArrangedSubview(btnR)
        holderView.addSubview(stackView)
        

        holderView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(200)
        }
       
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(24)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        stackView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    @objc func btnLHide() {
        self.lBtnOnClick()
        SwiftEntryKit.dismiss()
    }
    
    @objc func btnRHide() {
        self.rBtnOnClick()
        SwiftEntryKit.dismiss()
    }
}

