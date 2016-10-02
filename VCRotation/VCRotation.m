//
//  VCRotation.m
//  VCRotationDemo
//
//  Created by VicChan on 2016/9/24.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#define ROTATION_IMAGE [UIImage imageNamed:@"rotationButton"]


#import "VCRotation.h"

@interface  VCRotation()


@property (nonatomic, assign) CGAffineTransform currentTransform;

@property (nonatomic, strong) CALayer *buttonLayer;


@end

@implementation VCRotation

- (instancetype)initWithFrame:(CGRect)frame minimumValue:(CGFloat)min maximunValue:(CGFloat)max withImage:(UIImage *)image {
    if (self = [super initWithFrame:frame]) {
        self.centerImage = image;
        _currentTransform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);

        
        
        self.buttonLayer = [CALayer layer];
        self.buttonLayer.frame = CGRectMake(0.1*self.bounds.size.height, 0.1*self.bounds.size.height, self.bounds.size.height * 0.8,self.bounds.size.height * 0.8 );
        self.buttonLayer.cornerRadius = CGRectGetWidth(self.bounds)/2;
        self.buttonLayer.contents = (__bridge id _Nullable)(ROTATION_IMAGE.CGImage);
        
        
        
        
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


@end
