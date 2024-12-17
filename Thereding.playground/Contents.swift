import UIKit

var greeting = "Hello, playground"


class CustomThered {
    
    func createThread(){
        let thered:Thread = Thread(target: self, selector: #selector(theredSelector), object: nil)
        thered.start()
    }
    @objc func theredSelector(){
        print("Custom Thread in Action ")
    }
}

let customThread  = CustomThered()

customThread.createThread()
