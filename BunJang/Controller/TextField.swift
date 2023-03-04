//
//  TextField.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/04.
//

import UIKit
@IBDesignable
class TextField: UITextField {
    @IBInspectable var rightimage : UIImage?{
           didSet{
               updateTextField()
           }
       }
       
       @IBInspectable var leftMargin : CGFloat = 0 {
           didSet{
               updateTextField()
           }
       }
       
       @IBInspectable var viewColor : UIColor? {
           didSet{
               updateTextField()
           }
       }
       
       @IBInspectable var imageTintColor : UIColor? {
           didSet{
               updateTextField()
           }
       }
       
       
       @IBInspectable var viewWidth : CGFloat = 0 {
           didSet{
               updateTextField()
           }
       }
       
       @IBInspectable var viewHeight : CGFloat = 0 {
           didSet{
               updateTextField()
           }
       }
       
       
       func updateTextField(){}

    

}
