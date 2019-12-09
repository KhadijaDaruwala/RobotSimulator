//
//  ViewController.swift
//  Robot
//
//  Created by Khadija on 08/12/19.
//  Copyright © 2019 Robot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableImageView: UIImageView!
    @IBOutlet weak var robotImageView: UIImageView!
    @IBOutlet weak var placeButton: UIButton!
    @IBOutlet weak var moveButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var reportButton: UIButton!

    var robot = Robot()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        robotImageView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUp()
    }
    
    func setUp(){
        setButtonEnable()
        robot.owner = self
        robot.maxWidth = Int(tableImageView.frame.width - robotImageView.frame.width)
        robot.maxHeight = Int(tableImageView.frame.height - robotImageView.frame.height)
        robot.movementLenght = robot.maxWidth/5
    }
    
    func setButtonEnable(){
        if robotImageView.isHidden {
            moveButton.alpha = 0.2
            leftButton.alpha = 0.2
            rightButton.alpha = 0.2
            reportButton.alpha = 0.2
            moveButton.isUserInteractionEnabled = false
            leftButton.isUserInteractionEnabled = false
            rightButton.isUserInteractionEnabled = false
            reportButton.isUserInteractionEnabled = false

        } else {
            moveButton.alpha = 1.0
            leftButton.alpha = 1.0
            rightButton.alpha = 1.0
            reportButton.alpha = 1.0
            moveButton.isUserInteractionEnabled = true
            leftButton.isUserInteractionEnabled = true
            rightButton.isUserInteractionEnabled = true
            reportButton.isUserInteractionEnabled = true
        }
    }
    
    func placeRobot(){
        robotImageView.isHidden = false
        robot.xpos = 0
        robot.ypos = robot.maxHeight
        robot.direction = .Up
        updateRobotPosition()
        updateRobotImage()
    }
    
    func updateRobotPosition() {
        var frame = robotImageView.frame
        frame.origin.x = CGFloat(robot.xpos)
        frame.origin.y = CGFloat(robot.ypos)
        robotImageView.frame = frame
    }
    
    func updateRobotImage() {
        switch robot.direction {
        case .Left:
            robotImageView.image = UIImage.init(named: "leftRobot")
        case .Right:
            robotImageView.image = UIImage.init(named: "rightRobot")
        case .Up:
            robotImageView.image = UIImage.init(named: "upRobot")
        case .Down:
            robotImageView.image = UIImage.init(named: "downRobot")
        }
    }
    
    // MARK: - Actons
    @IBAction func placeAction(_ sender: Any) {
        placeRobot()
        setButtonEnable()
    }
    
    @IBAction func moveAction(_ sender: Any) {
        switch robot.direction {
        case .Left:
            robot.leftMove(isOnlyCheck: false)
        case .Right:
            robot.rightMove(isOnlyCheck: false)
        case .Up:
            robot.upMove(isOnlyCheck: false)
        case .Down:
            robot.downMove(isOnlyCheck: false)
        }
    }
    
    @IBAction func reportAction(_ sender: Any) {
        robot.showReport()
    }
    
    @IBAction func leftAction(_ sender: Any) {
        // Rotate the robot 90 degree according to Left direction
        switch robot.direction {
        case .Left:
            robot.direction = .Down
            robot.downMove(isOnlyCheck: true)
        case .Right:
            robot.direction = .Up
            robot.upMove(isOnlyCheck: true)
        case .Up:
            robot.direction = .Left
            robot.leftMove(isOnlyCheck: true)
        case .Down:
            robot.direction = .Right
            robot.rightMove(isOnlyCheck: true)
        }
        updateRobotImage()
    }
    
    @IBAction func rightAction(_ sender: Any) {
        // Rotate the robot 90 degree according to Right direction
        switch robot.direction {
        case .Left:
            robot.direction = .Up
            robot.upMove(isOnlyCheck: true)
        case .Right:
            robot.direction = .Down
            robot.downMove(isOnlyCheck: true)
        case .Up:
            robot.direction = .Right
            robot.rightMove(isOnlyCheck: true)
        case .Down:
            robot.direction = .Left
            robot.leftMove(isOnlyCheck: true)
        }
        updateRobotImage()
    }
}

