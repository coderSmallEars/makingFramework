//
//  YJButton.m
//  wyjframework
//
//  Created by mac on 15/11/12.
//  Copyright © 2015年 王永军. All rights reserved.
//

#import "YJButton.h"

@implementation YJButton

#pragma mark------创建button
+(UIButton *)BKLoginButton:(NSString *)title imageName:(NSString *)imageName fontSize:(CGFloat)fontSize frame:(CGRect)frame target:(id)target
                  selector:(SEL)selector

{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = frame;
#pragma mark -----------------------采用系统字体大小采用999
    if (fontSize!=999) {
        
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}



@end
