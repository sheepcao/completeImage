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

//bool blank[4] = {YES,NO,NO,NO};

int level = 1;
int posX[MAXlevel] = {136,213,103};
int posY[MAXlevel] = {287,232,157};




- (void)viewDidLoad
{
    [super viewDidLoad];

    self.choices = [[NSMutableArray alloc] initWithObjects:self.answer1,self.answer2,self.answer3, nil];
   // self.UncpltImages = [[NSMutableArray alloc] initWithCapacity:MAXlevel];
    
    self.empty = [[UIButton alloc] init];
    for (int i =0; i<3; i++) {
        [self setButton:(UIButton *)self.choices[i]];
    }
    
    
    self.myImg = [[uncompleteImage alloc] initWithEmptyX:posX[level-1] Y:posY[level-1]];
    [self setupWithEmptyPosition:self.myImg.positionX :self.myImg.positionY];


}


/*
-(void)dataInit
{
    self.posX = [NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:136],[NSNumber numberWithInt:236], nil]
    posY = {287,187};
    
}

*/
-(void)setupWithEmptyPosition:(NSInteger )px :(NSInteger )py
{
    
    
    NSString *pic = [NSString stringWithFormat:@"pic%d",level];
    
    NSString *an1 = [NSString stringWithFormat:@"an1-%d",level];
    
    NSString *an2 = [NSString stringWithFormat:@"an2-%d",level];
    
    NSString *an3 = [NSString stringWithFormat:@"an3-%d",level];
    
    
    
    [self setImages:an1:an2 :an3 :pic];
    
    
	// Do any additional setup after loading the view, typically from a nib.
    
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


    
    
    /*
    [self.answer1 setImage:[UIImage imageNamed:rightAns] forState:UIControlStateNormal];
    [self.answer2 setImage:[UIImage imageNamed:wrong1] forState:UIControlStateNormal];
    [self.answer3 setImage:[UIImage imageNamed:wrong2] forState:UIControlStateNormal];
     */
    [self.picture setImage:[UIImage imageNamed:guess]];
    [self.empty setImage:nil forState:UIControlStateNormal];


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
                                                   delegate:self
                                          cancelButtonTitle:@"回头看看"
                                          otherButtonTitles:@"next",nil];
    
    
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
