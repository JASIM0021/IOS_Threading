import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var value: Int = 20
let serialQueue = DispatchQueue(label: "com.queue.Serial",attributes: .concurrent)

func doSyncTaskInSerialQueue() {
        for i in 1...3 {
            
            // MARK: if we used sync then the execution will happen inside the main thread
            /// It`s  not true that alwase the execution will happen in main thread
            /// it only happen when any custom thread block the execution of main thread
            /// if any other thread block the execution of main thread  then the all execution intelegently happen in main thread itself :)
            serialQueue.sync {
            if Thread.isMainThread{
                print("task running in main thread")
            }else{
                print("task running in other thread")
            }
            let imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
            let _ = try! Data(contentsOf: imageURL)
            print("\(i) finished downloading")
        }
    }
}

doSyncTaskInSerialQueue()

serialQueue.async {
    for i in 0...3 {
//        value = i // for real code
//        print("\(value) ✴️") // for real code
        print("\(i) ✴️") // for playground test
    }
}

print("Last line in playground 🎉")
