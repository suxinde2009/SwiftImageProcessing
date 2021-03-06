import Foundation

public class ImageProcess {
    
    public static func grabR(image: RGBAImage) -> RGBAImage {
        var outImage = image
        outImage.process { (var pixel) -> Pixel in
            pixel.R = pixel.R
            pixel.G = 0
            pixel.B = 0
            return pixel
        }
        return outImage
    }
    
    public static func grabG(image: RGBAImage) -> RGBAImage {
        var outImage = image
        outImage.process { (var pixel) -> Pixel in
            pixel.R = 0
            pixel.G = pixel.G
            pixel.B = 0
            return pixel
        }
        return outImage
    }
    
    public static func grabB(image: RGBAImage) -> RGBAImage {
        var outImage = image
        outImage.process { (var pixel) -> Pixel in
            pixel.R = 0
            pixel.G = 0
            pixel.B = pixel.B
            return pixel
        }
        return outImage
    }
    
    public static func composite(rgbaImageList: RGBAImage...) -> RGBAImage {
        let result : RGBAImage = RGBAImage(width:rgbaImageList[0].width, height: rgbaImageList[0].height)
        for y in 0..<result.height {
            for x in 0..<result.width {
                
                let index = y * result.width + x
                var pixel = result.pixels[index]
                
                for rgba in rgbaImageList {
                    let rgbaPixel = rgba.pixels[index]
                    pixel.R = min(pixel.R + rgbaPixel.R, 255)
                    pixel.G = min(pixel.G + rgbaPixel.G, 255)
                    pixel.B = min(pixel.B + rgbaPixel.B, 255)
                }
                
                result.pixels[index] = pixel
            }
        }
        return result
    }
    
    public static func gray1(image: RGBAImage) -> RGBAImage {
        var outImage = image
        outImage.process { (var pixel) -> Pixel in
            let result = pixel.Rf*0.2999 + pixel.Gf*0.587 + pixel.Bf*0.114
            pixel.Rf = result
            pixel.Gf = result
            pixel.Bf = result
            return pixel
        }
        return outImage
    }
    
    public static func gray2(image: RGBAImage) -> RGBAImage {
        var outImage = image
        outImage.process { (var pixel) -> Pixel in
            let result = (pixel.Rf + pixel.Gf + pixel.Bf) / 3.0
            pixel.Rf = result
            pixel.Gf = result
            pixel.Bf = result
            return pixel
        }
        return outImage
    }
    
    public static func gray3(image: RGBAImage) -> RGBAImage {
        var outImage = image
        outImage.process { (var pixel) -> Pixel in
            pixel.R = pixel.G
            pixel.G = pixel.G
            pixel.B = pixel.G
            return pixel
        }
        return outImage
    }
    
    public static func gray4(image: RGBAImage) -> RGBAImage {
        var outImage = image
        outImage.process { (var pixel) -> Pixel in
            let result = pixel.Rf*0.212671 + pixel.Gf*0.715160 + pixel.Bf*0.071169
            pixel.Rf = result
            pixel.Gf = result
            pixel.Bf = result
            return pixel
        }
        return outImage
    }
    
    public static func gray5(image: RGBAImage) -> RGBAImage {
        var outImage = image
        outImage.process { (var pixel) -> Pixel in
            let result = sqrt(pow(pixel.Rf, 2) + pow(pixel.Rf, 2) + pow(pixel.Rf, 2))/sqrt(3.0)
            pixel.Rf = result
            pixel.Gf = result
            pixel.Bf = result
            return pixel
        }
        return outImage
    }

}