//
//  YJAlert.m
//  wyjframework
//
//  Created by mac on 15/11/12.
//  Copyright © 2015年 王永军. All rights reserved.
//

#import "YJAlert.h"

@implementation YJAlert

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#pragma mark--------提示框
+(SIAlertView *)alertShowTitle:(NSString *)title subtitleTitle:(NSString *)subtitleTitle contant:(NSMutableArray *)contant target:(id)target
                      selector:(NSMutableArray *)selector object:(NSMutableArray *)object

{
    SIAlertView * alert = [[SIAlertView alloc] initWithTitle:title andMessage:subtitleTitle];

    for (int i=0 ; contant.count; i++) {
        
        __weak __typeof(self) weakSelf = target;
        
        [alert addButtonWithTitle:contant[i]
         
                             type:SIAlertViewButtonTypeDefault
         
                          handler:^(SIAlertView *alertView) {
                              
                              if ([selector[i] length]!=0) {
                                
                                  SEL sel =  NSSelectorFromString(selector[i]);
                                  
                                  SuppressPerformSelectorLeakWarning(
                                                                     
                                 [weakSelf performSelector:sel withObject:object[i]];
                                                                     );
                                  
                              }
                              else
                              {
                              
                                  SEL sel = NSSelectorFromString(selector[i]);
                                  
                                  IMP imp = [weakSelf methodForSelector:sel];
                                  
                                  void (*func)(id, SEL) = (void *)imp;
                                  
                                  func(weakSelf, sel);
                              }
                              
                          }];

        
    }

    return alert;
    
}



@end
