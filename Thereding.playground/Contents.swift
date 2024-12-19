import UIKit



let a = DispatchQueue(label:"A")


// MARK: Any queues can specify the any other queue for target
////  its important to keep in mind that when you specifing targeting queue do not create any cycleick dependency

let b =  DispatchQueue(label:"B", attributes: .concurrent , target: a)

// MARK: You can change target Queue using setTerget atribute
//// But if the Queue alrady activated then its not work (may be getting any crash or runtime error )

/// Wrong way for changing Target Queue using setterget attribute
//// let c =  DispatchQueue(label:"C", attributes: .concurrent )
////  c.setTarget(queue: a)   // error: Execution was interrupted, reason: EXC_BREAKPOINT (code=1, subcode=0x1801aed04). The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation.

// MARK: Right way to change target attribute using iniallyinactive attribute
////let c =  DispatchQueue(label:"C", attributes: [.concurrent ,.initiallyInactive])
////c.setTarget(queue: a)
//
//// c.async {
////    for i in 21 ... 25 {
////        print(i)
////    }
////  }
//
//// c.activate()


a.async {
    for i in 0 ... 5 {
        print(i)
     }
}

a.async {
    for i in 6 ... 10 {
        print(i)
    }
}

b.async {
    for i in 11 ... 15 {
        print(i)
    }
}

b.async {
    for i in 16 ... 20 {
        print(i)
    }
}
