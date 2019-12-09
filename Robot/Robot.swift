//
//  swift
//  Robot
//
//  Created by Khadija on 08/12/19.
//  Copyright © 2019  All rights reserved.
//

import UIKit

enum robotDirection: Int {
    case Up
    case Right
    case Down
    case Left
}

class Robot: NSObject {
    var xpos:Int = 0
    var ypos:Int = 0
    var maxWidth:Int = 0
    var maxHeight:Int = 0
    var movementLenght:Int = 0
    var owner: ViewController?
    var direction: robotDirection = .Down
    
    func canMoveRobot(nextXpose:Int, nextYpos:Int) -> Bool {
        var canMove = false
        if nextXpose>=0&&nextYpos>=0&&nextXpose<=maxWidth&&nextYpos<=maxHeight {
            canMove = true
        }
        else {
            showReport()
        }
        return canMove
    }
    
    func showReport() {
        let cantMoveX = xpos/movementLenght
        let cantMoveY = (maxHeight-ypos)/movementLenght
        var displayDirection = "East"
        switch direction {
        case .Up:
            displayDirection = "North"
        case .Down:
            displayDirection = "South"
        case .Right:
            displayDirection = "East"
        case .Left:
            displayDirection = "West"
        }
        let reportMessage = "x: \(cantMoveX),  y: \(cantMoveY),  Direction:\(displayDirection)"
        let alert = UIAlertController(title: "REPORT", message: reportMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        owner?.present(alert, animated: true, completion: nil)
    }
    
    func upMove(isOnlyCheck:Bool) {
        direction = .Up
        if canMoveRobot(nextXpose: xpos, nextYpos: ypos - movementLenght) {
            if !isOnlyCheck {
                ypos = ypos - movementLenght
                owner?.updateRobotPosition()
            }
        }
    }
    
    func downMove(isOnlyCheck:Bool) {
        direction = .Down
        if canMoveRobot(nextXpose: xpos, nextYpos: ypos + movementLenght) {
            if !isOnlyCheck {
                ypos = ypos + movementLenght
                owner?.updateRobotPosition()
            }
        }
    }
    
    func leftMove(isOnlyCheck:Bool) {
        direction = .Left
        if canMoveRobot(nextXpose: xpos - movementLenght, nextYpos: ypos) {
            if !isOnlyCheck {
                xpos = xpos - movementLenght
                owner?.updateRobotPosition()
            }
        }
    }
    
    func rightMove(isOnlyCheck:Bool) {
        direction = .Right
        if canMoveRobot(nextXpose: xpos + movementLenght, nextYpos: ypos) {
            if !isOnlyCheck {
                xpos = xpos + movementLenght
                owner?.updateRobotPosition()
            }
        }
    }
}
