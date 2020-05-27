//
//  ViewController.swift
//  sha256
//
//  Created by devzhr on 27/05/2020.
//  Copyright © 2020 zouhair mouhsine. All rights reserved.
//

import UIKit
import CommonCrypto
import SPAlert
class ViewController: UIViewController {
    
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var hashnameLbl: UILabel!
    @IBOutlet weak var sha256Lbl: UILabel!
    @IBOutlet weak var copyBnt: UIButton!
    
    var hashName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func crypto(_ sender: UIButton) {
        let clearString = password.text
        if clearString != ""{
            self.hashName = clearString!.sha256()
            hashnameLbl.text = "HashName:"
            sha256Lbl.text = self.hashName
            copyBnt.isHidden = false
        } else {
            hashnameLbl.text = "Please fill in a password"
            sha256Lbl.text = ""
            copyBnt.isHidden = true
        }
        

    }
    @IBAction func Copy(_ sender: UIButton) {
        UIPasteboard.general.string = self.hashName
        let alertView = SPAlertView(title: "Copy", message: nil, preset: SPAlertPreset.done)
        alertView.duration = 3
        alertView.present()
        
    }
    
}
extension String {

    func sha256() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
        return ""
    }

    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }

    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)

        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }

        return hexString
    }

}

