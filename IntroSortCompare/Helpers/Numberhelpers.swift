//
//  Numberhelpers.swift
//  DataStructures
//
//  Created by Giuseppe Lanza on 02/11/16.
//  Copyright © 2016 La nuova Era. All rights reserved.
//

import Foundation

struct MyUInt64 {
    let value: UInt64
}

class MyUInt64Object: NSObject {
    let value: UInt64
    init(value: UInt64) {
        self.value = value
        super.init()
    }
}

func <(lhs: MyUInt64, rhs: MyUInt64)->Bool {
    return lhs.value < rhs.value
}
func ==(lhs: MyUInt64, rhs: MyUInt64)->Bool {
    return lhs.value == rhs.value
}

func <(lhs: MyUInt64Object, rhs: MyUInt64Object)->Bool {
    return lhs.value < rhs.value
}



@discardableResult public func measureAverageTime(printString: String? = nil,
                                                  repeating count: Int = 100,
                                                  compareWith otherTime: TimeInterval? = nil,
                                                  stringForCompareString compareString: String? = nil,
                                                  for closure: ()->())->TimeInterval {
    var measuredTimes = [TimeInterval]()
    for _ in 0..<count {
        let testTimeStamp = Date()
        
        closure()
        
        let sortTime = NSDate().timeIntervalSince(testTimeStamp)
        measuredTimes.append(sortTime)
    }
    
    let time = measuredTimes.average()
    let devStd = measuredTimes.stdDev()
    
    if let string = printString {
        var toPrint = string + " \(time.scientificStyle) ± \(devStd.scientificStyle)"
        if let other = otherTime {
            let ratio = round(10*(time/other))/10
            
            if ratio == 1 {
                toPrint += "\t\t | ~ equal to"
            } else if ratio > 1 {
                toPrint += "\t\t | \(ratio) times slower than"
            } else {
                toPrint += "\t\t | \(round(10*(other/time))/10) times faster than"
            }
            
            if let than = compareString {
                toPrint += "\(than)"
            }
        }

        print(toPrint)
    }

    
    return time
}

extension Double {
    struct NumberFormatterContainter {
        static var formatter = NumberFormatter()
    }
    var scientificStyle: String {
        NumberFormatterContainter.formatter.numberStyle = .scientific
        NumberFormatterContainter.formatter.positiveFormat = "0.#E+0"
        NumberFormatterContainter.formatter.exponentSymbol = " * 10^"
        return NumberFormatterContainter.formatter.string(from: self as NSNumber) ?? description
    }
}

extension Array where Element == Double {
    func average()->Double {
        let count = self.count
        return self.reduce(Double(0), { $0 + $1/Double(count) })
    }
    
    func stdDev()->Element {
        let count = Double(self.count)
        let average = self.average()
        let sumOfSquaredAvgDiff = self.map { pow($0 - average, 2.0)}.reduce(0, {$0 + $1})
        return sqrt(sumOfSquaredAvgDiff / count)
    }
}
