//
//  YJTextField.m
//  wyjframework
//
//  Created by mac on 15/11/12.
//  Copyright © 2015年 王永军. All rights reserved.
//

#import "YJTextField.h"

@implementation YJTextField


#pragma mark------创建UITextField
+(UITextField *)BKLoginTextField:(NSString *)placeholder frame:(CGRect)frame backImage:(NSString *)backImage keyboardType:(UIKeyboardType )keyboardType  leftImageName:(NSString *)leftImageName target:(id)target
{
    
    UITextField * textField = [[UITextField alloc]initWithFrame:frame];
    
    if (leftImageName.length!=0) {
        
        textField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:leftImageName]];
        
        textField.leftViewMode = UITextFieldViewModeAlways;
    }
    textField.delegate=target;
    
    textField.keyboardType = keyboardType;
    
    textField.placeholder = [NSString stringWithFormat:@"%@",placeholder];
    
    textField.tintColor = [UIColor grayColor];
    
    textField.font = [UIFont systemFontOfSize:13];
    
    textField.background = [UIImage imageNamed:backImage];
     
    
    return textField;
    
}


@end
