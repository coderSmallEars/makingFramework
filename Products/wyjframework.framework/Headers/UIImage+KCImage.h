//
//  UIImage+KCImage.h
//  RCloudMessage
//
//  Created by Liv on 15/4/7.
//  Copyright (c) 2015年 RongCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KCImage)

/**
 *  修改图片size
 *
 *  @param image      原图片
 *  @param targetSize 要修改的size
 *
 *  @return 修改后的图片
 */
+ (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize;




#pragma mark-------从网络下载图片 并在imageView保存 显示
//将所下载的图片保存到本地
-(void)saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;

//读取本地保存的图片
-(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension
           inDirectory:(NSString *)directoryPath;
//从网络下载图片，保存，并用 UIImageView 从保存中显示
-(UIImageView *)saveImageAndShowInImageView:(UIImageView *)img;

//根据地址取图片
- (UIImage *)imageNamed:(NSString *)name ofBundle:(NSString *)bundleName;

//将图片压缩为NSData数据  并转为字符串  作为参数上传服务器
+(NSString *)changeImageData:(UIImage *)image CompressionRatio:(double)CompressionRatio;

//进行图片压缩从0.0到1.0（0.0表示最大压缩，质量最低);
+(NSData *)compressionRatioImage:(UIImage *)image ratio:(double)ratio;

















@end
