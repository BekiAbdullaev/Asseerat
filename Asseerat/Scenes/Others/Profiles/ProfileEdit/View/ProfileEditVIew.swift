//
//  ProfileEditVIew.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 21/06/25.
//

import SwiftUI
import PhotosUI

struct ProfileEditVIew: View {
    
    @State private var name = ""
    @State var validName:Bool = false
    @State private var surname = ""
    @State var validSurname:Bool = false
    @State private var email = ""
    @State var validEmail:Bool = false
    @State private var phone = ""
    @State var validPhone:Bool = false
    @State private var date = ""
    @State var validDate:Bool = false
    @State private var dateHasError:Bool = false
    @State private var selectedSegment = 0
    @State private var regByPhone:Bool = false
    @State private var selectedImage: UIImage? = nil
    @State private var showAlert: Bool = false
    @State private var showingOptions = false
    @State var isShowPicker: Bool = false
    @State private var isShowingCamera = false
    @State var data: Data? = nil
    
    private var userInfo = MainBean.shared.userInfo
    var userId: String {
        MainBean.shared.userID ?? "1"
    }
    private var needEdit:Bool{
        return checkHasChange()
    }
    
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    @ObservedObject private var viewModel = ProfileEditViewModel()
    
    var body: some View {
        VStack{
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 20) {
                    self.imagePicker(profileImage: selectedImage).padding(.vertical,20)
                    HStack(alignment:.center, spacing: 8){
                        TextFieldFactory.textField(type: .defaultTF(title: Localize.name, text: $name))
                        TextFieldFactory.textField(type: .defaultTF(title: Localize.lastName, text: $surname))
                    }.padding(.top,20)
                    
                    if regByPhone {
                        TextFieldFactory.textField(type: .phone9(title: Localize.telephone, number: $phone, isValid: $validPhone))
                    } else {
                        TextFieldFactory.textField(type: .email(title: Localize.eMail, email: $email,  isValid: $validEmail))
                    }
                    
                    CustomSegmentedControl(preselectedIndex: $selectedSegment,
                                           options: [Localize.male, Localize.female])
                    TextFieldFactory.textField(type: .date(title: Localize.dateOfBirth, date: $date, isValid: $validDate, hasError: $dateHasError))
                    ButtonFactory.button(type: .primery(text: Localize.save, isActive: MainBean.shared.changeToBindingBool(bool: needEdit), onClick: {
                        
                        let reqBody = ProfileEditModel.Request.EditUserInfo(
                            name: name,
                            surname: surname,
                            sex: selectedSegment == 0 ? CompMethod.MALE : CompMethod.FEMALE,
                            email: email,
                            phone: "998\(phone)",
                            birthday: date,
                            client_id: SecurityBean.shared.userId,
                            avatar_id: 1)
                        
                        self.viewModel.editUserInfo(reqBody: reqBody) {
                            showTopAlert(title: Localize.userInfoSucUpdated, status: .success)
                        }
                        
                    })).padding(.top, 20)
                    
                    ButtonFactory.button(type: .secondary(text: Localize.deleteAnAccount, onClick: {
                        infoActionAlert(title: Localize.deleteAnAccount, subtitle: Localize.deleteAnAccountDetail, lBtn: Localize.back, rBtn: Localize.delete) {
                            self.viewModel.deleteUserAccount {
                                UDManager.shared.clear()
                                self.coordinator.popToRoot()
                            }
                        }
                    }))
                }.padding(16)
               
            }
        }.background(Colors.background)
            .navigationBarHidden(false)
            .navigationTitle(Localize.profileEditing)
            .onTapGesture { keyboardEndEditing() }
            .onDidLoad {
                self.regByPhone = userInfo?.login_type == CompMethod.PHONE ? true : false
                name = userInfo?.name ?? ""
                surname = userInfo?.surname ?? ""
                let ph = userInfo?.phone ?? ""
                phone = String(ph.dropFirst(3))
                date = userInfo?.birthday ?? ""
                selectedSegment = userInfo?.sex == "MALE" ? 0 : 1
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(Localize.camera),
                    message: Text(Localize.cameraRequired),
                    primaryButton: .default(Text(Localize.settings)) {
                        self.viewModel.openSettings()
                    },
                    secondaryButton: .cancel()
                )
            }
            .sheet(isPresented: $isShowPicker) {
                ImagePicker(
                    imageData: $data,
                    onImagePicked: { imageData in
                        uploadImageToFirebase(data: imageData, userId: userId)
                    }
                )
            }
            .sheet(
                isPresented: $isShowingCamera,
                content: {
                    CameraPickerView { image in
                        self.data = image.pngData()
                        if let data = data {
                            uploadImageToFirebase(data: data, userId: userId)
                        }
                    }
                }
            )
    }
    
    @ViewBuilder
    private func imagePicker(profileImage:UIImage?) -> some View {
        ZStack{
            if let data = data, let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(50, corners: .allCorners)
            } else if let imageData:[Data] = UDManager.shared.getObject(key: .profileImage), let imageIn = imageData.first, let image = UIImage(data: imageIn)  {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(50, corners: .allCorners)
            } else {
                Image("ic_profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
            }
            ZStack {
                Colors.background
                ZStack {
                    Colors.btnColor
                    Image("ic_add_image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                }.frame(width: 36, height: 36, alignment: .center)
                    .cornerRadius(18, corners: .allCorners)
            }.frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20, corners: .allCorners)
                .offset(y:55)
            
        }.frame(width: 100, height: 100, alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: 50, style: .continuous)
            ).foregroundColor(Colors.green)
            .onTapGesture {
                showingOptions = true
            }
            .actionSheet(isPresented: $showingOptions) {
                actionSheet()
            }
    }
    
    
    private func checkHasChange() -> Bool {
        let initName = userInfo?.name ?? ""
        let initSurname = userInfo?.surname ?? ""
        let initDate = userInfo?.birthday ?? ""
        let returnValue = (initName == name) && (initSurname == surname) && (initDate == date) && checkSex() && checkLogin()
        return !returnValue
    }
    
    private func checkSex()->Bool {
        let initSex = userInfo?.sex ?? ""
        let sex = selectedSegment == 0 ? CompMethod.MALE : CompMethod.FEMALE
        return sex == initSex
    }
    
    private func checkLogin()->Bool {
        return regByPhone ? userInfo?.phone ?? "" == "998\(phone)" : userInfo?.email ?? "" == email
    }
}


extension ProfileEditVIew {

    func actionSheet() -> ActionSheet {
        if let imageData:[Data] = UDManager.shared.getObject(key: .profileImage) {
            print(imageData)
            return ActionSheet(
                title: Text(Localize.uploadImage),
                buttons: [
                    .default( Text(Localize.camera) ) {
                        if self.viewModel.isCameraPermissionEnabled() {
                            isShowingCamera = true
                        } else {
                            showAlert = true
                        }
                    },
                    .default(Text(Localize.galery)) {
                        isShowPicker = true
                    },
                    .default( Text(Localize.delete) ) {
                        deleteProfileImage()
                    },
                    .cancel( Text(Localize.cancel) )
                ]
            )
        } else {
            return ActionSheet(
                title: Text(Localize.uploadImage),
                buttons: [
                    .default( Text(Localize.camera) ) {
                        if self.viewModel.isCameraPermissionEnabled() {
                            isShowingCamera = true
                        } else {
                            showAlert = true
                        }
                    },
                    .default( Text(Localize.galery) ) { isShowPicker = true },
                    .cancel( Text(Localize.cancel) )
                ]
            )
        }
    }
    
    func uploadImageToFirebase(data: Data, userId: String) {
        UDManager.shared.setObject(key: .profileImage, object: [data])
        NotificationCenter.default.post(name: .updateProfileImage, object: nil)
    }
    
    func deleteProfileImage() {
        UDManager.shared.setObject(key: .profileImage, object: [Data()])
        NotificationCenter.default.post(name: .updateProfileImage, object: nil)
    }
}
