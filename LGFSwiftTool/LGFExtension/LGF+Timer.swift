//
//  LGF+Timer.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019 来国锋. All rights reserved.
//

#if canImport(UIKit)
import UIKit
import Foundation

public extension Timer {
    // MARK: - 初始化一个定时器
    @discardableResult
    class func lgf_RunTimer(_  target: UIViewController!, S: TimeInterval, handler: @escaping (Timer?) -> Void) -> Timer {
        let fireDate = CFAbsoluteTimeGetCurrent()
        let runLoop = CFRunLoopGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, S, 0, 0) { [weak target] (timer) in
            // 自动释放
            if target != nil {
                handler(timer)
            } else {
                CFRunLoopRemoveTimer(runLoop, timer, CFRunLoopMode.commonModes)
                CFRunLoopStop(runLoop)
            }
        }
        CFRunLoopAddTimer(runLoop, timer, CFRunLoopMode.commonModes)
        return timer!
    }
    
    // MARK: - 延时执行
    @discardableResult
    class func lgf_After(S: Double, after: @escaping () -> Void) -> DispatchWorkItem {
        return lgf_After(S: S, queue: DispatchQueue.main, after: after)
    }
    
    @discardableResult
    class func lgf_After(S: Double, queue: DispatchQueue, after: @escaping () -> Void) -> DispatchWorkItem {
        let time = DispatchTime.now() + Double(Int64(S * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        let wAfter = DispatchWorkItem.init(block: after)
        queue.asyncAfter(deadline: time, execute: wAfter)
        return wAfter
    }
}

#endif // canImport(UIKit)
