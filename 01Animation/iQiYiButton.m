//
//  iQiYiButton.m
//  01Animation
//
//  Created by fgj on 2018/9/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "iQiYiButton.h"

static CGFloat animationDuration = .5f;
static CGFloat positionDuration = .3f;
//线条颜色
#define LineColor [UIColor colorWithRed:12/255.0 green:190/255.0 blue:6/255.0 alpha:1]
//三角动画名称
#define TriangleAnimation @"TriangleAnimation"
//右侧直线动画名称
#define RightLineAnimation @"RightLineAnimation"

@interface iQiYiButton()<CAAnimationDelegate>
{
    // 是否正在执行动画
    BOOL _isAnimating;
    CAShapeLayer * _leftLineLayer;
    CAShapeLayer * _rightLineLayer;
    CAShapeLayer * _triangleLayer;
    CAShapeLayer * _circleLayer;
    CGFloat _width;
}

@end

@implementation iQiYiButton

- (instancetype)initWithFrame:(CGRect)frame Status:(iQiYiButtonStatus)status
{
    self = [super initWithFrame:frame];
    _width= self.bounds.size.width;
    if (self)
    {
        [self buildUI];
        if (status == iQiYiButtonStattusPlay)
        {
            self.buttonSatus = status;
        }
    }
    return self;
}

- (void)buildUI
{
    _buttonSatus = iQiYiButtonStatusPause;
    //  左 竖线
    [self addLeftLineLayer];
    //  右 竖线
    [self addRightLineLayer];
    //  三角形
    [self addTriangleLayer];
    
}
 //  左 竖线
- (void)addLeftLineLayer
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_width*.2, 0)];
    [path addLineToPoint:CGPointMake(_width*.2, _width)];
    
    _leftLineLayer = [CAShapeLayer layer];
    _leftLineLayer.path = path.CGPath;
    _leftLineLayer.fillColor = [UIColor clearColor].CGColor;
    _leftLineLayer.strokeColor = LineColor.CGColor;
    _leftLineLayer.lineWidth = [self lineWidth];
    _leftLineLayer.lineCap = kCALineCapRound;
    _leftLineLayer.lineJoin = kCALineJoinRound;
    
    [self.layer addSublayer:_leftLineLayer];
}
  //  右 竖线
- (void)addRightLineLayer
{
    CGFloat a = self.bounds.size.width;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(a*0.8,a)];
    [path addLineToPoint:CGPointMake(a*0.8,0)];
    
    _rightLineLayer = [CAShapeLayer layer];
    _rightLineLayer.path = path.CGPath;
    _rightLineLayer.fillColor = [UIColor clearColor].CGColor;
    _rightLineLayer.strokeColor = LineColor.CGColor;
    _rightLineLayer.lineWidth = [self lineWidth];
    _rightLineLayer.lineCap = kCALineCapRound;
    _rightLineLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_rightLineLayer];
    
}

 //  三角形
- (void)addTriangleLayer
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(.2*_width, .2*_width)];
    [path addLineToPoint:CGPointMake(.2*_width, 0)];
    [path addLineToPoint:CGPointMake(_width, _width*.5)];
    [path addLineToPoint:CGPointMake(_width*.2, _width)];
    [path addLineToPoint:CGPointMake(.2*_width, .2*_width)];
    _triangleLayer = [CAShapeLayer layer];
    _triangleLayer.path = path.CGPath;
    _triangleLayer.fillColor = [UIColor clearColor].CGColor;
    _triangleLayer.strokeColor = LineColor.CGColor;
    _triangleLayer.lineWidth = [self lineWidth];
    _triangleLayer.lineCap = kCALineCapButt;
    _triangleLayer.lineJoin = kCALineJoinRound;
    _triangleLayer.strokeEnd = 0;
    [self.layer addSublayer:_triangleLayer];
}

// 弧形
- (void)addCircleLayer
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(.8*_width, _width*.8)];
    [path addArcWithCenter:CGPointMake(.5*_width, _width*.8) radius:.3*_width startAngle:0 endAngle:M_PI clockwise:true];
    _circleLayer = [CAShapeLayer layer];
    _circleLayer.path = path.CGPath;
    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    _circleLayer.strokeColor = LineColor.CGColor;
    _circleLayer.lineWidth = [self lineWidth];
    _circleLayer.lineCap = kCALineCapRound;
    _circleLayer.lineJoin = kCALineJoinRound;
    _circleLayer.strokeEnd = 0;
    [self.layer addSublayer:_circleLayer];
}
- (void)setButtonSatus:(iQiYiButtonStatus)buttonSatus
{
    if (_isAnimating == true)
    {
        return;
    }
    _buttonSatus = buttonSatus;
    // 竖线正向运动
    if (buttonSatus == iQiYiButtonStattusPlay)
    {
        _isAnimating = true;
         [self linePositiveAnimation];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(positionDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 画弧形 和三角形
            [self actionPositiveAnimation];
        });
    }
    else if (buttonSatus == iQiYiButtonStatusPause)
    {
        _isAnimating = true;
        // 先执行 画弧 画三角动作
        [self actionInverseAnimation];
    }
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(positionDuration*2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _isAnimating = false;
    });
    
}


//  暂停 === 播放 1
- (void)linePositiveAnimation {
    CGFloat a = self.bounds.size.width;
    
    //左侧缩放动画
    UIBezierPath *leftPath1 = [UIBezierPath bezierPath];
    [leftPath1 moveToPoint:CGPointMake(0.2*a,0.4*a)];
    [leftPath1 addLineToPoint:CGPointMake(0.2*a,a)];
    _leftLineLayer.path = leftPath1.CGPath;
    [_leftLineLayer addAnimation:[self pathAnimationWithDuration:positionDuration/2] forKey:nil];
    
    //右侧竖线位移动画
    UIBezierPath *rightPath1 = [UIBezierPath bezierPath];
    [rightPath1 moveToPoint:CGPointMake(0.8*a, 0.8*a)];
    [rightPath1 addLineToPoint:CGPointMake(0.8*a,-0.2*a)];
    _rightLineLayer.path = rightPath1.CGPath;
    [_rightLineLayer addAnimation:[self pathAnimationWithDuration:positionDuration/2] forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  positionDuration/2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        //左侧位移动画
        UIBezierPath *leftPath2 = [UIBezierPath bezierPath];
        [leftPath2 moveToPoint:CGPointMake(a*0.2,a*0.2)];
        [leftPath2 addLineToPoint:CGPointMake(a*0.2,a*0.8)];
        _leftLineLayer.path = leftPath2.CGPath;
        [_leftLineLayer addAnimation:[self pathAnimationWithDuration:positionDuration/2] forKey:nil];
        
        //右侧竖线缩放动画
        UIBezierPath *rightPath2 = [UIBezierPath bezierPath];
        [rightPath2 moveToPoint:CGPointMake(a*0.8,a*0.8)];
        [rightPath2 addLineToPoint:CGPointMake(a*0.8,a*0.2)];
        _rightLineLayer.path = rightPath2.CGPath;
        [_rightLineLayer addAnimation:[self pathAnimationWithDuration:positionDuration/2] forKey:nil];
    });
}

//  暂停 === 播放 2
- (void)actionPositiveAnimation
{
    //开始三角动画
    [self strokeEndAnimationFrom:0
                              to:1
                         onLayer:_triangleLayer name:TriangleAnimation duration:animationDuration delegate:self];
    //开始右侧线条动画
    [self strokeEndAnimationFrom:1 to:0 onLayer:_rightLineLayer name:RightLineAnimation duration:animationDuration/4 delegate:self];
    //    [self strokeEndAnimationFrom:1
    //                              to:0
    //                         onLayer:_rightLineLayer name:RightLineAnimation duration:animationDuration delegate:self];
    //开始画弧动画
    [self strokeEndAnimationFrom:0
                              to:1
                         onLayer:_circleLayer
                            name:nil duration:animationDuration/4 delegate:self];
    //开始逆向画弧动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration*0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self circleStartAnimationFrom:0 to:1];
    });
    //开始左侧线条缩短动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  animationDuration*0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        //左侧竖线动画
        [self strokeEndAnimationFrom:1 to:0 onLayer:_leftLineLayer name:nil duration:animationDuration/2 delegate:nil];
    });
}

//  播放 == 停止 1
- (void)actionInverseAnimation
{
    // 三角动画
    [self strokeEndAnimationFrom:1 to:0 onLayer:_triangleLayer name:TriangleAnimation duration:animationDuration delegate:self];
    // 左侧动画
    [self strokeEndAnimationFrom:0 to:1 onLayer:_leftLineLayer name:nil duration:animationDuration delegate:nil];
    // 执行画弧动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration*0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 右侧竖线动画
        [self strokeEndAnimationFrom:0 to:1 onLayer:_rightLineLayer name:RightLineAnimation duration:animationDuration/4 delegate:self];
    });
}

/**
 通用path动画方法
 */
- (CABasicAnimation *)pathAnimationWithDuration:(CGFloat)duration
{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = duration;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    return pathAnimation;
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

- (void)circleStartAnimationFrom:(CGFloat)fromValue to:(CGFloat)toValue {
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    circleAnimation.duration = animationDuration/4;
    circleAnimation.fromValue = @(fromValue);
    circleAnimation.toValue = @(toValue);
    circleAnimation.fillMode = kCAFillModeForwards;
    circleAnimation.removedOnCompletion = NO;
    [_circleLayer addAnimation:circleAnimation forKey:nil];
}


#pragma mark -
#pragma mark 动画开始、结束代理方法

//为了避免动画结束回到原点后会有一个原点显示在屏幕上需要做一些处理，就是改变layer的lineCap属性
-(void)animationDidStart:(CAAnimation *)anim {
    NSString *name = [anim valueForKey:@"animationName"];
    bool isTriangle = [name isEqualToString:TriangleAnimation];
    bool isRightLine = [name isEqualToString:RightLineAnimation];
    if (isTriangle) {
        _triangleLayer.lineCap = kCALineCapRound;
    }else if (isRightLine){
        _rightLineLayer.lineCap = kCALineCapRound;
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSString *name = [anim valueForKey:@"animationName"];
    bool isTriangle = [name isEqualToString:TriangleAnimation];
    bool isRightLine = [name isEqualToString:RightLineAnimation];
    if (_buttonSatus == iQiYiButtonStattusPlay && isRightLine) {
        _rightLineLayer.lineCap = kCALineCapButt;
    } else if (isTriangle) {
        _triangleLayer.lineCap = kCALineCapButt;
    }
}

- (CGFloat)lineWidth
{
    return self.bounds.size.width * .2;
}
@end
