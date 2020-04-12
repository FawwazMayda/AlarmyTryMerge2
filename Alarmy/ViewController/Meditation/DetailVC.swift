//  Created by Basit Tri Anggoro on 11/04/20.
//  Copyright © 2020 Basit Tri Anggoro. All rights reserved.
//

import UIKit
import AVFoundation

class DetailVC: UIViewController {
        @IBOutlet weak var titleLbl: UILabel!
        @IBOutlet weak var durationLbl: UILabel!
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var currentTimeLbl: UILabel!
        @IBOutlet weak var remainingTimeLbl: UILabel!
        @IBOutlet weak var audioSlider: UISlider!
        @IBOutlet var playPauseBtn: UIButton!
    

        let playImage = UIImage(named: "play")
        let pauseImage = UIImage(named: "pause")
        var audioPlayer: AVAudioPlayer!
        var dataMainVC: MainItem?
        var timer:Timer!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            if let checked = dataMainVC {
//                print("DetailVC \(checked.name)")
                titleLbl.text = checked.name
                imageView.image = UIImage(named: checked.image)
                
                let path = Bundle.main.path(forResource: "\(checked.audio)", ofType: "m4a")!
                let url = URL(fileURLWithPath: path)

                do{
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer.numberOfLoops = -1
                }catch{
                    print("error")
                }
                totalDuration()

            } else {
                print("error")
            }
            
            playPauseBtn.setImage(playImage, for: .normal)
            setStatusBar()
            imageView.layer.cornerRadius = 10
            audioSlider.maximumValue = Float(audioPlayer.duration)

            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            if audioPlayer.isPlaying {
                audioPlayer.stop()
            }
        }
        
        @IBAction func playButtonPressed(_ sender: UIButton) {
            if audioPlayer.isPlaying {
                audioPlayer.stop()
                playPauseBtn.setImage(playImage, for: .normal)
            }
            else{
                audioPlayer.play()
                playPauseBtn.setImage(pauseImage, for: .normal)
            }
            
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            
        }
        
        @IBAction func audioSlider(_ sender: UISlider) {
            audioPlayer.stop()
            audioPlayer.currentTime = TimeInterval(audioSlider.value)
            updateTime()
            
            playPauseBtn.setImage(playImage, for: .normal)
        }
        
        @objc func updateSlider(){
            audioSlider.value = Float(audioPlayer.currentTime)
        }
        
        @objc func totalDuration(){
            let duration = Int(audioPlayer.duration)
            let durationMinutes = duration/60
            let durationSeconds = duration-durationMinutes*60
            let durationLabel = durationMinutes
            durationLbl.text = "\(durationLabel) Min"
            
            currentTimeLbl.text = "00:00"
            
            let totalDuration = String(format: "%02d:%02d", durationMinutes, durationSeconds) as String
            remainingTimeLbl.text = "\(totalDuration)"
        }
        
        @objc func updateTime() {
            let duration = Int(audioPlayer.duration)
            let durationMinutes = duration/60
            let durationSeconds = duration - durationMinutes * 60

            let currentTime = Int(audioPlayer.currentTime)
            let currentMinutes = currentTime/60
            let currentSeconds = currentTime - currentMinutes * 60
            let totalCurrentTime = String(format: "%02i:%02i", currentMinutes,currentSeconds) as String
            currentTimeLbl.text = totalCurrentTime

            let remainingMinutes = durationMinutes-currentMinutes
            let remainingSeconds = durationSeconds-currentSeconds
            let totalRemaining = String(format: "%02i:%02i", remainingMinutes,remainingSeconds) as String
            remainingTimeLbl.text = totalRemaining
           
//            Countdown Remaining Time
            if totalRemaining=="00:00" {
                audioPlayer.stop()
            }
        }
    
    func setStatusBar(){
        let imageForThumb = UIImage(named: "img_circle.png")
        audioSlider.setThumbImage(imageForThumb, for: .normal)
        audioSlider.minimumTrackTintColor = UIColor.orange
        audioSlider.maximumTrackTintColor = UIColor.gray
        audioSlider.maximumValue = Float(audioPlayer.duration)
    }
}
