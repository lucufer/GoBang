//
//  Canvas.swift
//  gobang
//
//  Created by 千锋1 on 16/8/18.
//  Copyright © 2016年 琼极无限. All rights reserved.
//

import UIKit
import AVFoundation

protocol Delegate:class{
    func alert(canvas:Canvas,msg:String,isClear:Bool)
}
class Canvas: UIView {
    var player:AVAudioPlayer!
    weak var delegate:Delegate?
    
    let board = Board()
    var index1:Int?
    var index2:Int?
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first{
            let touchPoint = touch.locationInView(self)
            let col = lround(Double(touchPoint.x - 5) / 22)
            let row = lround(Double(touchPoint.y-5) / 22)
            if board.board[row][col] == State.Space{
                board.makeMove(row, col: col)
               // let sss = board.culScoreRight1(9, col: 5)
                index1 = row
                index2 = col
                if board.judge(row, col: col) {
                    if board.isBlack {
                        self.delegate?.alert(self, msg: "白棋胜",isClear: true)
                        board.isBlack = true
                        
                    }
                    else{
                        self.delegate?.alert(self, msg: "黑棋胜",isClear: true)
                        board.isBlack = true
                    }
                    playAudio("victory.wav")
                }
                else{
                    board.computerDown()
                    let a = board.theBaseOne()
                    board.makeMove(a.0, col: a.1)
                    playAudio("down.wav")
                    if board.judge(a.0, col: a.1) {
                        if board.isBlack {
                            self.delegate?.alert(self, msg: "白棋胜",isClear: true)
                            board.isBlack = true
                            
                        }
                        else{
                            self.delegate?.alert(self, msg: "黑棋胜",isClear: true)
                            board.isBlack = true
                        }
                         playAudio("victory.wav")
                    }
                   
                }
                setNeedsDisplay()
            }
        }
    }
    func clearBoard(){
        for i in 0...14{
            for j in 0...14{
               board.board[i][j] = State.Space
                
            }
        }
        setNeedsDisplay()
    }
    
    func regret(){
        if let i = index1 {
            if let j = index2{
                board.board[i][j] = .Space
                setNeedsDisplay()
                index1 = nil
                index2 = nil
                board.isBlack = board.isBlack ? false:true
            }
        }
        else{
            self.delegate?.alert(self, msg: "你还没下棋，无法悔棋",isClear: false)
        }
        
    }
    
    func playAudio(url:String){
        if let url1 = NSBundle.mainBundle().URLForResource(url, withExtension: nil){
            player = try! AVAudioPlayer(contentsOfURL: url1)
            player.play()
        }
    }
    
    override func drawRect(rect: CGRect) {
        board.draw()
    }


}
