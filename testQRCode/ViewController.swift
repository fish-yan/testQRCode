//
//  ViewController.swift
//  testQRCode
//
//  Created by 薛焱 on 16/7/19.
//  Copyright © 2016年 薛焱. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {

    @IBOutlet weak var iamgeView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let fiter = CIFilter(name:"CIQRCodeGenerator")
        fiter?.setDefaults()
        let str = "https://www.baidu.com"
        let data = str.dataUsingEncoding(NSUTF8StringEncoding)
        fiter?.setValue(data, forKey:"inputMessage")
        fiter?.setValue("M", forKey: "inputCorrectionLevel")
        let outImage = fiter?.outputImage
        
        let extent = CGRectIntegral(outImage!.extent)
        
        let context = CIContext()
        let bitmapImage = context.createCGImage(outImage!, fromRect: extent)
        let scale = min(200/CGRectGetWidth(extent), 200/CGRectGetHeight(extent))
        let bitmapRef = CGBitmapContextCreate(nil, 200, 200, 8, 0, CGColorSpaceCreateDeviceGray(), CGImageAlphaInfo.None.rawValue)
        CGContextSetInterpolationQuality(bitmapRef, .None)
        CGContextScaleCTM(bitmapRef, scale, scale)
        CGContextDrawImage(bitmapRef, extent, bitmapImage)
        let scaleImage = CGBitmapContextCreateImage(bitmapRef)
        
        let image = UIImage(CGImage: scaleImage!)
        iamgeView.image = image
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

