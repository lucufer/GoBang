 //
//  Board.swift
//  gobang
//
//  Created by 千锋1 on 16/8/18.
//  Copyright © 2016年 琼极无限. All rights reserved.
//

import UIKit

enum State{
    case Space,Black,White
}

//extension CGPoint{
//    
//    
//    func myPoint(x:Int,y:Int) -> CGPoint{
//        
//        return CGPointMake(CGFloat(x), CGFloat(y))
//    }
//}

class Board {
    var board:[[State]]
    var isBlack = true
    var sorce:[[Int]]
    init(){
        
        board = [[State]](count: 15, repeatedValue: [State](count: 15, repeatedValue: .Space))
        sorce = [[Int]](count: 15, repeatedValue: [Int](count: 15, repeatedValue: 0))
    }
    
    
    func makeMove(row:Int,col:Int){
        
        board[row][col] = isBlack ? .Black:.White
        isBlack = !isBlack
    }
    
    func judge(row:Int,col:Int) -> Bool{
        return judgeHeight(row, col: col) || judgeWidth(row, col: col) || judgeLeft(row, col: col) || judgeRight(row, col: col)
    }
    
    func judgeWidth(row:Int,col:Int) -> Bool{
        var courrentCol = col + 1
        var count = 1
        while courrentCol <= 14{
            if board[row][courrentCol] == board[row][col]{
                count += 1
            }
            else{
                break
            }
            courrentCol += 1
        }
        courrentCol = col - 1
        while courrentCol >= 0 {
            if board[row][courrentCol] == board[row][col]{
                count += 1
            }
            else{
                break
            }
            courrentCol -= 1
        }
        if count >= 5{
            return true
        }
        else{
            return false
        }
    }
    
    func judgeHeight(row:Int,col:Int) -> Bool{
        var courrentRow = row + 1
        var count = 1
        while courrentRow <= 14{
            if board[courrentRow][col] == board[row][col]{
                count += 1
            }
            else{
                break
            }
            courrentRow += 1
        }
        courrentRow = row - 1
        while courrentRow >= 0 {
            if board[courrentRow][col] == board[row][col]{
                count += 1
            }
            else{
                break
            }
            courrentRow -= 1
        }
        if count >= 5{
            return true
        }
        else{
            return false
        }
    }
    
    func judgeLeft(row:Int,col:Int) -> Bool{
        var courrentRow = row + 1
        var courrentCol = col + 1
        var count = 1
        while courrentCol <= 14 && courrentRow <= 14{
            if board[courrentRow][courrentCol] == board[row][col]{
                count += 1
            }
            else{
                break
            }
            courrentRow += 1
            courrentCol += 1
        }
        courrentRow = row - 1
        courrentCol = col - 1
        while courrentRow >= 0 && courrentCol >= 0{
            if board[courrentRow][courrentCol] == board[row][col]{
                count += 1
            }
            else{
                break
            }
            courrentRow -= 1
            courrentCol -= 1
        }
        if count >= 5{
            return true
        }
        else{
            return false
        }
    }
    
    func judgeRight(row:Int,col:Int) -> Bool{
        var courrentRow = row + 1
        var courrentCol = col - 1
        var count = 1
        while courrentCol >= 0 && courrentRow <= 14{
            if board[courrentRow][courrentCol] == board[row][col]{
                count += 1
            }
            else{
                break
            }
            courrentRow += 1
            courrentCol -= 1
        }
        courrentRow = row - 1
        courrentCol = col + 1
        while courrentRow >= 0 && courrentCol <= 14{
            if board[courrentRow][courrentCol] == board[row][col]{
                count += 1
            }
            else{
                break
            }
            courrentRow -= 1
            courrentCol += 1
        }
        if count >= 5{
            return true
        }
        else{
            return false
        }
    }
    func skyEye(x:Int,_ y:Int){
        let circle = UIBezierPath(arcCenter: CGPoint.init(x: x, y: y), radius: 3, startAngle: -CGFloat(M_PI), endAngle: CGFloat(M_PI), clockwise: true)
        UIColor.blackColor().setFill()
        circle.fill()
    }
    
    func culScoreWidth(row:Int,col:Int) -> Int{
        var score = 0
        var courrentCol = col + 1
        var count = 0
        var spaceCount = 0
        while courrentCol <= 14{
            if board[row][courrentCol] == .White{
                count += 1
            }
            else{
                if board[row][courrentCol] == .Space{
                    spaceCount += 1
                }
                break
            }
            courrentCol += 1
        }
        courrentCol = col - 1
        while courrentCol >= 0 {
            if board[row][courrentCol] == .White{
                count += 1
                
            }
            else{
                if board[row][courrentCol] == .Space{
                    spaceCount += 1
                }
                break
            }
            courrentCol -= 1
        }
        switch count{
        case 0:
            score += 0
        case 1:
            score += 50
        case 2:
            if spaceCount == 2{
                score += 1000
            }
            else if spaceCount == 1{
                score += 100
            }
        case 3:
            if spaceCount == 2{
                score += 5000
            }
            else if spaceCount == 1{
                score += 2000
            }
        default:
            if spaceCount != 0{
                score += 50000
            }
        }
        return score
    }
    
    func culScoreHeight(row:Int,col:Int) -> Int{
        var score = 0
        var courrentRow = row + 1
        var count = 0
        var spaceCount = 0
        while courrentRow <= 14{
            if board[courrentRow][col] == .White{
                count += 1
            }
            else{
                if board[courrentRow][col] == .Space{
                    spaceCount += 1
                }
                break
            }
            courrentRow += 1
        }
        courrentRow = row - 1
        while courrentRow >= 0 {
            if board[courrentRow][col] == .White{
                count += 1
            }
            else{
                if board[courrentRow][col] == .Space{
                    spaceCount += 1
                }
                break
            }
            courrentRow -= 1
        }
        switch count{
        case 0:
            score += 0
        case 1:
            score += 50
        case 2:
            if spaceCount == 2{
                score += 1000
            }
            else if spaceCount == 1{
                score += 100
            }
        case 3:
            if spaceCount == 2{
                score += 5000
            }
            else if spaceCount == 1{
                score += 2000
            }
        default:
            if spaceCount != 0{
                score += 50000
            }
        }
        return score
    }
    
    func culScoreLeft(row:Int,col:Int) -> Int{
        var score = 0
        var courrentRow = row + 1
        var courrentCol = col + 1
        var count = 0
        var spaceCount = 0
        while courrentCol <= 14 && courrentRow <= 14{
            if board[courrentRow][courrentCol] == .White{
                count += 1
            }
            else{
                if board[courrentRow][courrentCol] == .Space{
                    spaceCount += 1
                }
                break
            }
            courrentRow += 1
            courrentCol += 1
        }
        courrentRow = row - 1
        courrentCol = col - 1
        while courrentRow >= 0 && courrentCol >= 0 {
            if board[courrentRow][courrentCol] == .White{
                count += 1
            }
            else{
                if board[courrentRow][courrentCol] == .Space{
                    spaceCount += 1
                }
                break
            }
            courrentRow -= 1
            courrentCol -= 1
        }
        switch count{
        case 0:
            score += 0
        case 1:
            score += 50
        case 2:
            if spaceCount == 2{
                score += 1000
            }
            else if spaceCount == 1{
                score += 100
            }
        case 3:
            if spaceCount == 2{
                score += 5000
            }
            else if spaceCount == 1{
                score += 2000
            }
        default:
            if spaceCount != 0{
                score += 50000
            }
        }
        return score
    }
    
    func culScoreRight(row:Int,col:Int) -> Int{
        var score = 0
        var courrentRow = row + 1
        var courrentCol = col - 1
        var count = 0
        var spaceCount = 0
        while courrentCol >= 0 && courrentRow <= 14{
            if board[courrentRow][courrentCol] == .White{
                count += 1
            }
            else{
                if board[courrentRow][courrentCol] == .Space{
                    spaceCount += 1
                }
                break
            }
            courrentRow += 1
            courrentCol -= 1
        }
        courrentRow = row - 1
        courrentCol = col + 1
        while courrentRow >= 0 && courrentCol <= 14 {
            if board[courrentRow][courrentCol] == .White{
                count += 1
            }
            else{
                if board[courrentRow][courrentCol] == .Space{
                    spaceCount += 1
                }
                break
            }
            courrentRow -= 1
            courrentCol += 1
        }
        switch count{
        case 0:
            score += 0
        case 1:
            score += 50
        case 2:
            if spaceCount == 2{
                score += 1000
            }
            else if spaceCount == 1{
                score += 100
            }
        case 3:
            if spaceCount == 2{
                score += 5000
            }
            else if spaceCount == 1{
                score += 2000
            }
        default:
            if spaceCount != 0{
                score += 50000
            }
        }
        return score
    }
    
    func culScoreWidth1(row:Int,col:Int) -> Int{
        var score = 0
        var courrentCol = col + 1
        var count = 0
        var spaceCount = 0
        while courrentCol <= 14{
            if board[row][courrentCol] == .Black{
                count += 1
            }
            else{
                if board[row][courrentCol] == .Space{
                    spaceCount += 1
                }
                break
            }
            courrentCol += 1
        }
        courrentCol = col - 1
        while courrentCol >= 0 {
            if board[row][courrentCol] == .Black{
                count += 1
            }
            else{
                if board[row][courrentCol] == .Space{
                    spaceCount += 1
                }
                break
            }
            courrentCol -= 1
        }
        switch count{
        case 0:
            score += 0
        case 1:
            score -= 50
        case 2:
            if spaceCount == 2{
                score -= 999
            }
            else if spaceCount == 1{
                score -= 100
            }
        case 3:
            if spaceCount == 2{
                score -= 5500
            }
            else if spaceCount == 1{
                score -= 2000
            }
        default:
            if spaceCount != 0{
                score -= 55000
            }
        }
        return score
    }
    
    func culScoreHeight1(row:Int,col:Int) -> Int{
        var score = 0
        var courrentRow = row + 1
        var count = 0
        var spaceCount = 0
        while courrentRow <= 14{
            if board[courrentRow][col] == .Black{
                count += 1
            }
            else{
                if board[courrentRow][col] == .Space{
                    spaceCount += 1
                }
                break
            }
            courrentRow += 1
        }
        courrentRow = row - 1
        while courrentRow >= 0 {
            if board[courrentRow][col] == .Black{
                count += 1
            }
            else{
                if board[courrentRow][col] == .Space{
                    spaceCount += 1
                }
                break
            }
            courrentRow -= 1
        }
        switch count{
        case 0:
            score += 0
        case 1:
            score -= 50
        case 2:
            if spaceCount == 2{
                score -= 999
            }
            else if spaceCount == 1{
                score -= 100
            }
        case 3:
            if spaceCount == 2{
                score -= 5500
            }
            else if spaceCount == 1{
                score -= 2000
            }
        default:
            if spaceCount != 0{
                score -= 55000
            }
        }
        return score
    }
    
    func culScoreLeft1(row:Int,col:Int) -> Int{
        var score = 0
        var courrentRow = row + 1
        var courrentCol = col + 1
        var count = 0
        var spaceCount = 0
        while courrentCol <= 14 && courrentRow <= 14{
            if board[courrentRow][courrentCol] == .Black{
                count += 1
            }
            else{
                if board[courrentRow][courrentCol] == .Space{
                    spaceCount += 1
                }
                break
            }
            courrentRow += 1
            courrentCol += 1
        }
        courrentRow = row - 1
        courrentCol = col - 1
        while courrentRow >= 0 && courrentCol >= 0 {
            if board[courrentRow][courrentCol] == .Black{
                count += 1
            }
            else{
                if board[courrentRow][courrentCol] == .Space{
                    spaceCount += 1
                }
                break
            }
            courrentRow -= 1
            courrentCol -= 1
        }
        switch count{
        case 0:
            score += 0
        case 1:
            score -= 50
        case 2:
            if spaceCount == 2{
                score -= 999
            }
            else if spaceCount == 1{
                score -= 100
            }
        case 3:
            if spaceCount == 2{
                score -= 5500
            }
            else if spaceCount == 1{
                score -= 2000
            }
        default:
            if spaceCount != 0{
                score -= 55000
            }
        }
        return score
    }
    
    func culScoreRight1(row:Int,col:Int) -> Int{
        var score = 0
        var courrentRow = row + 1
        var courrentCol = col - 1
        var count = 0
        var spaceCount = 0
        while courrentCol >= 0 && courrentRow <= 14{
            if board[courrentRow][courrentCol] == .Black{
                count += 1
            }
            else{
                if board[courrentRow][courrentCol] == .Space{
                    spaceCount += 1
                }
                break
            }
            courrentRow += 1
            courrentCol -= 1
        }
        courrentRow = row - 1
        courrentCol = col + 1
        while courrentRow >= 0 && courrentCol <= 14 {
            if board[courrentRow][courrentCol] == .Black{
                count += 1
            }
            else{
                if board[courrentRow][courrentCol] == .Black{
                    spaceCount += 1
                }
                break
            }
            courrentRow -= 1
            courrentCol += 1
        }
        switch count{
        case 0:
            score += 0
        case 1:
            score -= 50
        case 2:
            if spaceCount == 2{
                score -= 999
            }
            else if spaceCount == 1{
                score -= 100
            }
        case 3:
            if spaceCount == 2{
                score -= 5500
            }
            else if spaceCount == 1{
                score -= 2000
            }
        default:
            if spaceCount != 0{
                score -= 55000
            }
        }
        return score
    }

    func judgeWhiteScore(row:Int,col:Int) -> Int{
        let score = culScoreHeight(row, col: col) + culScoreLeft(row, col: col) + culScoreRight(row, col: col) + culScoreWidth(row, col: col)
        return score
    }
    func judgeBlackScore(row:Int,col:Int) -> Int{
        let score = culScoreHeight1(row, col: col) + culScoreLeft1(row, col: col) + culScoreRight1(row, col: col) + culScoreWidth1(row, col: col)
        return abs(score)
    }
    
    func computerDown(){
        for i in 0...14{
            for j in 0...14{
                if board[i][j] == .Space{
                    let score = judgeWhiteScore(i, col: j)
                    let score1 = judgeBlackScore(i, col: j)
                    sorce[i][j] = score > score1 ? score:score1
                }
                else {
                    sorce[i][j] = 0
                }
            }
        }
    }
    
    func theBaseOne() -> (Int,Int){
        var max = sorce[0][0]
        var tuple = (0,0)
        for i in 0...14{
            for (index,value) in sorce[i].enumerate(){
                if board[i][index] == .Space{
                    if max < value{
                        max = value
                        tuple = (i,index)
                    }
                }
            }
        }
        return tuple
    }
    
    func draw(){
        let line = UIBezierPath()
        for i in 0...14{
            let row = CGFloat(i)
            line.moveToPoint(CGPointMake(5, 5+row*22))
            line.addLineToPoint(CGPointMake(313, 5+row*22))
            line.moveToPoint(CGPointMake(5+row*22, 5))
            line.addLineToPoint(CGPointMake(5+row*22, 313))
            
        }
        line.lineWidth = 1
        UIColor.blackColor().setStroke()
        line.stroke()
        
        skyEye(71, 71)
        skyEye(247, 71)
        skyEye(71, 247)
        skyEye(247, 247)
        skyEye(159, 159)
        
        let border = UIBezierPath(rect: CGRectMake(0, 0, 318, 318))
        border.lineWidth = 5
        UIColor.blackColor().set()
        border.stroke()
        for row in 0...14{
            for col in 0...14{
                if board[row][col] != State.Space{
                    let circle = UIBezierPath(arcCenter: CGPoint.init(x: col*22+5, y: row*22+5), radius: 8, startAngle: -CGFloat(M_PI), endAngle: CGFloat(M_PI), clockwise: true)
                    (board[row][col] == .Black ? UIColor.blackColor(): UIColor.whiteColor()).setFill()
                    circle.fill()
                }
            }
        }
    }
}