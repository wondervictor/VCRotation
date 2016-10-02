//
//  ViewController.m
//  VCRotationDemo
//
//  Created by VicChan on 2016/9/24.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import "ViewController.h"
#import "VCRotation.h"


@interface ViewController ()<UITextFieldDelegate>


@property (nonatomic, strong) VCRotation *rotation;

@property (weak, nonatomic) IBOutlet UITextField *textField;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rotation = [[VCRotation alloc]initWithFrame:CGRectMake(0, 100, CGRectGetWidth([UIScreen mainScreen].bounds),CGRectGetWidth([UIScreen mainScreen].bounds) ) minimumValue:0 maximunValue:0 withImage:[UIImage imageNamed:@"rotationButton"]];
    [self.view addSubview:self.rotation];
    
    
    
    self.textField.delegate = self;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    CGFloat num = [textField.text floatValue];
    
    
    [self.rotation updateCurrentValue:num];
    
    
    [textField resignFirstResponder];
    
    
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
