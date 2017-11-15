//
//  LeoVideoRecorderAndPlayer.swift
//  LeoVedioPlayerAndRecorderProject
//
//  Created by vijay vir on 11/15/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import UIKit
import AVKit
import Foundation
import MediaPlayer
import MobileCoreServices

// https://www.raywenderlich.com/94404/play-record-merge-videos-ios-swift

class LeoVideoRecorderAndPlayer  : UIButton ,  UIImagePickerControllerDelegate , UINavigationControllerDelegate {
	var isRecording : Bool = false
	var closureDidFinishPickingMediaWithInfo : ((String) -> Void)?

	open func player(on : UIViewController , url : URL) {
		let player = AVPlayer(url: url)
		let playerViewController = AVPlayerViewController()
		playerViewController.player = player
		on.present(playerViewController, animated: true) {
		playerViewController.player!.play()
	}
}

}

extension LeoVideoRecorderAndPlayer   {
	func leoPlayRecordingFromGallery( ) -> Bool {

	  isRecording = false
		if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) == false {
			return false
		}

		let mediaUI = UIImagePickerController()
		mediaUI.sourceType = .savedPhotosAlbum
		mediaUI.mediaTypes = [kUTTypeMovie as NSString as String]
		mediaUI.allowsEditing = true
		mediaUI.delegate = self
		UIApplication.leoRecorderAndPlayertopViewController()?.present(mediaUI, animated: true, completion: nil)

		return true
	}
	func leoStartRecordingVideo() -> Bool {
		isRecording = true

		if UIImagePickerController.isSourceTypeAvailable(.camera) == false {
			return false
		}

		let cameraController = UIImagePickerController()
		cameraController.sourceType = .camera
		cameraController.mediaTypes =   [kUTTypeMovie as NSString as String]
		cameraController.allowsEditing = false
		cameraController.delegate = self
		cameraController.cameraCaptureMode = .video

		UIApplication.leoRecorderAndPlayertopViewController()?.present(cameraController, animated: true, completion: nil)

		return true
	}

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
  		let mediaType = info[UIImagePickerControllerMediaType] as! NSString
		  picker.dismiss(animated: true) {
			if mediaType == kUTTypeMovie {
			guard let path = (info[UIImagePickerControllerMediaURL] as! NSURL).path else { return }
       print("Path 📿📿📿📿📿 " , path )

			 self.closureDidFinishPickingMediaWithInfo?(path)


				if !self.isRecording {
					self.player(on: UIApplication.leoRecorderAndPlayertopViewController()!, url: URL(fileURLWithPath: path))
				} else {
					if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path) {
						UISaveVideoAtPathToSavedPhotosAlbum(path, self,
						                                    #selector(LeoVideoRecorderAndPlayer.video(videoPath:didFinishSavingWithError:contextInfo:)), nil)
					}
				}
			}
		}
	}

	@objc func video(videoPath: NSString, didFinishSavingWithError error: NSError?, contextInfo info: AnyObject) {
		var title = "Success"
		var message = "Video was saved"
		if let _ = error {
			title = "Error"
			message = "Video failed to save"
		}
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
		UIApplication.leoRecorderAndPlayertopViewController()?.present(alert, animated: true, completion: nil)
	}
}

extension UIApplication {

	class func leoRecorderAndPlayertopViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

		if let navigationController = controller as? UINavigationController {
			return leoRecorderAndPlayertopViewController(controller: navigationController.visibleViewController)
		}
		if let tabController = controller as? UITabBarController {
			if let selected = tabController.selectedViewController {
				return leoRecorderAndPlayertopViewController(controller: selected)
			}
		}
		if let presented = controller?.presentedViewController {
			return leoRecorderAndPlayertopViewController(controller: presented)
		}


		// need R and d
		//        if let top = UIApplication.shared.delegate?.window??.rootViewController
		//        {
		//            let nibName = "\(top)".characters.split{$0 == "."}.map(String.init).last!
		//
		//            print(  self,"    d  ",nibName)
		//
		//            return top
		//        }

		return controller

	}
}
