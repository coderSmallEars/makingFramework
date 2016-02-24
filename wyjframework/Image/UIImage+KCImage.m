//
//  UIImage+KCImage.m
//  RCloudMessage
//
//  Created by Liv on 15/4/7.
//  Copyright (c) 2015年 RongCloud. All rights reserved.
//

#import "UIImage+KCImage.h"

@implementation UIImage (KCImage)

/**
 *  修改图片size
 *
 *  @param image      原图片
 *  @param targetSize 要修改的size
 *
 *  @return 修改后的图片
 */
+ (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}



//将所下载的图片保存到本地
-(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        //ALog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
        NSLog(@"文件后缀不认识");
    }
}


//读取本地保存的图片
-(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", directoryPath, fileName, extension]];
    
    return result;
}


-(UIImageView *)saveImageAndShowInImageView:(UIImageView *)img{
    
    
    //从网络下载图片，保存，并用 UIImageView 从保存中显示
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"保存路径:%@",documentsDirectoryPath);
    //Get Image From URL
    UIImage * imageFromURL = [self getImageFromURL:@"http://file.duteba.com/phone/2009/04/5/ftGxL8kcUL.jpg"];
    
    //Save Image to Directory
    [self saveImage:imageFromURL withFileName:@"MyImage" ofType:@"jpg" inDirectory:documentsDirectoryPath];
    
    //Load Image From Directory
    UIImage * imageFromWeb = [self loadImage:@"MyImage" ofType:@"jpg" inDirectory:documentsDirectoryPath];
    
    [img setImage:imageFromWeb];
    
    //取得目录下所有文件名
    NSArray *file = [[[NSFileManager alloc] init] subpathsAtPath:documentsDirectoryPath];
    //NSLog(@"%d",[file count]);
    NSLog(@"%@",file);
    
    
    return img;
    
}



//从网络下载图片
-(UIImage *) getImageFromURL:(NSString *)fileURL {
    NSLog(@"执行图片下载函数");
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}




- (UIImage *)imageNamed:(NSString *)name ofBundle:(NSString *)bundleName {
    UIImage *image = nil;
    NSString *image_name = [NSString stringWithFormat:@"%@.png", name];
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *bundlePath = [resourcePath stringByAppendingPathComponent:bundleName];
    NSString *image_path = [bundlePath stringByAppendingPathComponent:image_name];
    image = [[UIImage alloc] initWithContentsOfFile:image_path];

    return image;
}


+(NSString *)changeImageData:(UIImage *)image CompressionRatio:(double)CompressionRatio
{
    NSData * pictureData = UIImageJPEGRepresentation(image, CompressionRatio);//进行图片压缩从0.0到1.0（0.0表示最大压缩，质量最低);

    return [NSString stringWithUTF8String:[[pictureData base64EncodedDataWithOptions:0] bytes]]
    
    ;

}

+(NSData *)compressionRatioImage:(UIImage *)image ratio:(double)ratio
{
    
    return  UIImageJPEGRepresentation(image, ratio);//进行图片压缩从0.0到1.0（0.0表示最大压缩，质量最低);
    
    
}








@end
