import UIKit
import AVFoundation

class VC_Camera: UIViewController, AVCaptureFileOutputRecordingDelegate {
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print("Error recording video: \(error.localizedDescription)")
        } else {
            print("Video recording completed: \(outputFileURL)")
        }
    }

    var captureSession: AVCaptureSession!
    var videoOutput: AVCaptureMovieFileOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Request camera and microphone permissions
        AVCaptureDevice.requestAccess(for: .video) { granted in
            guard granted else {
                print("Camera access denied")
                return
            }
            
            // Set up capture session
            self.captureSession = AVCaptureSession()
            self.captureSession.beginConfiguration()
            
            // Set up video input
            guard let videoDevice = AVCaptureDevice.default(for: .video) else {
                print("Failed to get video device")
                return
            }
            guard let videoInput = try? AVCaptureDeviceInput(device: videoDevice) else {
                print("Failed to create video input")
                return
            }
            guard self.captureSession.canAddInput(videoInput) else {
                print("Cannot add video input to capture session")
                return
            }
            self.captureSession.addInput(videoInput)
            
            // Set up video output
            self.videoOutput = AVCaptureMovieFileOutput()
            guard self.captureSession.canAddOutput(self.videoOutput) else {
                print("Cannot add video output to capture session")
                return
            }
            self.captureSession.addOutput(self.videoOutput)
            
            self.captureSession.commitConfiguration()
            self.captureSession.startRunning()
        }
    }
    
    // Start recording video
    func startRecording() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let videoFileName = "my_recorded_video.mp4"
        let videoFileURL = documentsDirectory.appendingPathComponent(videoFileName)
        self.videoOutput.startRecording(to: videoFileURL, recordingDelegate: self)
    }
    
    // Stop recording video
    func stopRecording() {
        self.videoOutput.stopRecording()
    }
}
