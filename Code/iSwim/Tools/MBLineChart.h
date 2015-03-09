#import "SHLineGraphView.h"

@interface MBLineChart : SHLineGraphView
@property (retain, nonatomic) UIScrollView *containererView;
@property (assign, nonatomic) float minWidth;

+ (MBLineChart *)initGraph:(NSString *)type yValues:(NSArray *)yValues xValues:(NSArray *)xValues zValues:(NSArray *)zValues avg:(NSString *)avgValue inView:(UIView *)view;

- (void)updateGraph:(float)scale;

@end;