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

int level = 1;
int posX[MAXlevel] = {136,213,103,227,70};
int posY[MAXlevel] = {287,232,157,190,180};




- (void)viewDidLoad
{
    [super viewDidLoad];

    self.choices = [[NSMutableArray alloc] initWithObjects:self.answer1,self.answer2,self.answer3, nil];
    
    self.empty = [[UIButton alloc] init];
    for (int i =0; i<3; i++) {
        [self setButton:(UIButton *)self.choices[i]];
    }
    
    
    self.myImg = [[uncompleteImage alloc] initWithEmptyX:posX[level-1] Y:posY[level-1]];
    [self setupWithEmptyPosition:self.myImg.positionX :self.myImg.positionY];


}


-(void)setupWithEmptyPosition:(NSInteger )px :(NSInteger )py
{
    
    
    NSString *pic = [NSString stringWithFormat:@"pic%d",level];
    
    NSString *an1 = [NSString stringWithFormat:@"an1-%d",level];
    
    NSString *an2 = [NSString stringWithFormat:@"an2-%d",level];
    
    NSString *an3 = [NSString stringWithFormat:@"an3-%d",level];
    
    
    
    [self setImages:an1:an2 :an3 :pic];
    
    
    [self.empty setFrame:CGRectMake(px, py, 55, 55)];
    [self setButton:self.empty];

    self.empty.tag = 0;

    for (int i =0; i<3; i++) {
        [((UIButton *)self.choices[i]) setHidden:NO];
    }
    [self.view addSubview:self.empty];
    
    [self.empty removeTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setImages:(NSString *)rightAns :(NSString *)wrong1 :(NSString *)wrong2 :(NSString *)guess
{
    unsigned int randomNumber = arc4random();
    
    int correctAns = randomNumber%MAXanswer;
    UIButton *rightBtn = self.choices[correctAns];
    [rightBtn setImage:[UIImage imageNamed:rightAns] forState:UIControlStateNormal];
    correct[level-1] = correctAns+1;
    
    [self.choices[(correctAns+1)%3] setImage:[UIImage imageNamed:wrong1] forState:UIControlStateNormal];
    [self.choices[(correctAns+2)%3] setImage:[UIImage imageNamed:wrong2] forState:UIControlStateNormal];


    
    [self.picture setImage:[UIImage imageNamed:guess]];
    [self.empty setImage:nil forState:UIControlStateNormal];


}

-(void)setButton:(UIButton *)btn
{
    btn.layer.borderWidth = 1.0f;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)buttonTap:(UIButton *)sender
{

    
    if (sender.tag == 0) {
            if (self.empty.imageView.image) {
                [self.empty setImage:nil forState:UIControlStateNormal];
                
                for (int i = 0; i<3; i++) {
                    if ([((UIButton *) self.choices[i]) isHidden]) {
                        [((UIButton *) self.choices[i]) setHidden:NO];
                    }
                }
               
            }
        [self.empty removeTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];


    }else
    {
        
        for (int i=0; i<3; i++) {
            if ([((UIButton *)self.choices[i]) isHidden]) {
                return;
            }
        }
        
        [((UIButton *) self.choices[sender.tag-1]) setHidden:YES];
        [self.empty setImage:((UIButton *) self.choices[sender.tag-1]).imageView.image forState:UIControlStateNormal];
        self.empty.layer.borderWidth = 0;

     
        if (sender.tag == correct[level-1] ) {
            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(correctAnswer) userInfo:nil repeats:NO];
           
            
        }
        else
        {
            
            [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(wrongAnswer) userInfo:nil repeats:NO];
            
            
        }
        
    }
    
    
    
}

-(void)animationOver
{
    [self.empty setHidden:NO];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"恭喜"
                                                    message:@"你认识兔子了～"
                                                   delegate:self
                                          cancelButtonTitle:@"回头看看"
                                          otherButtonTitles:@"next",nil];
    
    
    [ alert  show];
    [self.empty addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)correctAnswer{
    
    NSMutableArray  *arrayM=[NSMutableArray array];
    for (int i=1; i<5; i++) {
        [arrayM addObject:[UIImage imageNamed:[NSString stringWithFormat:@"5p%d.png",i]]];
    }
    
    [self.empty setHidden:YES];

    //设置动画数组
    [self.picture setAnimationImages:arrayM];
    //设置动画播放次数
    [self.picture setAnimationRepeatCount:2];
    //设置动画播放时间
    [self.picture setAnimationDuration:4*0.15];
    //开始动画
    [self.picture startAnimating];
    
    [self performSelector:@selector(animationOver) withObject:nil afterDelay:2*self.picture.animationDuration];
    

}




-(void)wrongAnswer{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"sorry！"
                                                    message:@"是这样么？再想想！"
                                                   delegate:nil
                                          cancelButtonTitle:@"再看看"
                                          otherButtonTitles:nil];
    
    [ alert  show];
    [self.empty addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    self.empty.layer.borderWidth = 1.0f;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma alert delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 1) {
        if (level<MAXlevel) {
            level++;
        }
        [self.myImg setEmptyX:posX[level-1] Y:posY[level-1]];
        [self setupWithEmptyPosition:self.myImg.positionX :self.myImg.positionY];

    }
}


@end
