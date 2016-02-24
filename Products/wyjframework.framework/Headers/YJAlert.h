//
//  YJAlert.h
//  wyjframework
//
//  Created by mac on 15/11/12.
//  Copyright © 2015年 王永军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIAlertView.h"
@interface YJAlert : NSObject

#pragma mark--------提示框
+(SIAlertView *)alertShowTitle:(NSString *)title subtitleTitle:(NSString *)subtitleTitle contant:(NSMutableArray *)contant target:(id)target
                      selector:(NSMutableArray *)selector object:(NSMutableArray *)object;

@end
