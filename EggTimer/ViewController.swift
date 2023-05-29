import UIKit
import AVFoundation

class ViewController: UIViewController {
    let eggTime = ["Soft": 5, "Medium": 10, "Hard": 15]
    var totalTime = 0
    var secondPass = 0
    var selectedEggType = ""
    var timer = Timer()
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        progressBar.progress = 1.0
    }
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var titleEggStatus: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        
        let hardness = sender.currentTitle
        selectedEggType = hardness ?? ""
        totalTime = eggTime[hardness ?? ""]!
        titleEggStatus.text = hardness ?? ""
        progressBar.progress = 1.0
        secondPass = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimer() {
        if secondPass < totalTime {
            secondPass += 1
            progressBar.progress = 1 - (Float(secondPass) / Float(totalTime))
        } else {
            playSound()
            totalTime = 0
            secondPass = 0
            timer.invalidate()
            switch selectedEggType {
            case "Soft":
                titleEggStatus.text = "Soft is done"
            case "Medium":
                titleEggStatus.text = "Medium is done"
            case "Hard":
                titleEggStatus.text = "Hard is done"
            default:
                print("Error")
            }
        }
    }
    
    func playSound() {
        let second: Double = 1000000
        usleep(useconds_t(0.2 * second))
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)
        
        player = try! AVAudioPlayer(contentsOf: url)
        player?.play()
        
    }
}
