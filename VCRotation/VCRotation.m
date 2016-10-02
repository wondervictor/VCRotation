//
//  VCRotation.m
//  VCRotationDemo
//
//  Created by VicChan on 2016/9/24.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#define ROTATION_IMAGE ([UIImage imageNamed:@"rotationButton"])
#define DEGREES_2_RADIANS(x) (0.0174532925 * (x))
#define DEFAULT_COLOR  ([UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1])
#define TINT_COLOR  ([UIColor colorWithRed:80/255.0 green:193/255.0 blue:227/255.0 alpha:1])


#import "VCRotation.h"

@interface  VCRotation()


@property (nonatomic, assign) CGAffineTransform currentTransform;

@property (nonatomic, assign) CGFloat currentRotation;


@property (nonatomic, strong) CALayer *buttonLayer;

@property (nonatomic, strong) CAShapeLayer *indicatorLayer;

@end

@implementation VCRotation

- (instancetype)initWithFrame:(CGRect)frame minimumValue:(CGFloat)min maximunValue:(CGFloat)max withImage:(UIImage *)image {
    if (self = [super initWithFrame:frame]) {
        self.centerImage = image;
        _currentTransform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
        _currentRotation = 0;
        
        self.buttonLayer = [CALayer layer];
        self.buttonLayer.frame = CGRectMake(0.1*self.bounds.size.height, 0.1*self.bounds.size.height, self.bounds.size.height * 0.8,self.bounds.size.height * 0.8 );
        self.buttonLayer.cornerRadius = CGRectGetWidth(self.bounds)/2;
        self.buttonLayer.contents = (__bridge id _Nullable)(ROTATION_IMAGE.CGImage);
        
        
        
        
        /*
        self.indicatorLayer = [CAShapeLayer layer];
        
        UIBezierPath *circle = [UIBezierPath bezierPathWithArcCenter:self.center radius:self.bounds.size.width/2 - 10 startAngle:5*M_PI/4 endAngle:3*M_PI/4 clockwise:YES];
        self.indicatorLayer.position = self.center;
        self.indicatorLayer.frame = self.bounds;
        
        self.indicatorLayer.fillColor = [UIColor clearColor].CGColor;
        self.indicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
        self.indicatorLayer.path = circle.CGPath;
        
        self.indicatorLayer.lineWidth = 4.0;
        self.indicatorLayer.strokeColor = [UIColor cyanColor].CGColor;
        
        self.indicatorLayer.strokeStart = 0;
        self.indicatorLayer.strokeEnd = 1;
        
         
         
        // NSLog(@"%@",NSStringFromCGRect(self.indicatorLayer.frame));
        
        [self.layer addSublayer:self.indicatorLayer];
        */
        [self.layer addSublayer:self.buttonLayer];
        
        
    }
    return self;
}



- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super continueTrackingWithTouch:touch withEvent:event];
    
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGPoint starTouchPoint = [touch locationInView:self];
    CGPoint endTouchPoint = [touch previousLocationInView:self];
    CGFloat rotation = atan2f(starTouchPoint.y - center.y, starTouchPoint.x - center.x) - atan2f(endTouchPoint.y - center.y, endTouchPoint.x - center.x);
    
    
    _currentTransform = CGAffineTransformRotate(_currentTransform, rotation);
    
    
    CGFloat rotate = atan2f(_currentTransform.b,_currentTransform.a);
    

    CGFloat degree = rotate * (180/M_PI);
    
    if (degree >= -90 && degree < 0) {
        return YES;
    }
    
    _currentValue = [self getValueWithAngle:degree];
    
    
    [self.buttonLayer setAffineTransform:_currentTransform];
    
    [self setNeedsDisplay];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return  YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];

    [self sendActionsForControlEvents:UIControlEventEditingDidEnd];
}

- (CGFloat)getValueWithAngle:(CGFloat)degree {
    CGFloat value = 0;
    if (degree <= 180 && degree >= 0) {
        value = degree / 360;
    } else if (degree < 0 && degree <= 360) {
        value = 1 + degree / 360;
    }
    return value * 4/3;
}

- (void)changeAngleWithValue:(CGFloat)value {
    CGFloat degree = 0;
    value = value * 3/4;
    if (value <= 0.5) {
        degree = value * 360;
    } else if (value > 0.5 && value <= 1) {
        degree = (value - 1) * 360;
    }
    
    CGFloat rotation = degree * M_PI / 180;
    
    CGFloat a = cos(rotation);
    CGFloat b = sin(rotation);
    
    CGFloat rotate = atan2f(b, a);
    
    CGAffineTransform transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
    _currentTransform = CGAffineTransformRotate(transform, rotate);

    [self.buttonLayer setAffineTransform:_currentTransform];
    
    
    

}


- (void)updateCurrentValue:(CGFloat)currentValue {
    [self changeAngleWithValue:currentValue];
}


- (void)drawRect:(CGRect)rect {
    
    
    CGFloat width = rect.size.width;
    
    CGPoint center = CGPointMake(width/2.0, width/2.0);
    CGFloat radius = width * 0.4;
    CGFloat lineWidth = radius * 0.3;
    
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    // 轨道
    const CGFloat *component = CGColorGetComponents(DEFAULT_COLOR.CGColor);
    CGContextSetStrokeColor(context, component);
    CGContextSetLineWidth(context, lineWidth);
    CGContextAddArc(context, center.x, center.y, radius, 0 , 2* M_PI, YES);
    CGContextDrawPath(context, kCGPathStroke);
    
    
    // tint
    
    const CGFloat *compont = CGColorGetComponents(TINT_COLOR.CGColor);
    CGContextSetStrokeColor(context, compont);
    
    
    CGContextSetLineWidth(context, lineWidth * 0.3);
    /// 获取旋转角
    
    radius =  radius+ lineWidth * 0.2;
    
    CGContextAddArc(context, center.x, center.y, radius , 3 * M_PI/4, [self getAngle], NO);
    CGContextDrawPath(context, kCGPathStroke);
    
    
    
    /// 原点
    
    CGPoint originPoint = CGPointMake(center.x - radius*cos(DEGREES_2_RADIANS(42)) , center.y + radius*sin(DEGREES_2_RADIANS(42)));
    [TINT_COLOR setFill];
    CGContextFillEllipseInRect(context, CGRectMake(originPoint.x , originPoint.y, lineWidth * 0.3, lineWidth * 0.3 ));
    
    

    
    /*
    CGPoint centerPoint = CGPointMake(center - lineOffset, center - lineOffset);
    CGPoint dotPoint;
    dotPoint.y = round(centerPoint.y + (centerPoint.y - self.contextPadding / 2) * sin(_rotation));
    dotPoint.x = round(centerPoint.x + (centerPoint.x - self.contextPadding / 2) * cos(_rotation));
    [self.indicatorColor set];
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 4, [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor);
    CGContextFillEllipseInRect(context, CGRectMake((dotPoint.x), (dotPoint.y), self.lineWidth, self.lineWidth));

     
     */
    
    
    
    
    
    
    
    
}


- (CGFloat)getAngle {
    CGFloat rotation;
    
    CGFloat angle = atan2f(_currentTransform.b,_currentTransform.a);
    
    rotation = angle + 3*M_PI/4;
    

    return rotation;
}




@end
