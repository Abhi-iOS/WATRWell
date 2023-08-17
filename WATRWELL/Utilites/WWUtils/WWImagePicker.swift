//
//  WWImagePicker.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 15/08/23.
//

import AVKit
import UIKit

protocol ImagePickerDelegate: AnyObject {
    func imagePickerDelegate(didSelect image: UIImage)
    func imagePickerDidCancel()
    func removeImage()
}

extension ImagePickerDelegate {
    func removeImage() {}
}

class WWImagePicker: NSObject {
    
    enum CameraPermission{
        case done,setting,askPermission
    }
    
    private weak var controller: UIImagePickerController?
    weak var delegate: ImagePickerDelegate? = nil
    var isProfileImageSet = false
    var showRemoveImageOption = false
    var openFrontCamera = false
    var isEditingOn = true
    
    func showImagePickerOption(_ viewController: (UIViewController & ImagePickerDelegate)) {
        delegate = viewController
        let cameraAction = UIAlertAction(title: "Take a picture".uppercased(), style: .default) {[weak self] _ in
            
            let permission = self?.checkCameraPermission()
            if permission == .done{
                self?.present(parent: viewController, sourceType: .camera)
            }else if permission == .setting {
                self?.showCameraSettingPopup()
            }else if permission == .askPermission{
                AVCaptureDevice.requestAccess(for: .video) {[weak self] granted in
                    if granted {
                        DispatchQueue.main.async {
                            self?.present(parent: viewController, sourceType: .camera)
                        }
                    }
                }
            }
        }
        
        let galleryAction = UIAlertAction(title: "Gallery".uppercased(), style: .default, handler: { [weak self] _ in
            self?.present(parent: viewController, sourceType: .photoLibrary)
        })
        
        var actions = [ galleryAction, cameraAction]
        
        if showRemoveImageOption && isProfileImageSet {
            let removeAction = UIAlertAction(title: "REMOVE IMAGE", style: .default, handler: { [weak self] _ in
                self?.isProfileImageSet = false
                self?.delegate?.removeImage()
            })
            actions.append(removeAction)
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
        actions.append(cancelAction)
        
        showAlert(style: .actionSheet, title: nil,message: nil, actions: actions)
    }
    
    private func showAlert(style: UIAlertController.Style = .alert,
                   title: String?,
                   message: String?,
                   actions: [UIAlertAction],
                   completion: (()->())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        alertController.view.tintColor = WWColors.hexDF5509.color
        actions.forEach { (action) in
            alertController.addAction(action)
        }
        sharedAppDelegate.window?.currentViewController?.present(alertController, animated: true, completion: {
            completion?()
        })
    }
    
    private func present(parent viewController: UIViewController, sourceType: UIImagePickerController.SourceType) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.allowsEditing = isEditingOn
        controller.sourceType = sourceType
        if openFrontCamera && sourceType == .camera{
            controller.cameraDevice = .front
        }
        self.controller = controller
        
        DispatchQueue.main.async {
            controller.modalPresentationStyle = .overFullScreen
            viewController.present(controller, animated: true, completion: nil)
        }
    }
    
    
    func checkCameraPermission()->CameraPermission{
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized:
            return .done
        case .denied,.restricted:
            return .setting
        case .notDetermined:
            return .askPermission
        @unknown default:
            print("error")
        }
        return .setting
    }
    
    func showCameraSettingPopup(){
        let alertController = UIAlertController(title: "WATRWELL", message: "Permission to access your camera is required to continue".uppercased(), preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "CANCEL", style: .cancel))
        alertController.addAction(UIAlertAction(title: "OPEN SETTINGS", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(url)
            }
        }))
        sharedAppDelegate.window?.currentViewController?.present(alertController, animated: false)
    }
    
    func dismiss() { controller?.dismiss(animated: true, completion: nil) }
}

extension WWImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            isProfileImageSet = true
            delegate?.imagePickerDelegate(didSelect: image)
            return
        }
        
        if let image = info[.originalImage] as? UIImage {
            delegate?.imagePickerDelegate(didSelect: image)
        } else {
            print("Other source")
        }
        picker.delegate = nil
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate?.imagePickerDidCancel()
    }
}
