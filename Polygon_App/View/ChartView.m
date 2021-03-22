//
//  ChartView.m
//  Polygon_App
//
//  Created by admin on 11/21/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "ChartView.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>


#define BAR_WIDTH_MAX 100
#define BAR_WIDTH_MIN 3
#define BAR_WIDTH_DEFAULT 20
#define BAR_SPACES_DEFAULT 10
#define HORIZONTAL_PADDING 20
#define VERTICAL_PADDING 30
#define HORIZONTAL_START_LINE 0.05
#define VERTICAL_START_LINE 0.01
#define VERTICALE_DATA_SPACES 33
#define LABEL_DIM 20

@interface ChartView ()

@property int maxHeight;
@property int maxWidth;

@end

@implementation ChartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.barWidth=BAR_WIDTH_DEFAULT;
        self.spaceBetweenBars=BAR_SPACES_DEFAULT;
        self.verticalDataSpace = VERTICALE_DATA_SPACES;
        self.backgroundColor=[UIColor colorWithWhite:0.95 alpha:0.5];
        self.linesColor=[UIColor colorWithRed:0.75 green:0.94 blue:0.95 alpha:1];
        self.numbersColor=[UIColor whiteColor];
        self.numbersTextColor=[UIColor whiteColor];
        self.dateColor=[UIColor whiteColor];
        self.layer.cornerRadius=20;
        self.layer.masksToBounds=YES;
        self.numberOfVerticalElements=5;
        self.barColor=[UIColor colorWithRed:0.0 green:0.57 blue:0.65 alpha:1];
        self.textColor=[UIColor blackColor];
        self.dottedLineColor=[UIColor colorWithRed:0.75 green:0.94 blue:0.95 alpha:1];
        self.barOuterLine=[UIColor colorWithRed:0.4 green:0.4 blue:1 alpha:0.8];
        self.datesBarText=@"Date";
        self.tasksBarText=@"Tasks";
        self.fontName=@"Helvetica";
        self.dateFontSize=12;
        self.titlesFontSize=20;
        self.rate = 0.7;
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect
{
    
    // Drawing code
    float minOfTwo=MIN(self.bounds.size.width, self.bounds.size.height);
    self.verticalDataSpace = (float)((self.frame.size.height-40-VERTICAL_START_LINE*minOfTwo)/5);
    
    [self setscale:minOfTwo];
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0f, self.bounds.size.height-10);
    CGContextScaleCTM(context, 1, -1);
    CGAffineTransform transform=CGAffineTransformMakeTranslation(25, self.bounds.size.height / 2.f);
    CGFloat rotation = M_PI / 2.f;
    transform = CGAffineTransformRotate(transform,rotation);
    NSLog(@"height %f",self.verticalDataSpace);
    
    //vertical numbers
    for (int i=0; i<=self.numberOfVerticalElements; i++) {
        int height=self.verticalDataSpace* i;
        float verticalLine=height+VERTICAL_START_LINE*minOfTwo;
        NSLog(@"height %f",verticalLine);
        
        if (verticalLine>VERTICAL_START_LINE*minOfTwo) {
            [self.dottedLineColor set];
            CGContextMoveToPoint(context, HORIZONTAL_START_LINE*minOfTwo, verticalLine);
            CGContextAddLineToPoint(context, self.spaceBetweenBars + HORIZONTAL_START_LINE*minOfTwo, verticalLine);
            CGContextStrokePath(context);
        }
    }
    
    
    //set the line solid
    CGFloat  normal=1;
    
    CGContextSetLineDash(context,0,&normal,0);
    
    int index=0;
    
    
    for (NSString * dataObject in self.dataSource) {
        
        float between = (self.frame.size.height-40-VERTICAL_START_LINE*minOfTwo)/5;
        int height= (int)([dataObject intValue] * between);
        
        float xPosition=HORIZONTAL_START_LINE*minOfTwo+(index+1)* self.spaceBetweenBars + index * self.barWidth;
        
        if (xPosition>=HORIZONTAL_START_LINE*minOfTwo && xPosition<self.bounds.size.width ){
            [self.dateColor set];
        }
        
        
        if (height>0) {
            
            if (xPosition>=HORIZONTAL_START_LINE*minOfTwo && xPosition<self.bounds.size.width ) {
                CGRect barRect=CGRectMake(xPosition, VERTICAL_START_LINE*minOfTwo-1, self.barWidth, height+1);
                [self.barOuterLine set];
                CGContextStrokeRect(context, barRect);
                [self.barColor set];
                UIRectFill(barRect);
            }
            else if(xPosition+self.barWidth >HORIZONTAL_START_LINE*minOfTwo  && xPosition<HORIZONTAL_START_LINE*minOfTwo )
            {
                
                [self.barColor set];
                UIRectFill(CGRectMake(HORIZONTAL_START_LINE*minOfTwo, VERTICAL_START_LINE*minOfTwo, self.barWidth-(HORIZONTAL_START_LINE*minOfTwo-xPosition), height));
            }
            
            
            
        }
        
        index++;
    }
    
    //draw year
    
    // draw axes
    CGContextSetLineWidth(context, 0.5);
    CGContextMoveToPoint(context, HORIZONTAL_START_LINE*minOfTwo, VERTICAL_START_LINE*minOfTwo);
    [self.linesColor set];
    
    CGContextAddLineToPoint(context, HORIZONTAL_START_LINE*minOfTwo, self.bounds.size.height-40);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, HORIZONTAL_START_LINE*minOfTwo, VERTICAL_START_LINE*minOfTwo);
    CGContextAddLineToPoint(context, self.bounds.size.width-20, VERTICAL_START_LINE*minOfTwo);
    CGContextStrokePath(context);
    
    
    
}


#pragma mark setDataSource
-(void)setDataSource:(NSArray *)dataSource
{
    _dataSource=dataSource;
    
    //calculate the limit of height
    _maxHeight=0;
    for (NSString *dataObject in _dataSource) {
        int height=[dataObject intValue];
        _maxHeight=MAX(height, _maxHeight);
        if (_maxHeight > self.frame.size.height-40) {
            
            _maxHeight = self.frame.size.height-40;
            
        }
    }
    _maxHeight-=self.spaceBetweenBars;
    //calculate the limit of width
    _maxWidth=([_dataSource count]-1)*(self.barWidth+self.spaceBetweenBars);
    self.verticalDataSpace = _maxHeight / self.numberOfVerticalElements;
}

- (void) setscale : (float) minOfTwo
{
    
    float f_barwidth = (float)((self.frame.size.width -40 - HORIZONTAL_START_LINE*minOfTwo)/8);
    self.barWidth = (float)(f_barwidth*0.75);
    self.spaceBetweenBars = (float)(f_barwidth - self.barWidth);
}
@end



