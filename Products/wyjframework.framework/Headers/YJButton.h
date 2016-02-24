//
//  YJButton.h
//  wyjframework
//
//  Created by mac on 15/11/12.
//  Copyright © 2015年 王永军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface YJButton : NSObject


#pragma mark -----------------------采用系统字体大小采用999
+(UIButton *)BKLoginButton:(NSString *)title imageName:(NSString *)imageName fontSize:(CGFloat)fontSize frame:(CGRect)frame target:(id)target
                  selector:(SEL)selector;


@end
