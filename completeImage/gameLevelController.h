//
//  gameLevelController.h
//  completeImage
//
//  Created by 张力 on 14-6-22.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "uncompleteImage.h"
#import "teachingView.h"
#import "sharePhotoViewController.h"
#import "globalVar.h"

static const int MAXlevel = 12;
static const int MAXanswer = 3;
static const int bigLevel = 6;
bool levelLock[bigLevel];


@interface gameLevelController : UIViewController
{
    int correct[MAXlevel];
}

@property (strong, nonatomic) UIImage *backgroundImg;
//@property (strong, nonatomic) NSString *backgroundNames;

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UIButton *answer1;
@property (weak, nonatomic) IBOutlet UIButton *answer2;
@property (weak, nonatomic) IBOutlet UIButton *answer3;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (strong,nonatomic) NSMutableArray *choices;
@property (strong, nonatomic) IBOutlet UIButton *empty;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (strong, nonatomic) teachingView *teachView;
@property (strong, nonatomic) UILabel *wrongLabel;
@property (strong,nonatomic) uncompleteImage *myImg;


- (IBAction)priorLevel;
- (IBAction)nextLevel;
- (IBAction)backToLevel;
- (IBAction)share;

@end
