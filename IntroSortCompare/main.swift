//
//  main.swift
//  IntroSortCompare
//
//  Created by Giuseppe Lanza on 16/12/2017.
//  Copyright © 2017 Giuseppe Lanza. All rights reserved.
//


import Foundation

//MARK: - Preparation
var objectArray = [MyUInt64Object]()
var nonComparableArray = [MyUInt64]()
var comparableArray = [UInt64]()
var rng = PRNG(seed: 87364965)
for _ in 0..<100000 {
    let number = rng.getRandomNumber()
    objectArray.append(MyUInt64Object(value: number))
    nonComparableArray.append(MyUInt64(value: number))
    comparableArray.append(number)
}

//MARK: BinaryTree

let quickSorted = comparableArray.quickSorted(by: <)
let introSorted = comparableArray.introSorted(by: <)
let mergeSorted = comparableArray.mergeSorted(by: <)
let heapSorted = comparableArray.heapSorted(by: <)
let insertionSorted = comparableArray.insertionSorted(by: <)
let sorted = comparableArray.sorted()

print("""
    -- ALGORITHM SANITY CHECK --
    quickSort: \(quickSorted == sorted)
    introSort: \(introSorted == sorted)
    mergeSort: \(mergeSorted == sorted)
    heapSort: \(heapSorted == sorted)
    insertionSort: \(insertionSorted == sorted)
    
    
    
    """)

print("\n-- Sorting algorithms comparison --")
print("♦️ - Comparable Array\n")

let time = measureAverageTime(printString: "🔸 Swift sort: ") { _ = comparableArray.sorted(by: <) }
measureAverageTime(printString: "🔶 No predicate: ",
                   compareWith: time,
                   stringForCompareString: " swift sort with a predicate") { _ = comparableArray.sorted() }

measureAverageTime(printString: "\nIntrosort: ",
                   compareWith: time,
                   stringForCompareString: " swift sort") { _ = comparableArray.introSorted(by: <) }
measureAverageTime(printString: "QuickSort: ",
                   compareWith: time,
                   stringForCompareString: " swift sort") { _ = comparableArray.quickSorted(by: <) }
measureAverageTime(printString: "HeapSort: ",
                   compareWith: time,
                   stringForCompareString: " swift sort") { _ = comparableArray.heapSorted(by: <) }
measureAverageTime(printString: "MergeSort: ",
                   compareWith: time,
                   stringForCompareString: " swift sort") { _ = comparableArray.mergeSorted(by: <) }
measureAverageTime(printString: "InsertSort: ",
                   repeating: 1,
                   compareWith: time,
                   stringForCompareString: " swift sort") { _ = comparableArray.insertionSorted(by: <) }

print("\n♣️ -- Is it the same for non comparable? --\n")

let nonComparableTime = measureAverageTime(printString: "🔸 Swift sort: ",
                                           compareWith: time,
                                           stringForCompareString: " swift comparable sort") { _ = nonComparableArray.sorted(by: <) }

measureAverageTime(printString: "\nIntrosort: ",
                   compareWith: nonComparableTime,
                   stringForCompareString: " swift non comparable sort") { _ = nonComparableArray.introSorted(by: <) }
measureAverageTime(printString: "QuickSort: ",
                   compareWith: nonComparableTime,
                   stringForCompareString: " swift non comparable sort") { _ = nonComparableArray.quickSorted(by: <) }
measureAverageTime(printString: "HeapSort: ",
                   compareWith: nonComparableTime,
                   stringForCompareString: " swift non comparable sort") { _ = nonComparableArray.heapSorted(by: <) }
measureAverageTime(printString: "MergeSort: ",
                   compareWith: nonComparableTime,
                   stringForCompareString: " swift non comparable sort") { _ = nonComparableArray.mergeSorted(by: <) }
measureAverageTime(printString: "InsertSort: ",
                   repeating: 1,
                   compareWith: nonComparableTime,
                   stringForCompareString: " swift non comparable sort") { _ = nonComparableArray.insertionSorted(by: <) }

print("\n♠️ -- And what about array of NSObjects? --\n")

let objectTime = measureAverageTime(printString: "🔴 Swift sort: ",
                                    compareWith: time,
                                    stringForCompareString: " swift comparable sort") { _ = objectArray.sorted(by: <) }
measureAverageTime(printString: "\nIntrosort: ",
                   compareWith: objectTime,
                   stringForCompareString: " swift NSObject sort") { _ = objectArray.introSorted(by: <) }
measureAverageTime(printString: "QuickSort: ",
                   compareWith: objectTime,
                   stringForCompareString: " swift NSObject sort") { _ = objectArray.quickSorted(by: <) }
measureAverageTime(printString: "MergeSort: ",
                   compareWith: objectTime,
                   stringForCompareString: " swift NSObject sort") { _ = objectArray.mergeSorted(by: <) }
measureAverageTime(printString: "HeapSort: ",
                   compareWith: objectTime,
                   stringForCompareString: " swift NSObject sort") { _ = objectArray.heapSorted(by: <) }

print("\n♥️ -- But if i know that the array is already sorted, and i add a value? --\n")

var mutableSorted = sorted
mutableSorted.append(rng.getRandomNumber())

let sortedTime = measureAverageTime(printString: "🔹 Swift sort: ",
                                    compareWith: time,
                                    stringForCompareString: " unsorted sort") { _ = mutableSorted.sorted(by: <) }
measureAverageTime(printString: "🔷 No predicate: ",
                   compareWith: time,
                   stringForCompareString: " swift sort with a predicate") { _ = mutableSorted.sorted() }
measureAverageTime(printString: "\nIntrosort: ",
                   compareWith: sortedTime,
                   stringForCompareString: " swift sort") { _ = mutableSorted.introSorted(by: <) }
measureAverageTime(printString: "QuickSort: ",
                   compareWith: sortedTime,
                   stringForCompareString: " swift sort") { _ = mutableSorted.quickSorted(by: <) }
measureAverageTime(printString: "HeapSort: ",
                   compareWith: sortedTime,
                   stringForCompareString: " swift sort") { _ = mutableSorted.heapSorted(by: <) }
measureAverageTime(printString: "MergeSort: ",
                   compareWith: sortedTime,
                   stringForCompareString: " swift sort") { _ = mutableSorted.mergeSorted(by: <) }
measureAverageTime(printString: "🔺 InsertSort: ",
                   compareWith: sortedTime,
                   stringForCompareString: " swift sort") { _ = mutableSorted.insertionSorted(by: <) }

