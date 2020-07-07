//
//  ImagePostViewController.swift
//  Filters
//
//  Created by Stephanie Ballard on 7/6/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

/*
 1. Find the filter(s) you want (likely using the [Core Image Filter Reference](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/))
 2. Use a playground to figure out the attributes of the filter for minimum, maximum, and default values. You can also use this for the name and a human readable description of each attribute
 3. Build out the UI to match the attributes with the correct min/max values
 */

class ImagePostViewController: UIViewController {

    private let context = CIContext(options: nil)
    
    private var originalImage: UIImage? {
        didSet {
            // 414 * 3 = 1,242 pixels (portrait on iPhone 11 Pro Max)
            guard let originalImage = originalImage else {
                scaledImage = nil // clear out image if set to nil
                return
            }
            
            var scaledSize = imageView.bounds.size
            let scale = UIScreen.main.scale
            scaledSize = CGSize(width: scaledSize.width * scale, height: scaledSize.height * scale)
            scaledImage = originalImage.imageByScaling(toSize: scaledSize)
        }
    }
    
    private var scaledImage: UIImage? {
        didSet {
            updateImage()
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func filterImageWithGaussinBlur(_ image: UIImage) -> UIImage? {
        // UIImage -> CGImage -> CIImage
        guard let cgImage = image.cgImage else { return nil }
        
        let ciImage = CIImage(cgImage: cgImage)
        
        // Filtering
        let filter = CIFilter.gaussianBlur()
        filter.inputImage = ciImage
        filter.setValue(ciImage, forKey: "inputImage")
        filter.setValue(10, forKey: "inputRadius")
        
        // CIImage -> CGImage -> UIImage
        guard let outputCIImage = filter.outputImage else { return nil }
        
        // Render Image
        guard let outputCGImage = context.createCGImage(outputCIImage, from: CGRect(origin: .zero, size: image.size)) else { return nil }
        
        return UIImage(cgImage: outputCGImage)
    }
    
    private func filterImageWithGloom(_ image: UIImage) -> UIImage? {
        // UIImage -> CGImage -> CIImage
        guard let cgImage = image.cgImage else { return nil }
        
        let ciImage = CIImage(cgImage: cgImage)
        
        // Filtering
        let filter = CIFilter.gloom()
        filter.inputImage = ciImage
        filter.setValue(ciImage, forKey: "inputImage")
        filter.setValue(10, forKey: "inputRadius")
        filter.setValue(0.5, forKey: "inputIntensity")
        
        // CIImage -> CGImage -> UIImage
        guard let outputCIImage = filter.outputImage else { return nil }
        
        // Render Image
        guard let outputCGImage = context.createCGImage(outputCIImage, from: CGRect(origin: .zero, size: image.size)) else { return nil }
        
        return UIImage(cgImage: outputCGImage)
    }
    
    private func filterImageWithHueAdjust(_ image: UIImage) -> UIImage? {
        // UIImage -> CGImage -> CIImage
        guard let cgImage = image.cgImage else { return nil }
        
        let ciImage = CIImage(cgImage: cgImage)
        
        // Filtering
        let filter = CIFilter.gloom()
        filter.inputImage = ciImage
        filter.setValue(ciImage, forKey: "inputImage")
        filter.setValue(0.00, forKey: "inputAngle")
        
        // CIImage -> CGImage -> UIImage
        guard let outputCIImage = filter.outputImage else { return nil }
        
        // Render Image
        guard let outputCGImage = context.createCGImage(outputCIImage, from: CGRect(origin: .zero, size: image.size)) else { return nil }
        
        return UIImage(cgImage: outputCGImage)
    }
    
    private func filterImageWithBloom(_ image: UIImage) -> UIImage? {
        // UIImage -> CGImage -> CIImage
        guard let cgImage = image.cgImage else { return nil }
        
        let ciImage = CIImage(cgImage: cgImage)
        
        // Filtering
        let filter = CIFilter.bloom()
        filter.inputImage = ciImage
        filter.setValue(ciImage, forKey: "inputImage")
        filter.setValue(10.00, forKey: "inputRadius")
        filter.setValue(0.5, forKey: "inputIntensity")
        
        // CIImage -> CGImage -> UIImage
        guard let outputCIImage = filter.outputImage else { return nil }
        
        // Render Image
        guard let outputCGImage = context.createCGImage(outputCIImage, from: CGRect(origin: .zero, size: image.size)) else { return nil }
        
        return UIImage(cgImage: outputCGImage)
    }
    
    private func filterImageWithSepiaTone(_ image: UIImage) -> UIImage? {
        // UIImage -> CGImage -> CIImage
        guard let cgImage = image.cgImage else { return nil }
        
        let ciImage = CIImage(cgImage: cgImage)
        
        // Filtering
        let filter = CIFilter.sepiaTone()
        filter.inputImage = ciImage
        filter.setValue(ciImage, forKey: "inputImage")
        filter.setValue(1.00, forKey: "inputIntensity")
        
        // CIImage -> CGImage -> UIImage
        guard let outputCIImage = filter.outputImage else { return nil }
        
        // Render Image
        guard let outputCGImage = context.createCGImage(outputCIImage, from: CGRect(origin: .zero, size: image.size)) else { return nil }
        
        return UIImage(cgImage: outputCGImage)
    }
    
    private func updateImage() {
//        if let scaledImage = scaledImage {
//            imageView.image = filterImage(scaledImage)
//        } else {
//            imageView.image = nil
//        }
    }
}

