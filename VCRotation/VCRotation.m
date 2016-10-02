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

 @property (nonatomic, assign) CGFloat currentRotation;

@property (nonatomic, assign) CGAffineTransform currentTransform;


@property (nonatomic, strong) CALayer *buttonLayer;


@end

@implementation VCRotation

- (instancetype)initWithFrame:(CGRect)frame minimumValue:(CGFloat)min maximunValue:(CGFloat)max withImage:(UIImage *)image {
    if (self = [super initWithFrame:frame]) {
        self.centerImage = image;
        _currentTransform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);

        
        
        self.buttonLayer = [CALayer layer];//[[CALayer alloc]initWithLayer:self.layer];
        self.buttonLayer.frame = CGRectMake(0.1*self.bounds.size.height, 0, self.bounds.size.height * 0.8,self.bounds.size.height * 0.8 );
        // self.buttonLayer.backgroundColor = [UIColor redColor].CGColor;
        self.buttonLayer.cornerRadius = CGRectGetWidth(self.bounds)/2;
        self.buttonLayer.contents = (__bridge id _Nullable)(ROTATION_IMAGE.CGImage);
        //self.currentTransform = //self.buttonLayer.transform;
        
        _currentRotation = 0;
        
        
        
        [self.layer addSublayer:self.buttonLayer];
        
        
        
        
    }
    return self;
}



- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super continueTrackingWithTouch:touch withEvent:event];
    
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGPoint starTouchPoint = [touch locationInView:self];
    //NSLog(@"-start: %@", NSStringFromCGPoint(starTouchPoint));
    
    CGPoint endTouchPoint = [touch previousLocationInView:self];
    //NSLog(@"-end: %@", NSStringFromCGPoint(endTouchPoint));

    CGFloat rotation = atan2f(starTouchPoint.y - center.y, starTouchPoint.x - center.x) - atan2f(endTouchPoint.y - center.y, endTouchPoint.x - center.x);
    
    
    
    
    
    //CGAffineTransform transform = CGAffineTransformRotate(self.currentTransform, rotationAngle);
    _currentTransform = CGAffineTransformRotate(_currentTransform, rotation);
    
    _currentRotation += rotation;
    
    
    
    _currentValue = 1 + _currentRotation/(2*M_PI);
    
    
    /*
    if (_currentRotation == 0) {
        _currentValue = 0;
    }
    
    */
    
    // _currentValue = _currentValue >= 0.75 ? 0.75 : _currentValue;
    
    
    NSLog(@"%f",_currentValue);
    
    // NSLog(@"%f",1+_currentRotation/(2*M_PI));
    
    
    [self changeIndicatorValueWithAngle:_currentValue];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return  YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
    //
    [self sendActionsForControlEvents:UIControlEventEditingDidEnd];
}


- (void)changeIndicatorValueWithAngle:(CGFloat)angle {
    
    
    //CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
    
    /*
    if (angle == 0) {
       
        NSLog(@"----");
    }
    
    */
    
    // NSLog(@"%f", angle);
    
    // NSLog(@"%f",_currentTransform);
    // CGFloat rotate = atanf(_currentTransform.b/_currentTransform.a);
    // NSLog(@"%f",rotate);
    
    
    /*
    if (angle >= 0.75) {
        return;
    }
    
    */
    
    
    
    
    [self.buttonLayer setAffineTransform:_currentTransform];
    
    
}







// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
// - (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
    
    
    
    
 

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    CGFloat center = rect.size.width / 2;
    CGRect imageRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    CGContextRef context = UIGraphicsGetCurrentContext();
    */
    //CGContextDrawImage(context, imageRect, self.centerImage.CGImage);
    //CGContextSaveGState(context);
    
    /*
    CGContextMoveToPoint(context, center, center);
    CGContextAddArc(context, center, center, center, 0, M_PI * 2, 0);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, imageRect, self.centerImage.CGImage);
//    CGContextRestoreGState(context);
    CGContextSaveGState(context);
    
    */
    
    /*
    CGContextTranslateCTM(context, center, center);
    CGContextConcatCTM(context, _currentTransform);
    CGContextTranslateCTM(context, -(center), -(center));
    CGContextDrawImage(context, imageRect, self.centerImage.CGImage);

    */
    
    

// }


@end
