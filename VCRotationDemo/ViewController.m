//
//  ViewController.m
//  VCRotationDemo
//
//  Created by VicChan on 2016/9/24.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import "ViewController.h"
#import "VCRotation.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    VCRotation *rotation = [[VCRotation alloc]initWithFrame:CGRectMake(0, 100, CGRectGetWidth([UIScreen mainScreen].bounds),CGRectGetWidth([UIScreen mainScreen].bounds) ) minimumValue:0 maximunValue:0 withImage:[UIImage imageNamed:@"rotationButton"]];
    [self.view addSubview:rotation];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
