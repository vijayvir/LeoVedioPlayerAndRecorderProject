//
//  ViewController.swift
//  LeoVedioPlayerAndRecorderProject
//
//  Created by vijay vir on 11/15/17.
//  Copyright © 2017 vijay vir. All rights reserved.

// https://www.raywenderlich.com/94404/play-record-merge-videos-ios-swift


import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view, typically from a nib.

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()

		// Dispose of any resources that can be recreated.

	}

	@IBAction func playVideo(sender: AnyObject) {

		let player = LeoVideoRecorderAndPlayer()
		view.addSubview(player)
		_ = player.player(on: self, url: URL(fileURLWithPath: "customPlayer"))
		//_ = some.leoStartRecordingVideo()
	}
}
