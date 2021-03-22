//
//  ChartView.h
//  Polygon_App
//
//  Created by admin on 11/21/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ChartView : UIView


@property float spaceBetweenBars;
@property float barWidth;
@property float verticalDataSpace;
@property float rate;

@property (strong) UIColor * linesColor;
@property (strong) UIColor * numbersColor;
@property (strong) UIColor * numbersTextColor;
@property (strong) UIColor * dateColor;
@property (strong) UIColor * barColor;
@property (nonatomic,strong) NSArray * dataSource;
@property (strong) UIColor * textColor;
@property (strong) UIColor * dottedLineColor;
@property (strong) UIColor * barOuterLine;
@property int numberOfVerticalElements;
@property (strong) NSString * datesBarText;
@property (strong) NSString * tasksBarText;
@property (strong) NSString * fontName;
@property CGFloat dateFontSize;
@property CGFloat titlesFontSize;



@end
