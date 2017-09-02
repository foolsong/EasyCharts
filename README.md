# EasyCharts
A simple chart lib used for iOS

## Requirements
* ARC
* iOS>=8.0
* iPhone  || iPad

## Features
* BrokenLineChart 
* PieChart
* ProgressChart 

**持续更行中……**


## Installation

EasyCharts supports multiple methods for installing the library in a project.

* using CocoaPods
* using Carthage
* by cloning the project into your repository


<!--## How to use-->

## Usage

### 导入头文件 
`#import "EasyCharts.h"`

下面介绍一下几种图的基本使用

### BrokenLineChart 
   BrokenLineChart目前有两种类型`BrokenLineTypeCenterPoint`和`BrokenLineTypeNormal`。
   >  `BrokenLineTypeNormal`是普通的折线图 \
  >  `BrokenLineTypeCenterPoint`选中的点始终居中
  
   创建时除了`BrokenLineType`还有两个参数，一个是`frame`，另一个是`ECBrokenLineConfig`(参数如下)对象。
   
   > `ECBrokenLineConfig`可配置折线图的属性，属性都有默认值。当然可以传`nil`,全部被使用默认值
   
```Objective-c
@property (nonatomic, strong) UIColor *brokenLineColor;
@property (nonatomic, strong) UIColor *backVeiwLineColor;
@property (nonatomic, strong) UIColor *backVeiwTextColor;
@property (nonatomic, strong) UIColor *backVeiwBackGroupColor;
@property (nonatomic, strong) UIColor *brokenAbscissaColor;

@property (nonatomic, assign) CGFloat minValue;  //default 0
@property (nonatomic, assign) CGFloat maxValue;  //default 100

@property (nonatomic, assign) CGFloat numberOfIntervalLines; //default 5
@property (nonatomic, assign) BrokenLineType brokenLineType;
```
   
   delegate,在当前折线图上的点被点击时调用：
   
```Objective-c
- (void)brokenLineView:(ECBrokenLineView *)brokenLineView
   selectedAtIndexPath:(NSIndexPath *)indexPath;
```

初始化：

```Objective-C
 ECBrokenLineView *brokenLineView = [ECBrokenLineView lineViewWithFrame:frame
                                                      withBrokenLineConfig:nil
                                                            brokenLineType:BrokenLineTypeNormal];
    brokenLineView.delegate = self;
    [self.view addSubview:brokenLineView];
```

```Objective-C
 ECBrokenLineView *brokenLineView = [ECBrokenLineView lineViewWithFrame:frame
                                                      withBrokenLineConfig:nil
                                                            brokenLineType:BrokenLineTypeCenterPoint];
    brokenLineView.delegate = self;
    [self.view addSubview:brokenLineView];
```

赋值：

```
[self.brokenLineView reloadLineViewDataWithPointValveList:self.pointValveList
                                                    titleText:self.pointValveList];
```													

<center>

![image](https://github.com/foolsong/EasyCharts/blob/master/gif/EC_lineNormal_gif.gif)

</center>

<center>

![image](https://github.com/foolsong/EasyCharts/blob/master/gif/EC_lineCenterView_gif.gif)

</center>


<!--
## Hope

* If you find bug when used，Hope you can Issues me，Thank you or try to download the latest code of this framework to see the BUG has been fixed or not）
* If you find the function is not enough when used，Hope you can Issues me，I very much to add more useful function to this framework ，Thank you !
* If you want to contribute code for EasyCharts，please Pull Requests me

-->


## Communication

* If you found a bug, and can provide steps to reliably reproduce it, open an issue.
* If you have a feature request, open an issue.
* If you want to contribute, submit a pull request.