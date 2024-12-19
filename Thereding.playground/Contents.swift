import UIKit

var greeting = "Hello, playground"



//MARK: Priority of QOS

////  User Intractive -------> User Initiated ---------> Utility --------> Background



DispatchQueue.global(qos:.background).async {
    for i in 11 ... 20 {
        print(i)
    }
}




//MARK: this code is higher chance to execute first due to qos --> high priority
DispatchQueue.global(qos:.userInteractive).async {
    for i in 0 ... 10 {
        print(i)
    }
}

