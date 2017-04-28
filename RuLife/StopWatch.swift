//
//  StopWatch.swift
//  RuLife
//
//  Created by Martin Sekerák on 10.03.16.
//  Copyright © 2016 Martin Sekerák. All rights reserved.
//

import Foundation
import UIKit

class StopWatch {
    
    private var startTime:NSDate?
    private var resumedTime:Double?
    
    internal var running:Bool = false
    
    var elapsedTime:NSTimeInterval {
        if let startTime = self.startTime {
            return -startTime.timeIntervalSinceNow
        }
        else {
            return 0
        }
    }
    
    var elapsedTimeAsMillis:NSInteger {
        if resumedTime != 0 {
            return Int(resumedTime! * 1000)
        }
        return 0
    }
    
    var elapsedTimeAsString:String {
        //return String(format:"%02d:%02d:%02d.%d", Int(elapsedTime / 3600), Int(elapsedTime / 60), Int(elapsedTime % 60), Int(elapsedTime * 10 % 10))
        return String(format:"%02d:%02d:%02d", Int(elapsedTime / 3600), Int(elapsedTime / 60), Int(elapsedTime % 60))
    }
    
    
    
    
    func isRunning() -> Bool {
        return running
    }
    
    func start() {
        startTime = NSDate()
        running = true
    }
    
    func pause() {
        resumedTime = elapsedTime
        print("Stop Pause :", resumedTime)
        startTime = nil
        running = false
    }
    
    func resume() {
        startTime = NSDate(timeIntervalSinceNow: -resumedTime!)
        running = true
    }
    
    func finish() {
        startTime = nil
        running = false
    }
    
    func reset() {
        startTime = nil
        running = false
    }
    
    
    
}