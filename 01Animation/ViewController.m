//
//  ViewController.m
//  01Animation
//
//  Created by fgj on 2018/9/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "iQiYiButton.h"
#import "YoukuButton.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    iQiYiButton *button = [[iQiYiButton alloc]initWithFrame:CGRectMake(30, 10, 60, 60) Status:iQiYiButtonStatusPause];
//    [self.view addSubview:button];
//
//    button.center = CGPointMake(self.view.center.x, self.view.bounds.size.height/3);
//    [button addTarget:self action:@selector(iQiYiPlayMethod:) forControlEvents:UIControlEventTouchUpInside];
    YoukuButton *button = [[YoukuButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60) Status:youkuButtonStattusPlay];
    [self.view addSubview:button];
    button.center = CGPointMake(self.view.center.x, self.view.bounds.size.height/3);
    
    [button addTarget:self action:@selector(youkuPlayMethod:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)youkuPlayMethod:(iQiYiButton *)button
     {
         if (button.buttonSatus == youkuButtonStattusPlay)
         {
             button.buttonSatus = youkuButtonStattusPlay;
         }
         else
         {
             button.buttonSatus= youkuButtonStatusPause;
         }
     }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
