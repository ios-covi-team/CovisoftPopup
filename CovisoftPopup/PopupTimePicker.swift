//
//  PopupTimePicker.swift
//  Milestone
//
//  Created by Kai Luu on 5/8/19.
//  Copyright © 2019 Kai Luu. All rights reserved.
//

import UIKit
public typealias ActionCallback = (_ time:String)->()

public class PopupTimePicker: UIView {
    
    @IBOutlet var vContent: UIView!
    @IBOutlet var vBG: UIView!
    @IBOutlet weak var vPopup: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var tfContent: UITextField!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var btnLeft: UIButton!
    
     let datePicker = UIDatePicker()
     let toolbar = UIToolbar()
     var dateFormatter = DateFormatter()
    public var code:String?
    public var time:String?
    
    var isSelectedTime = false
    
    var actionCallback:ActionCallback?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    
    public class func showPopupSetTime(code:String,time:String,titleButtonLeft:String,titleButtonRight:String,callback:@escaping (_ isOk:Bool,_ time:String?,_ code:String?,_ isLeft:Bool?) -> ()) {
        let topVC = UIApplication.topViewController()
        
        let popTimePicker:PopupTimePicker = PopupTimePicker(frame: (topVC?.view.bounds)!)
        if topVC?.view.window != nil {
            topVC?.view.window!.addSubview(popTimePicker)
        } else {
            topVC?.view.addSubview(popTimePicker)
        }
        
            
            popTimePicker.code = code
            popTimePicker.time = time
            popTimePicker.tfContent.text = time
            popTimePicker.lblContent.text = code
        
            popTimePicker.btnLeft.setTitle(titleButtonLeft, for: .normal)
            popTimePicker.btnRight.setTitle(titleButtonRight, for: .normal)

            popTimePicker.btnClose.add(for: .touchUpInside) {
                
                popTimePicker.animationDisapprea(callback: { (finish) in
                    callback(false,nil,nil, nil)
                })
            }
            
            popTimePicker.btnLeft.add(for: .touchUpInside) {
                popTimePicker.textFieldDidEndEditing(popTimePicker.tfContent)
                popTimePicker.animationDisapprea(callback: { (finish) in
                    if finish {
                        callback(true,popTimePicker.isSelectedTime == true ? popTimePicker.time : time,code, true)
                    }
                })
            }
            
            popTimePicker.btnRight.add(for: .touchUpInside) {
                popTimePicker.textFieldDidEndEditing(popTimePicker.tfContent)

                popTimePicker.animationDisapprea(callback: { (finish) in
                    if finish {
                        callback(true,popTimePicker.isSelectedTime == true ? popTimePicker.time : time,code, false)
                    }
                })
            }
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PopupTimePicker", bundle: bundle)
        vContent = nib.instantiate(withOwner: self, options: nil).first as? UIView
        vContent?.frame = bounds
        vContent?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(vContent!)
        tfContent.delegate = self
        animationApprea()
        showDatePicker(txtDatePicker: tfContent)
    }
    
    
    func animationDisapprea(callback:@escaping(_ isFinish:Bool) ->()) {
        self.vPopup.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.vPopup.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        }) { (finished) in
            if finished {
                UIView.animate(withDuration: 0.3, animations: {
                    self.vPopup.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
                    
                }) { (finished) in
                    if finished {
                        self.removeFromSuperview()
                        callback(finished)
                    }
                }
            }
        }
    }
    
    func animationApprea() {
        vPopup.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.3, animations: {
            self.vPopup.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        }) { (finished) in
            if finished {
                UIView.animate(withDuration: 0.2, animations: {
                    self.vPopup.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
                })
            }
        }
    }
    
    func showDatePicker(txtDatePicker:UITextField) {
        //Formate Date
        tfContent.delegate = self
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "da_DK")
        var date:Date?
        date = Date().getDateFromString(DateStr: tfContent.text, format: Date.dateFormat11)!
        if date != nil  {
            datePicker.date = date!
        }
        
        //ToolBar
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
       
        toolbar.setItems([spaceButton,doneButton], animated: false)
        
        txtDatePicker.inputAccessoryView = toolbar
        txtDatePicker.inputView = datePicker
        
    }
    
    @objc func donedatePicker() {
        isSelectedTime = true
        textFieldDidEndEditing(tfContent)
        tfContent.text = time

    }
    
    @objc func cancelDatePicker() {
        self.endEditing(true)
    }
    
}

extension PopupTimePicker: UITextFieldDelegate {
    private func textFieldDidEndEditing(_ textField: UITextField) {
        let dateString = datePicker.date.toString()
        let date = Date().getDateFromString(DateStr: dateString, format: Date.dateFormat4)
        
        time =  Date().toString(date: date!, format: Date.dateFormatHourMin)
        textField.resignFirstResponder()
    }
}
