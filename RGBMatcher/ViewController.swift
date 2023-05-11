//
//  ViewController.swift
//  RGBMatcher
//
//  Created by Joel Joseph
//

import UIKit

class ViewController: UIViewController {
    
    var match = UILabel()
    var label = UILabel()
    var label2 = UILabel()
    var set = UILabel()
    var matchB = UILabel()
    var setB = UILabel()
    var red = CGFloat()
    var green = CGFloat()
    var blue = CGFloat()
    var redTarget = CGFloat()
    var greenTarget = CGFloat()
    var blueTarget = CGFloat()
    var timeRemaining: Int = 10
    var timer: Timer!
    var distanceS = Int()
    @IBOutlet var left: UILabel!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matchB.frame = CGRect(x: 15, y: 145, width: 160, height: 210 )
        matchB.backgroundColor = .black
        matchB.layer.cornerRadius = 5
        view.addSubview(matchB)
        setB.frame = CGRect(x: 210, y: 145, width: 160, height: 210 )
        setB.backgroundColor = .black
        setB.layer.cornerRadius = 5
        view.addSubview(setB)
        set.frame = CGRect(x: 215, y: 150, width: 150, height: 200 )
        set.backgroundColor = random()
        set.layer.cornerRadius = 5
        view.addSubview(set)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
        
    }
    func random() -> UIColor {
        red = CGFloat.random(in: 0..<1)
        blue = CGFloat.random(in: 0..<1)
        green = CGFloat.random(in: 0..<1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
    }
    @IBAction func colorChanger(_ sender: AnyObject) {
        redTarget = Double(redSlider.value)
        blueTarget = Double(blueSlider.value)
        greenTarget = Double(greenSlider.value)
        match.frame = CGRect(x: 20, y: 150, width: 150, height: 200 )
        match.layer.cornerRadius = CGFloat(5)
        match.backgroundColor = UIColor(red:redTarget, green:greenTarget, blue:blueTarget, alpha:1.0)
        view.addSubview(match)
        
    }
    func score() -> Int {
        redTarget = Double(redSlider.value)
        blueTarget = Double(blueSlider.value)
        greenTarget = Double(greenSlider.value)
        let redDiff = red - redTarget
        let greenDiff = green - greenTarget
        let blueDiff = blue - blueTarget
        let diff = sqrt(redDiff * redDiff + greenDiff * greenDiff + blueDiff * blueDiff)
        distanceS = Int((1.0 - diff) * 100.0 + 0.5)
        return distanceS
        
    }
    @objc func step() {
        
        if timeRemaining > 0 {
            timeRemaining -= 1
            label.removeFromSuperview()
            
        } else {
            timer.invalidate()
            timeRemaining = 10
            label.removeFromSuperview()
            // Create new Alert
            let dialogMessage = UIAlertController(title: "Score", message: "Your score is \(score())", preferredStyle: .alert)
            // Create OK button with action handler
            let ok = UIAlertAction(title: "Restart ", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
            })
            //Add OK button to a dialog message
            dialogMessage.addAction(ok)
            // Present Alert to
            self.present(dialogMessage, animated: true, completion: nil)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
            red = 0
            blue = 0
            green = 0
            redSlider.value = 0
            greenSlider.value = 0
            blueSlider.value = 0
            set.backgroundColor = random()
            
        }
        label = UILabel(frame: CGRect(x: 50, y: 50, width: 400,height: 21))
        label.text = "Time Left: \(timeRemaining)"
        view.addSubview(label)
        
    }
}
