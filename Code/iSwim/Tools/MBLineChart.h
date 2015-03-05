#import "SHLineGraphView.h"

@interface MBLineChart : SHLineGraphView
+ (UIScrollView *)initGraph:(NSString *)type yValues:(NSArray *)yValues xValues:(NSArray *)xValues inView:(UIView *)view;
@end;