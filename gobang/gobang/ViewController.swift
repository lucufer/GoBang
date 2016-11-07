//
//  ViewController.swift
//  gobang
//
//  Created by 千锋1 on 16/8/18.
//  Copyright © 2016年 琼极无限. All rights reserved.
//

import UIKit


class ViewController: UIViewController,Delegate {
    
    var canvas = Canvas()
    override func viewDidLoad() {
        canvas = Canvas(frame:CGRectMake(0,0,318,318))
        canvas.center = self.view.center
        canvas.delegate = self
        //canvas.backgroundColor = UIColor(red: 252.0/255.0, green: 94.0/255.0, blue: 89.0/255.0, alpha: 1)
        canvas.backgroundColor = UIColor.clearColor()
        self.view.addSubview(canvas)
        
    }
    
    @IBAction func reset(sender: AnyObject) {
        let alertContorll = UIAlertController(title: "提示", message: "是否重置", preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "确定", style: .Default){action in
            self.canvas.clearBoard()
        }
        let cancleAction = UIAlertAction(title: "取消", style: .Default, handler: nil)
        alertContorll.addAction(alertAction)
        alertContorll.addAction(cancleAction)
        self.presentViewController(alertContorll, animated: true, completion: nil)
    }

    @IBAction func regret(sender: AnyObject) {
        canvas.regret()
    }
        
    func alert(canvas: Canvas, msg: String,isClear:Bool) {
        let alertContorll = UIAlertController(title: "提示", message: msg, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "确定", style: .Default){action in
            if isClear{
                canvas.clearBoard()
            }
        }
        alertContorll.addAction(alertAction)
        self.presentViewController(alertContorll, animated: true, completion: nil)
    }
}

