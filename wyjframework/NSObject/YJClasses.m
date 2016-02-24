//
//  YJClasses.m
//  wyjframework
//
//  Created by mac on 15/11/12.
//  Copyright © 2015年 王永军. All rights reserved.
//

#import "YJClasses.h"
#import <objc/runtime.h>

@implementation YJClasses

+(void)getClassAllSubViewsClass:(id)sourceClass{
   //iOS下，动态获取一个类的所有子类
   int numClasses;
    
    Class *classes = NULL;
    
    numClasses = objc_getClassList(NULL,0);

    if (numClasses >0 )
   {
    classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
       
    numClasses = objc_getClassList(classes, numClasses);
       
    for (int i = 0; i < numClasses; i++) {
        
        if (class_getSuperclass(classes[i]) == [sourceClass class]){
            
            NSLog(@"%@", NSStringFromClass(classes[i]));
        }
    }
    free(classes);
}

}



@end
