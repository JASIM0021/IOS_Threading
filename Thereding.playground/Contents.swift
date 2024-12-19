import UIKit

var greeting = "Hello, playground"

DispatchQueue.main.async {
    
    print(Thread.isMainThread ? "Execution on Main thread" : "Execution on Other Thread")
}

DispatchQueue.global().async {
    print(Thread.isMainThread ? "Execution on Main thread" : "Execution on Other Thread global thread")
}
