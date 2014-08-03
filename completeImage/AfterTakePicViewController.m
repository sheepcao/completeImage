//
//  AfterTakePicViewController.m
//  completeImage
//
//  Created by 张力 on 14-8-3.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "AfterTakePicViewController.h"

@interface AfterTakePicViewController ()

@end

@implementation AfterTakePicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    UIImage *test = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"动物4inch" ofType:@"png"]];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:test];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
