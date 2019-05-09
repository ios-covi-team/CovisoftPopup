//
//  UIButton.swift
//  Timetablr
//
//  Created by Mr.Robo on 4/14/18.
//  Copyright © 2018 eXNodes. All rights reserved.
//

import Foundation
import UIKit

class ClosureSleeve {
    let closure: ()->()
    
    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }
    
    @objc func invoke () {
        closure()
    }
    
    
}

extension UIControl {
    func add (for controlEvents: UIControl.Event, _ closure: @escaping ()->()) {
        
        let sleeve = ClosureSleeve(closure)
        objc_removeAssociatedObjects(self)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(ObjectIdentifier(self).hashValue) + String(controlEvents.rawValue), sleeve,
                                 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

class CustomButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        backgroundColor = Constant.Color.mainColor
        layer.cornerRadius = self.frame.size.height / 2
        layer.borderWidth = 1.0
        clipsToBounds = true
        checkEnable()
        self.contentEdgeInsets =  UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
//        checkHighLight()
    }
    
    override open var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            super.isHighlighted = newValue
            //checkHighLight()
        }
    }
    
//    func checkHighLight(){
//        if isHighlighted {
//            backgroundColor = Constant.Color.mainColorPress
//            self.titleLabel?.textColor = .gray
//        }else{
//            backgroundColor = Constant.Color.mainColor
//            self.titleLabel?.textColor = .white
//        }
//    }
    
    func checkEnable(){
//        self.isEnabled = isEnable
//
//        if !isEnable{
//            backgroundColor = .gray
//            setTitleColor(.darkGray, for: .normal)
//            layer.borderColor = UIColor.darkGray.cgColor
//        }else{
//            backgroundColor = Constant.Color.mainColor
//            setTitleColor(.white, for: .normal)
//            layer.borderColor = Constant.Color.mainColorPress.cgColor
//        }
        

    }
    
    @IBInspectable var isEnable:Bool = true{
        didSet{
            checkEnable()
        }
    }
}
