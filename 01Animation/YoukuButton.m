//
//  YoukuButton.m
//  01Animation
//
//  Created by fgj on 2018/9/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YoukuButton.h"
static CGFloat animationDuration = .5f;
static CGFloat positionDuration = .3f;

//线条颜色
#define LineColor [UIColor colorWithRed:12/255.0 green:190/255.0 blue:6/255.0 alpha:1]
//三角动画名称
#define TriangleAnimation @"TriangleAnimation"
//右侧直线动画名称
#define RightLineAnimation @"RightLineAnimation"


@interface YoukuButton()
{
    CAShapeLayer * _leftLineLayer;
    CAShapeLayer * _rightLineLayer;
    CAShapeLayer * _downCircleLayer;
    CAShapeLayer * _upCircleLayer;
    CGFloat _width;
}
@end


@implementation YoukuButton
- (instancetype)initWithFrame:(CGRect)frame Status:(youkuButtonStatus)status;
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _width = self.bounds.size.width;
        [self buildUI];
        
    }
    return self;
}

- (void)buildUI
{
    //[self addLeftLineLayer];
   // [self addRightLineLayer];
    [self addDownTriangleLayer];
   // [self addUpTrianglelayer];
}

- (void)addLeftLineLayer
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_width *.2, _width *.9)];
    [path addLineToPoint:CGPointMake(_width *.2, _width*.1)];
    _leftLineLayer = [CAShapeLayer layer];
    _leftLineLayer.path = path.CGPath;
    _leftLineLayer.fillColor = [UIColor clearColor].CGColor;
    _leftLineLayer.strokeColor = LineColor.CGColor;
    _leftLineLayer.lineWidth = [self lineWidth];
    _leftLineLayer.lineCap = kCALineCapRound;
    _leftLineLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_leftLineLayer];
}

- (void)addRightLineLayer
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_width * .8, _width *.1)];
    [path addLineToPoint:CGPointMake(_width *.8, _width*.9)];
    _rightLineLayer = [CAShapeLayer layer];
    _rightLineLayer.path = path.CGPath;
    _rightLineLayer.fillColor = [UIColor clearColor].CGColor;
    _rightLineLayer.strokeColor = LineColor.CGColor;
    _rightLineLayer.lineWidth = [self lineWidth];
    _rightLineLayer.lineCap = kCALineCapRound;
    _rightLineLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_rightLineLayer];
}

- (void)addUpTrianglelayer
{
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(_width*.8, _width*.1)];
//    CGFloat startAngle = -asin(4.0/5.0);
//    CGFloat endAngle = startAngle - M_PI;
   // path
}

- (void)addDownTriangleLayer
{
    
    CGFloat startAngle = acos(4.0/5.0)+M_PI_2;
    CGFloat endAngle = startAngle - M_PI;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(.2*_width,.9*_width) radius:.5*_width startAngle:startAngle endAngle:endAngle clockwise:false];
    
    _downCircleLayer = [CAShapeLayer layer];
    _downCircleLayer.path = path.CGPath;
    _downCircleLayer.fillColor = [UIColor clearColor].CGColor;
    _downCircleLayer.strokeColor = LineColor.CGColor;
    _downCircleLayer.lineWidth = [self lineWidth];
    _downCircleLayer.lineCap = kCALineCapRound;
    _downCircleLayer.lineJoin = kCALineJoinRound;
    _downCircleLayer.strokeEnd = 0;
    [self.layer addSublayer:_downCircleLayer];
}

- (void)circleStartAnimationFrom:(CGFloat)fromValue to:(CGFloat)toValue {
//    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
//    circleAnimation.duration = animationDuration/4;
//    circleAnimation.fromValue = @(fromValue);
//    circleAnimation.toValue = @(toValue);
//    circleAnimation.fillMode = kCAFillModeForwards;
//    circleAnimation.removedOnCompletion = NO;
//    [_circleLayer addAnimation:circleAnimation forKey:nil];
}

- (void)setButtonSatus:(youkuButtonStatus)buttonSatus
{
    [self linePositiveAnimation];
    [self strokeEndAnimationFrom:0 to:1 onLayer:_downCircleLayer name:nil duration:positionDuration*2 delegate:nil];
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(positionDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
        });
   
}

- (void)linePositiveAnimation
{
    UIBezierPath *leftPath1 = [UIBezierPath bezierPath];
    [leftPath1 moveToPoint:CGPointMake(.2*_width, _width*.8)];
    [leftPath1 addLineToPoint:CGPointMake(.2*_width, _width)];
    
    _leftLineLayer.path = leftPath1.CGPath;
    [_leftLineLayer addAnimation:[self pathAnimationWithDuration:positionDuration/2] forKey:nil];
}

- (CABasicAnimation *)strokeEndAnimationFrom:(CGFloat)fromValue to:(CGFloat)toValue onLayer:(CALayer *)layer name:(NSString*)animationName duration:(CGFloat)duration delegate:(id)delegate {
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = duration;
    strokeEndAnimation.fromValue = @(fromValue);
    strokeEndAnimation.toValue = @(toValue);
    strokeEndAnimation.fillMode = kCAFillModeForwards;
    strokeEndAnimation.removedOnCompletion = NO;
    [strokeEndAnimation setValue:animationName forKey:@"animationName"];
    strokeEndAnimation.delegate = delegate;
    [layer addAnimation:strokeEndAnimation forKey:nil];
    return strokeEndAnimation;
}

- (CABasicAnimation *)pathAnimationWithDuration:(CGFloat)duration {
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = duration;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    return pathAnimation;
}

- (CGFloat)lineWidth
{
    return self.bounds.size.width * .2;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
