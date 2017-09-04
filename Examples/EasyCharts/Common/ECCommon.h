//
//  CommonColor.h
//  USchoolTeacher
//
//  Created by 宋永建 on 2017/4/5.
//  Copyright © 2017年 Global. All rights reserved.
//


typedef NS_ENUM(NSUInteger, BrokenLineType) {
    BrokenLineTypeCenterPoint = 0,
    BrokenLineTypeNormal,
};

#define ECScreenW [UIScreen mainScreen].bounds.size.width
#define ECScreenH [UIScreen mainScreen].bounds.size.height
#define ECBackgroundColor [UIColor colorWithRed:(240)/255.0 green:(240)/255.0\
                            blue:(240)/255.0 alpha:1.0]

#define random(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define MYBUNDLE_NAME   @"EasyChartsBundle.bundle"
#define MYBUNDLE_PATH   [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:MYBUNDLE_NAME]
#define MYBUNDLE        [NSBundle bundleWithPath:MYBUNDLE_PATH]

#ifdef DEBUG
#define ECLog(FORMAT, ...) fprintf(stderr,"%s LineNum:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define ECLog(...)  NSLog(...)
#endif
