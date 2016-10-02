//
//  VCRotation.h
//  VCRotationDemo
//
//  Created by VicChan on 2016/9/24.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCRotation : UIControl

/// 光条宽度
@property (nonatomic, assign) CGFloat lineWidth;
/// 当前代表值
@property (nonatomic, assign) CGFloat currentValue;
/// 光条颜色
@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, assign) CGFloat minimumAngle;
@property (nonatomic, assign) CGFloat maximumAngle;

@property (nonatomic, assign) CGFloat minimumValue;
@property (nonatomic, assign) CGFloat maximumValue;


@property (nonatomic, strong) UIImage *centerImage;


- (instancetype)initWithFrame:(CGRect)frame minimumValue:(CGFloat)min maximunValue:(CGFloat)max withImage:(UIImage *)image;

- (void)updateCurrentValue:(CGFloat)currentValue;



@end
