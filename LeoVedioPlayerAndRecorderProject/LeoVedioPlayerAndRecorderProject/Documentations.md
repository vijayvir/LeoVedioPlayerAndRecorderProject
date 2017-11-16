#  LeoVideoRecorderAndPlayer  : Movie Recorder  and Player 


This class is  made for  recording  and playing the video(or movie from gallery 
or custom url)

## How to use ? 

### Add following in  .plist file to get the permissions
```swift
<key>NSCameraUsageDescription</key>
<string>Access needed to use your camera.</string>

<key>NSPhotoLibraryUsageDescription</key>
<string>Access needed to photo gallery.</string>

<key>NSMicrophoneUsageDescription</key>
<string>Need microphone access for uploading videos</string>

<key>NSPhotoLibraryAddUsageDescription</key>
<string>Need microphone access for uploading videos</string>

```

### In any actions function


* For Recording 

```swift
		let recorder = LeoVideoRecorderAndPlayer()
		view.addSubview(recorder)
		_ = recorder.leoStartRecordingVideo()
		recorder.closureDidFinishPickingMediaWithInfo = { path in
			print("🦀" , path)
		}
```
* For Player 

```swift
		let player = LeoVideoRecorderAndPlayer()
		view.addSubview(player)
			_ = player.leoPlayRecordingFromGallery()
		recorder.closureDidFinishPickingMediaWithInfo = { path in
			print("🦀" , path)
		}
```
 
 
* For Player with custom url  

```swift
			let player = LeoVideoRecorderAndPlayer()
		view.addSubview(player)
		_ = player.player(on: self, url: URL(fileURLWithPath: "customPlayer"))
```
