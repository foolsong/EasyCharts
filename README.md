# <center>EasyCharts     <img src="https://github.com/foolsong/EasyCharts/blob/master/gif/ec_blog_9_14.png"  width=60 alt="EC_logo" /></center>
<!-- ![](https://github.com/foolsong/EasyCharts/blob/master/gif/ec_blog_9_14.png)  -->
A simple chart lib used for iOS(Objective-c).  :-)          [Swift](https://github.com/foolsong/EasyChartsSwift)

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

### Import header file
`#import "EasyCharts.h"`

The following describes the basic use of several graphs.


### BrokenLineChart 

   BrokenLineChart now includes :`BrokenLineTypeCenterPoint` and `BrokenLineTypeNormal`。
   >  `BrokenLineTypeNormal`Is an ordinary broken  line chart
  >  `BrokenLineTypeCenterPoint`made the selected point always centered
   
   Besides `BrokenLineType` ，There are two more parameters when creating an object,one is frame, the other is object `ECBrokenLineConfig` ,parameters below:
   
   >   You can use `ECBrokenLineConfig` to configure the attributes of the brokenLine charts，Each attribute is set to default values.Of course you can use `nil`.
   
   
   				
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

Initialization：

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

Data filling: ( If the value is less than the minimum value, the minimum value is displayed。If the value is greater than the maximum value, the maximum value is displayed；point on both sides filled with dashed lines)

```Objective-C
[self.brokenLineView reloadLineViewDataWithPointValveList:self.pointValveList
                                                    titleText:self.pointTextList];
```													

**The effect of BrokenLineTypeNormal**

<img src="https://github.com/foolsong/EasyCharts/blob/master/gif/EC_lineNormal_gif.gif"  width=300 alt="EC_lineNormal" />

**The effect of BrokenLineTypeCenterPoint**

<img src="https://github.com/foolsong/EasyCharts/blob/master/gif/EC_lineCenterView_gif.gif"  width=300 alt="EC_lineCenterView" />



| **The effect of BrokenLineTypeNormal**        | **The effect of BrokenLineTypeCenterPoint**           | 
| ------------- |:-------------:| 
| <img src="https://github.com/foolsong/EasyCharts/blob/master/gif/EC_lineNormal_gif.gif"  width=300 alt="EC_lineNormal" />     | <img src="https://github.com/foolsong/EasyCharts/blob/master/gif/EC_lineCenterView_gif.gif"  width=300 alt="EC_lineCenterView" /> | 



<center>


<!-- ![image](https://github.com/foolsong/EasyCharts/blob/master/gif/EC_lineCenterView_gif.gif) -->

</center>


### ProgressView

Initialization--Just transfer `frame`.

```Objective-c
ECProgressChartView *progressView = [ECProgressChartView progressChartViewWithFrame:frame];
    [self.view addSubview:progressView];
```

Data filling：

```Objective-c
[self.progressView resetProgress:[self createProgress]];
```

**The effect of ProgressView:**

<img src="https://github.com/foolsong/EasyCharts/blob/master/gif/EC_%20ProgressView_gif.gif"  width=300 alt="EC_lineCenterView" />

### BrokenLineChart && ProgressView

**Application scene：**

<img src="https://github.com/foolsong/EasyCharts/blob/master/gif/EC_BrokenLineChart_ProgressView.gif"  width=300 alt="EC_lineCenterView" />

### PieChart

Initialization--Just transfer `frame`.

```Objective-c
 ECPieChartView *pieView = [ECPieChartView pieChartViewWithFrame:CGRectMake(0, 100, ECScreenW, 200)];
    [self.view addSubview:pieView];
```

Data filling:Three parameters:percentList、colorList、arcTextList]

```Objective-c
[pieView drawPieChartWithPercentList:self.percentList
                               colorList:self.colorList
                             arcTextList:self.arcTextList];
```

**The effect of PieChart:**

<img src="https://github.com/foolsong/EasyCharts/blob/master/gif/EC_%20PieChart_gif.gif"  width=300 alt="EC_lineCenterView" />


### RadarChartView

Initialization--Just transfer `frame`.

```Objective-c
	ECRadarChartView *rView = [ECRadarChartView radarChartViewWithFrame:CGRectMake(60, 350, 270, 270)];
	[self.view addSubview:rView];
```

Data filling:

```Objective-c
	ECRadarChartConfig *config = [[ECRadarChartConfig alloc] init];
	config.backgroupLineNum = 5;
	config.radius = 100;
	config.drawPointArray = @[@[@(0.5),@(0.4),@(0.5),@(0.1),@(0.9)],
	                              @[@(0.4),@(0.5),@(0.2),@(0.8),@(0.1)],
	                              @[@(0.4),@(0.1),@(0.8),@(0.7),@(0.2)]];
	config.drawLineColorArray = @[[UIColor orangeColor],[UIColor greenColor],[UIColor redColor]];
	config.drawLineTitleArray = @[@"Technology",@"Execution",@"Thinking",@"Endurance",@"Speed"];
	 [rView setupRadarChartConfig:config];
```

```Objective-c
	ECRadarChartConfig *config = [[ECRadarChartConfig alloc] init];
	config.backgroupLineNum = 5;
	config.radius = 100;
	config.drawPointArray = @[@[@(0.5),@(0.4),@(0.5),@(0.1),@(0.9),@(0.4)]];
	config.drawLineColorArray = @[[UIColor orangeColor]];
	config.drawLineTitleArray = @[@"Technology",@"Execution",@"Thinking",@"Endurance",@"Speed",@"Power",];
	 [rView setupRadarChartConfig:config];
```

**The effect of PieChart:**

<img src="https://github.com/foolsong/EasyCharts/blob/master/gif/EC_RadarChart.gif"  width=300 alt="EC_lineCenterView" />


## Communication

* If you found a bug, and can provide steps to reliably reproduce it, open an issue.
* If you have a feature request, open an issue.
* If you want to contribute, submit a pull request.