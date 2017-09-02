//
//  CommonColor.h
//  USchoolTeacher
//
//  Created by hefanghui on 2017/4/5.
//  Copyright © 2017年 topglobaledu. All rights reserved.
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

//#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//
//
//
//#define randomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]
//
////色彩标准
//#define C1_COLOR [UIColor colorWithRed:52.0/255.0 green:61.0/255.0 blue:75.0/255.0 alpha:1.0]
//
//#define STD_COLOR(RED, GREEN, BLUE, ALPHA) [UIColor colorWithRed:RED green:GREEN blue:BLUE alpha:ALPHA]
////#define NAV_COLOR [UIColor colorWithRed:0.153 green:0.718 blue:0.953 alpha:1.000]
//#define NAV_COLOR RGBColor(245,245,245)
//#define KColorLine RGBColor(232, 232, 232)
//
//#define KColorBlack RGBColor(0,0,0)
//#define KColorWhite RGBColor(255,255,255)
//#define KColorTextPlaceHold RGBColor(160, 160, 160)
//#define KColorDesc RGBColor(102, 102, 102)
//#define KColorContent RGBColor(51, 51, 51)
//#define KColorBackGround kColorC3_6//RGBColor(238, 243, 248)
//#define KColorButtonBackGround RGBColor(29, 201, 246)
//#define KColorCoverView [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7]
//#define KColorFaulse [UtilitiesColor colorWithHexString:@"#faa06f"]
//#define KColorCorrect [UtilitiesColor colorWithHexString:@"#26d9a0"]
//#define KColorNormal [UtilitiesColor colorWithHexString:@"#29b6f6"]
//#define KColorSectionHeaderView [UtilitiesColor colorWithHexString:@"eff3f7"]
//#define KColorOrange [UtilitiesColor colorWithHexString:@"#f7a92d"]
//
//#define kColorAlpha(color, alpha) [color colorWithAlphaComponent:alpha]  // 使用： kColorAlpha(kColorC3_1, 0.5);
//
//#define kColorC1_1 RGBColor(37,173,255)
//#define kColorC1_1_highlighted RGBColor(25,157,255)
//#define kColorC1_2 RGBColor(255,156,14)
//#define kColorC1_2_highlighted RGBColor(255,122,14)
//#define kColorC1_3 RGBColor(51,51,51)
//#define kColorC1_3_ButtonHighlighted [UIColor colorWithRed:51 green:51 blue:51 alpha:0.5]
//
//
//#define kColorC1_3_highlighted RGBColor(33,33,33)
//
//#define kColorC2_1 RGBColor(17,17,17)
//#define kColorC2_2 RGBColor(102,102,102)
//#define kColorC2_3 RGBColor(153,153,153)
//#define kColorC2_4 RGBColor(178,178,178)
//#define kColorC2_5 RGBColor(204,204,204)
//#define kColorC2_6 RGBColor(136,136,136)
//#define kColorC2_7 RGBColor(133,133,133)
//
//
//#define kColorC3_1 RGBColor(255,255,255)
//#define kColorC3_1_highlighted STD_COLOR(255, 255, 255, 0.5)
//#define kColorC3_2 RGBColor(239,239,244)
//#define kColorC3_3 RGBColor(232,232,232)
//#define kColorC3_4 RGBColor(245,245,245)
//#define kColorC3_5 RGBColor(216,216,216)
//#define kColorC3_6 RGBColor(240,240,240)
//
//
//#define kColorC4_1 RGBColor(254,109,160)
//#define kColorC4_2 RGBColor(91,213,154)
//#define kColorC4_3 RGBColor(250,203,98)
//#define kColorC4_4 RGBColor(99,183,250)
//#define kColorC4_5 RGBColor(255,120,202)
//#define kColorC4_6 RGBColor(153,128,255)
//#define kColorC4_7 RGBColor(255,120,0)
//#define kColorC4_8 RGBColor(37,173,255)
//#define kColorC4_9 RGBColor(25,157,255)
//
//#define kColorC5_1 RGBColor(255,209,93)
//#define kColorC5_2 RGBColor(255,179,0)
//#define kColorC5_3 RGBColor(255,133,133)
//#define kColorC5_4 RGBColor(152,230,123)
//#define kColorC5_5 RGBColor(2,226,218)
//#define kColorC5_6 RGBColor(64,186,255)
//#define kColorC5_7 RGBColor(113,214,76)
//
//
//#define T9_22PX 11.0
//#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
