//
//  ViewController.m
//  SQAlertView
//
//  Created by hjw119 on 16/4/28.
//  Copyright © 2016年 xincheng. All rights reserved.
//

#import "ViewController.h"
#import "SQTextAlertView.h"

typedef enum:NSInteger {
    SQTextAlertViewTarget_Default = 100000,
}SQTextAlertViewTarget;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self showAlertView];
}

- (void)viewDidAppear:(BOOL)animated {
    //[self showAlertView];
}
- (IBAction)onShowAlertView:(id)sender {
    [self showAlertView];
}

- (void)showAlertView {
    SQTextAlertView* alertView1 = [[SQTextAlertView alloc] initWithTitle:@"弹出框" message:@"这是弹出框1" messageRealSize:nil delegate:nil buttonTitles:@[@"OK"]];
    [alertView1 showWithTarget:1];
    
    SQTextAlertView* alertView2 = [[SQTextAlertView alloc] initWithTitle:@"弹出框" message:@"这是弹出框2" messageRealSize:nil delegate:nil buttonTitles:@[@"OK"]];
    [alertView2 showWithTarget:1];
    
    SQTextAlertView* alertView3 = [[SQTextAlertView alloc] initWithTitle:@"弹出框" message:@"这是弹出框3" messageRealSize:nil delegate:nil buttonTitles:@[@"OK"]];
    [alertView3 showWithTarget:3];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        SQTextAlertView* alertView4 = [[SQTextAlertView alloc] initWithTitle:@"弹出框" message:@"这是弹出框4" messageRealSize:nil delegate:nil buttonTitles:@[@"OK"]];
        [alertView4 showWithTarget:4];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
