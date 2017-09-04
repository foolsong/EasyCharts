# EasyCharts
A simple chart lib used for iOS(Objective-c).  :-)

[中文说明](http://blog.csdn.net/foolsong/article/details/77811429)

## Requirements
* ARC
* iOS>=8.0
* iPhone  || iPad
* Xcode 8.0 or later

## Features
 - [x] BrokenLineChart 
 - [x] PieChart
 - [x] ProgressChart 
 - [ ] BarGraph
 - [ ] RadarMap

**Continuously updating ...…**

## Installation

At present 
* by cloning the project into your repository

<!-- EasyCharts supports multiple methods for installing the library in a project.
* using CocoaPods
* using Carthage -->



<!--## How to use-->

## Usage

### import header file
`#import "EasyCharts.h"`

The following describes the basic use of several graphs


### BrokenLineChart 

   BrokenLineChart,two types :`BrokenLineTypeCenterPoint` and `BrokenLineTypeNormal`。
   >  `BrokenLineTypeNormal`Is an ordinary line chart
  >  `BrokenLineTypeCenterPoint`made the selected point always centered
   
   There are two parameters in addition to `BrokenLineType` when creating an object.one is frame, the other is `ECBrokenLineConfig`  object .Parameters below:	
   
   >  You can use the `ECBrokenLineConfig` object to set the properties of the line－chart，Each attribute is set to default values.Of course you can use `nil`.
   
   
   				
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
   
   Delegate is called when the point on the line is clicked.
   
```Objective-c
- (void)brokenLineView:(ECBrokenLineView *)brokenLineView
   selectedAtIndexPath:(NSIndexPath *)indexPath;
```

Initial：

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

Fill data: ( If the value is less than the minimum value, the minimum value is displayed。If the value is greater than the maximum value, the maximum value is displayed；point on both sides filled with dashed lines)

```Objective-C
[self.brokenLineView reloadLineViewDataWithPointValveList:self.pointValveList
                                                    titleText:self.pointTextList];
```													

**BrokenLineTypeNormal --Renderings**

<img src="https://github.com/foolsong/EasyCharts/blob/master/gif/EC_lineNormal_gif.gif"  width=300 alt="EC_lineNormal" />

**BrokenLineTypeCenterPoint --Renderings**

<img src="https://github.com/foolsong/EasyCharts/blob/master/gif/EC_lineCenterView_gif.gif"  width=300 alt="EC_lineCenterView" />


<center>


<!-- ![image](https://github.com/foolsong/EasyCharts/blob/master/gif/EC_lineCenterView_gif.gif) -->

</center>


### ProgressView

Initial--Just incoming `frame`.

```Objective-c
ECProgressChartView *progressView = [ECProgressChartView progressChartViewWithFrame:frame];
    [self.view addSubview:progressView];
```

Fill data；

```Objective-c
[self.progressView resetProgress:[self createProgress]];
```

<img src="https://github.com/foolsong/EasyCharts/blob/master/gif/EC_%20ProgressView_gif.gif"  width=300 alt="EC_lineCenterView" />

### BrokenLineChart && ProgressView

Application scenario：

<img src="https://github.com/foolsong/EasyCharts/blob/master/gif/EC_BrokenLineChart_ProgressView.gif"  width=300 alt="EC_lineCenterView" />

### PieChart

Initial--Just incoming `frame`.

```Objective-c
 ECPieChartView *pieView = [ECPieChartView pieChartViewWithFrame:CGRectMake(0, 100, ECScreenW, 200)];
    [self.view addSubview:pieView];
```

Fill data:Three parameters:percentList、colorList、arcTextList]

```Objective-c
[pieView drawPieChartWithPercentList:self.percentList
                               colorList:self.colorList
                             arcTextList:self.arcTextList];
```

<img src="https://github.com/foolsong/EasyCharts/blob/master/gif/EC_%20PieChart_gif.gif"  width=300 alt="EC_lineCenterView" />


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