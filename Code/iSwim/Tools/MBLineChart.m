//
//  MBLineChart.m
//  iSwim
//
//  Created by Magic Beans on 15/1/26.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "MBLineChart.h"
#import "SHPlot.h"
@implementation MBLineChart

- (void)initGraph:(NSString *)type yValues:(NSArray *)yValues xValues:(NSArray *)xValues
{
    
    if(yValues.count == 0)
        return;
    
    NSNumber * big =yValues[0];
    for (int i = 0; i<yValues.count; i++) {
        if ([yValues[i] floatValue] > [big floatValue]) {
            big = yValues[i];
        }
    }

    
    //initate the graph view
    SHLineGraphView *_lineGraph = self;
    //set the main graph area theme attributes
    /**
     *  theme attributes dictionary. you can specify graph theme releated attributes in this dictionary. if this property is
     *  nil, then a default theme setting is applied to the graph.
     */
    NSDictionary *_themeAttributes = @{
                                       kXAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                       kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                       kYAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                       kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:0],
                                       kPlotBackgroundLineColorKye : [UIColor clearColor]
                                       };
    _lineGraph.themeAttributes = _themeAttributes;
    
    //set the line graph attributes
    
    /**
     *  the maximum y-value possible in the graph. make sure that the y-value is not in the plotting points is not greater
     *  then this number. otherwise the graph plotting will show wrong results.
     */
    _lineGraph.yAxisRange = big;
    
    /**
     *  y-axis values are calculated according to the yAxisRange passed. so you do not have to pass the explicit labels for
     *  y-axis, but if you want to put any suffix to the calculated y-values, you can mention it here (e.g. K, M, Kg ...)
     */
    _lineGraph.yAxisSuffix = @"K";
    
    /**
     *  an Array of dictionaries specifying the key/value pair where key is the object which will identify a particular
     *  x point on the x-axis line. and the value is the label which you want to show on x-axis against that point on x-axis.
     *  the keys are important here as when plotting the actual points on the graph, you will have to use the same key to
     *  specify the point value for that x-axis point.
     */
    NSMutableArray *xAxisValues = [NSMutableArray array];
    for (int i = 0; i < xValues.count; i++)
    {
        [xAxisValues addObject:@{[NSNumber numberWithInt:i+1]:xValues[i]}];
    }
    _lineGraph.xAxisValues = xAxisValues;
    
    //create a new plot object that you want to draw on the `_lineGraph`
    SHPlot *_plot1 = [[SHPlot alloc] init];
    //set the plot attributes
    /**
     *  Array of dictionaries, where the key is the same as the one which you specified in the `xAxisValues` in `SHLineGraphView`,
     *  the value is the number which will determine the point location along the y-axis line. make sure the values are not
     *  greater than the `yAxisRange` specified in `SHLineGraphView`.
     */
    
    NSMutableArray *plottingValues = [NSMutableArray array];
    for (int i = 0; i < yValues.count; i++)
    {
        [plottingValues addObject:@{[NSNumber numberWithInt:i+1]:yValues[i]}];
    }

    _plot1.plottingValues = plottingValues;
    /**
     *  this is an optional array of `NSString` that specifies the labels to show on the particular points. when user clicks on
     *  a particular points, a popover view is shown and will show the particular label on for that point, that is specified
     *  in this array.
     */
    NSArray *arr = @[@"1", @"2", @"3", @"4", @"5", @"6" , @"7" , @"8", @"9", @"10", @"11", @"12"];
    _plot1.plottingPointsLabels = arr;
    
    //set plot theme attributes
    
    /**
     *  the dictionary which you can use to assing the theme attributes of the plot. if this property is nil, a default theme
     *  is applied selected and the graph is plotted with those default settings.
     */
    NSDictionary *_plotThemeAttributes = @{
                                           kPlotFillColorKey : [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:0.6],
                                           kPlotStrokeWidthKey : @2,
                                           kPlotStrokeColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointFillColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
                                           };
    _plot1.plotThemeAttributes = _plotThemeAttributes;
    [_lineGraph addPlot:_plot1];
    
    [_lineGraph setupTheView];
    //You can as much `SHPlots` as you can in a `SHLineGraphView` 
}

+ (MBLineChart *)initGraph:(NSString *)type yValues:(NSArray *)yValues xValues:(NSArray *)xValues inView:(UIView *)view
{
    
    CGSize size = view.frame.size;
    
    if(yValues.count == 0)
        return nil;
    
    NSNumber * big =yValues[0];
    for (int i = 0; i<yValues.count; i++) {
        if ([yValues[i] floatValue] > [big floatValue]) {
            big = yValues[i];
        }
    }
    
    
    CGRect graphFrame = CGRectMake(0, 0, size.width /** ceilf(yValues.count / 10.0)*/, size.height);
    //initate the graph view
    MBLineChart *_lineGraph = [[MBLineChart alloc] initWithFrame:graphFrame];
    //set the main graph area theme attributes
    /**
     *  theme attributes dictionary. you can specify graph theme releated attributes in this dictionary. if this property is
     *  nil, then a default theme setting is applied to the graph.
     */
    NSDictionary *_themeAttributes = @{
                                       kXAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                       kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                       kYAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                       kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:0],
                                       kPlotBackgroundLineColorKye : [UIColor clearColor]
                                       };
    _lineGraph.themeAttributes = _themeAttributes;
    
    //set the line graph attributes
    
    /**
     *  the maximum y-value possible in the graph. make sure that the y-value is not in the plotting points is not greater
     *  then this number. otherwise the graph plotting will show wrong results.
     */
    _lineGraph.yAxisRange = big;
    
    /**
     *  y-axis values are calculated according to the yAxisRange passed. so you do not have to pass the explicit labels for
     *  y-axis, but if you want to put any suffix to the calculated y-values, you can mention it here (e.g. K, M, Kg ...)
     */
    _lineGraph.yAxisSuffix = @"K";
    
    /**
     *  an Array of dictionaries specifying the key/value pair where key is the object which will identify a particular
     *  x point on the x-axis line. and the value is the label which you want to show on x-axis against that point on x-axis.
     *  the keys are important here as when plotting the actual points on the graph, you will have to use the same key to
     *  specify the point value for that x-axis point.
     */
    NSMutableArray *xAxisValues = [NSMutableArray array];
    for (int i = 0; i < xValues.count; i++)
    {
        [xAxisValues addObject:@{[NSNumber numberWithInt:i+1]:xValues[i]}];
    }
    _lineGraph.xAxisValues = xAxisValues;
    
    //create a new plot object that you want to draw on the `_lineGraph`
    SHPlot *_plot1 = [[SHPlot alloc] init];
    //set the plot attributes
    /**
     *  Array of dictionaries, where the key is the same as the one which you specified in the `xAxisValues` in `SHLineGraphView`,
     *  the value is the number which will determine the point location along the y-axis line. make sure the values are not
     *  greater than the `yAxisRange` specified in `SHLineGraphView`.
     */
    
    NSMutableArray *plottingValues = [NSMutableArray array];
    for (int i = 0; i < yValues.count; i++)
    {
        [plottingValues addObject:@{[NSNumber numberWithInt:i+1]:yValues[i]}];
    }
    
    _plot1.plottingValues = plottingValues;
    /**
     *  this is an optional array of `NSString` that specifies the labels to show on the particular points. when user clicks on
     *  a particular points, a popover view is shown and will show the particular label on for that point, that is specified
     *  in this array.
     */
    NSArray *arr = @[@"1", @"2", @"3", @"4", @"5", @"6" , @"7" , @"8", @"9", @"10", @"11", @"12"];
    _plot1.plottingPointsLabels = arr;
    
    //set plot theme attributes
    
    /**
     *  the dictionary which you can use to assing the theme attributes of the plot. if this property is nil, a default theme
     *  is applied selected and the graph is plotted with those default settings.
     */
    NSDictionary *_plotThemeAttributes = @{
                                           kPlotFillColorKey : [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:0.6],
                                           kPlotStrokeWidthKey : @1,
                                           kPlotStrokeColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointFillColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
                                           };
    _plot1.plotThemeAttributes = _plotThemeAttributes;
    [_lineGraph addPlot:_plot1];
    
    [_lineGraph setupTheView];
    
    _lineGraph.containererView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [_lineGraph.containererView setContentSize:_lineGraph.frame.size];
    [_lineGraph.containererView addSubview:_lineGraph];
    [view addSubview:_lineGraph.containererView];
    _lineGraph.minWidth = _lineGraph.frame.size.width;
    return _lineGraph;
}

- (void)updateGraph:(float)scale
{
    CGRect rect = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width * scale, self.frame.size.height);
    if (rect.size.width > self.minWidth)
    {//放大缩小
        for (UIView *view in self.subviews)
        {
            [view removeFromSuperview];
        }
        self.frame = rect;
        [self.containererView setContentSize:self.frame.size];

        [bgLayer removeFromSuperlayer];
        [lineLayer removeFromSuperlayer];
        [pointLayer removeFromSuperlayer];
        [self setupTheView];
    }
    else
    {//缩小限制
        rect.size.width = self.minWidth;
        for (UIView *view in self.subviews)
        {
            [view removeFromSuperview];
        }
        self.frame = rect;
        [self.containererView setContentSize:self.frame.size];
        
        [bgLayer removeFromSuperlayer];
        [lineLayer removeFromSuperlayer];
        [pointLayer removeFromSuperlayer];
        [self setupTheView];

    }
}
@end
