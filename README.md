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
第一步导入头文件 `#import "EasyCharts.h"`

###BrokenLineChart (LineNormalView)
```Objective-C
	ECBrokenLineView *brokenLineView = [ECBrokenLineView lineViewWithFrame:frame
	                                                      withBrokenLineConfig:nil
	                                                            brokenLineType:BrokenLineTypeMiddlePoint];
	    brokenLineView.delegate = self;
	    [self.view addSubview:brokenLineView];
```



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