//
//  KICropImageView.m
//  Kitalker
//
//  Created by 杨 烽 on 12-8-9.
//
//


#define PI 3.14159265358979323846

#import "KICropImageView.h"

@implementation KICropImageView

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [[self scrollView] setFrame:self.bounds];
    [[self maskView] setFrame:self.bounds];
    self.backgroundColor=[UIColor blackColor];
    
    if (CGSizeEqualToSize(_cropSize, CGSizeZero)) {
        [self setCropSize:CGSizeMake(100, 100)];
    }
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        [_scrollView setDelegate:self];
        [_scrollView setBounces:YES];
        _scrollView.backgroundColor=[UIColor clearColor];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        [[self scrollView] addSubview:_imageView];
    }
    return _imageView;
}

- (KICropImageMaskView *)maskView {
    if (_maskView == nil) {
        _maskView = [[KICropImageMaskView alloc] init];
        [_maskView setBackgroundColor:[UIColor clearColor]];
        [_maskView setUserInteractionEnabled:NO];
        [self addSubview:_maskView];
        [self bringSubviewToFront:_maskView];
    }
    return _maskView;
}

- (void)setImage:(UIImage *)image {
    if (image != _image) {

        _image = nil;
        _image = image;
    }
    [[self imageView] setImage:_image];
    
    [self updateZoomScale];
}

- (void)updateZoomScale {
    CGFloat width = _image.size.width;
    CGFloat height = _image.size.height;
    
    [[self imageView] setFrame:CGRectMake(0, 0, width, height)];
    
    CGFloat xScale = _cropSize.width / width;
    CGFloat yScale = _cropSize.height / height;
    
    CGFloat min = MAX(xScale, yScale);
    CGFloat max = 1.0;
    //    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
    //        max = 1.0 / [[UIScreen mainScreen] scale];
    //    }
    
    if (min > max) {
        min = max;
    }
    
    
    
    [[self scrollView] setMinimumZoomScale:min];
    [[self scrollView] setMaximumZoomScale:max + 5.0f];
    
    
    [[self scrollView] setZoomScale:max/2 animated:YES];
//    [[self scrollView] setContentOffset:CGPointMake(0, 0)];
}

- (void)setCropSize:(CGSize)size {
    _cropSize = size;
    [self updateZoomScale];
    
    CGFloat width = _cropSize.width;
    CGFloat height = _cropSize.height;
    
    CGFloat x = (CGRectGetWidth(self.bounds) - width) / 2;
    CGFloat y = (CGRectGetHeight(self.bounds) - height) / 2;
    
    [((KICropImageMaskView *)[self maskView]) setCropSize:_cropSize];
    
    CGFloat top = y;
    CGFloat left = x;
    CGFloat right = CGRectGetWidth(self.bounds)- width - x;
    CGFloat bottom = CGRectGetHeight(self.bounds)- height - y;
    _imageInset = UIEdgeInsetsMake(top, left, bottom, right);
    [[self scrollView] setContentInset:_imageInset];
    
    [[self scrollView] setContentOffset:CGPointMake(0, 0)];
}

- (UIImage *)cropImage {
    CGFloat zoomScale = [self scrollView].zoomScale;
    
    CGFloat offsetX = [self scrollView].contentOffset.x;
    CGFloat offsetY = [self scrollView].contentOffset.y;
    CGFloat aX = offsetX>=0 ? offsetX+_imageInset.left : (_imageInset.left - ABS(offsetX));
    CGFloat aY = offsetY>=0 ? offsetY+_imageInset.top : (_imageInset.top - ABS(offsetY));
    
    aX = aX / zoomScale;
    aY = aY / zoomScale;
    
    CGFloat aWidth =  MAX(_cropSize.width / zoomScale, _cropSize.width);
    CGFloat aHeight = MAX(_cropSize.height / zoomScale, _cropSize.height);
    
    if (zoomScale < 1)
    {
        aWidth = MAX(_cropSize.width / zoomScale, _cropSize.width);
        aHeight = MAX(_cropSize.height / zoomScale, _cropSize.height);
    }
    
    
#ifdef DEBUG
    NSLog(@"%f--%f--%f--%f", aX, aY, aWidth, aHeight);
#endif
    
    UIImage *image = [_image cropImageWithX:aX y:aY width:aWidth height:aHeight];
    
    image = [image resizeToWidth:_cropSize.width height:_cropSize.height];
    
    return image;
}

#pragma UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [self imageView];
}
@end

#pragma KISnipImageMaskView

#define kMaskViewBorderWidth 3.0f

@implementation KICropImageMaskView

- (void)setCropSize:(CGSize)size {
    CGFloat x = (CGRectGetWidth(self.bounds) - size.width) / 2;
    CGFloat y = (CGRectGetHeight(self.bounds) - size.height) / 2;
    _cropRect = CGRectMake(x, y, size.width, size.height);
    
    [self setNeedsDisplay];
}

- (CGSize)cropSize {
    return _cropRect.size;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
//    //画矩形切图框
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextSetRGBFillColor(ctx, 0, 0, 0, 0.5);
//    CGContextFillRect(ctx, self.bounds);
//    
//    //画带边框的空心正方形
//    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
//    CGContextStrokeRectWithWidth(ctx, _cropRect, kMaskViewBorderWidth);
//    CGContextFillEllipseInRect(ctx, _cropRect);
//    CGContextClearRect(ctx, _cropRect);
    
    //画空心圆
    //圆的半径
    //    CGFloat radius=_cropRect.size.width/2;
    //    CGContextSetRGBStrokeColor(ctx,1,1,1,1.0);//画笔线的颜色
    //    CGContextSetLineWidth(ctx, kMaskViewBorderWidth);//线的宽度
    //    CGContextAddArc(ctx, _cropRect.origin.x+radius, _cropRect.origin.y+radius, radius, 0, 2*PI, 0); //添加一个圆
    //    CGContextDrawPath(ctx, kCGPathStroke); //绘制路径
    
    
    //化实心圆
    //    CGContextSetFillColorWithColor(ctx,[UIColor redColor].CGColor);//填充色
    //    CGContextFillEllipseInRect(ctx, _cropRect);
    
    //填充一个圆
    //    CGContextAddEllipseInRect(ctx, _cropRect);
    //    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor redColor] CGColor]));
    //    CGContextFillPath(ctx);
    
    
    //画圆形切图框
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(contextRef);
    CGContextSetRGBFillColor(contextRef, 0, 0, 0, 0.5);
    CGContextSetLineWidth(contextRef, 13);

    //创建圆形框UIBezierPath:
    UIBezierPath *pickingFieldPath = [UIBezierPath bezierPathWithOvalInRect:_cropRect];
    //创建外围大方框UIBezierPath:
    UIBezierPath *bezierPathRect = [UIBezierPath bezierPathWithRect:rect];
    //将圆形框path添加到大方框path上去，以便下面用奇偶填充法则进行区域填充：
    [bezierPathRect appendPath:pickingFieldPath];
    
    //填充使用奇偶法则
    bezierPathRect.usesEvenOddFillRule = YES;
    [bezierPathRect fill];
    CGContextSetLineWidth(contextRef, kMaskViewBorderWidth);
    CGContextSetRGBStrokeColor(contextRef, 255, 255, 255, 1);
    
    //默认画实线
    
    //画虚线
    //CGFloat dash[2] = {4,4};
    //[pickingFieldPath setLineDash:dash count:2 phase:0];
    
    //开画
    [pickingFieldPath stroke];
    CGContextRestoreGState(contextRef);
    self.layer.contentsGravity = kCAGravityCenter;
}
@end
