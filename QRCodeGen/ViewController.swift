//
//  ViewController.swift
//  QRCodeGen
//
//  Created by Yuhsuan on 05/12/2016.
//  Copyright © 2016 cgua. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var text_field: UITextField!
    
    @IBOutlet var gen_button: UIButton!
    
    @IBOutlet var image_view: UIImageView!

    @IBOutlet var slider: UISlider!
    
    var qrcode_image: CIImage!
    
    @IBAction func performButtonAction(_ sender: Any) {
        
        if qrcode_image == nil {
        
            if text_field.text == "" {
                
                return
                
            }
            
            let data = text_field.text?.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            
            filter?.setValue( data, forKey: "inputMessage")
            
            filter?.setValue( "H", forKey: "inputCorrectionLevel")
            
            qrcode_image = filter?.outputImage
            
            diaplayQRCodeImage()
            
            text_field.resignFirstResponder()
            
            gen_button.setTitle("Clear", for: .normal)
            
            slider.isHidden = false
            
            text_field.isEnabled = false
            
        }
        else {
        
            gen_button.setTitle("Generate", for: .normal)
            
            image_view.image = nil
            
            qrcode_image = nil
            
            text_field.text = ""
            
            text_field.isEnabled = !text_field.isEnabled
            
            slider.isHidden = !slider.isHidden
            
        }
        
    }
    
    @IBAction func changeImageViewScale(sender: Any) {
        
        image_view.transform = CGAffineTransform(scaleX: CGFloat(slider.value), y: CGFloat(slider.value))
        
    }
    
    func diaplayQRCodeImage() {
        
        let scaleX = image_view.frame.size.width / qrcode_image.extent.size.width
        
        let scaleY = image_view.frame.size.height / qrcode_image.extent.size.height
        
        let transformed = qrcode_image.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        image_view.image = UIImage(ciImage: transformed)
        
    }

}

