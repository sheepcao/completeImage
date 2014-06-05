//
//  ViewController.m
//  completeImage
//
//  Created by 张力 on 14-6-4.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

bool blank[4] = {YES,NO,NO,NO};

int correct = 1;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.empty = [[UIButton alloc] initWithFrame:CGRectMake(136, 287, 55, 55)];
    self.empty.tag = 0;
    

    [self setButton:self.empty];
    [self setButton:self.answer1];
    [self setButton:self.answer2];
    [self setButton:self.answer3];
    
    
    [self.view addSubview:self.empty];
    
    [self.empty removeTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)setButton:(UIButton *)btn
{
    btn.layer.borderWidth = 1.0f;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)buttonTap:(UIButton *)sender
{

    
    if (sender.tag == 0) {
            if (!blank[sender.tag]) {
                [self.empty setImage:nil forState:UIControlStateNormal];
                if (blank[1] == YES) {
                    [self.answer1 setHidden:NO];
                    blank[1] = NO;

                }
                if (blank[2] == YES) {
                    [self.answer2 setHidden:NO];
                    blank[2] = NO;

                }
                if (blank[3] == YES) {
                    [self.answer3 setHidden:NO];
                    blank[3] = NO;

                }
            
            }
        [self.empty removeTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];


    }else
    {
        
        for (int i=1; i<4; i++) {
            if (blank[i] ==YES) {
                return;
            }
        }
        
        if (sender.tag == 1) {
            if (!blank[sender.tag]) {
                [self.answer1 setHidden:YES];
                blank[sender.tag] = YES;
                [self.empty setImage:self.answer1.imageView.image forState:UIControlStateNormal];
                blank[0] = NO;
            }
        }
        if (sender.tag == 2) {
            
            if (!blank[sender.tag]) {
                [self.answer2 setHidden:YES];
                blank[sender.tag] = YES;
                [self.empty setImage:self.answer2.imageView.image forState:UIControlStateNormal];
                blank[0] = NO;
                
            }
        }
        if (sender.tag == 3) {
            
            if (!blank[sender.tag]) {
                [self.answer3 setHidden:YES];
                blank[sender.tag] = YES;
                [self.empty setImage:self.answer3.imageView.image forState:UIControlStateNormal];
                blank[0] = NO;
                
            }
        }
        

     
        if (sender.tag == correct ) {
            
            [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(correctAnswer) userInfo:nil repeats:NO];
           
            
        }
        else
        {
            
            [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(wrongAnswer) userInfo:nil repeats:NO];
            
            
        }

        
        
    }
    
    
    
}

-(void)correctAnswer{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"恭喜"
                                                    message:@"你认识兔子了～"
                                                   delegate:nil
                                          cancelButtonTitle:@"next"
                                          otherButtonTitles:nil];
    
    
    [ alert  show];
    [self.empty addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];

    

}

-(void)wrongAnswer{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"sorry！"
                                                    message:@"是这样么？再想想！"
                                                   delegate:nil
                                          cancelButtonTitle:@"再看看"
                                          otherButtonTitles:nil];
    
    
    [ alert  show];
    
    [self.empty addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
