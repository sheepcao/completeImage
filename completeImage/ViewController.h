//
//  ViewController.h
//  completeImage
//
//  Created by 张力 on 14-6-4.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "uncompleteImage.h"
#import "teachingView.h"

const int MAXlevel = 6;
const int MAXanswer = 3;


@interface ViewController : UIViewController
{
    int correct[MAXlevel];
}
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UIButton *answer1;
@property (weak, nonatomic) IBOutlet UIButton *answer2;
@property (weak, nonatomic) IBOutlet UIButton *answer3;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (strong,nonatomic) NSMutableArray *choices;
@property (strong, nonatomic) IBOutlet UIButton *empty;
@property (strong, nonatomic) teachingView *teachView;
@property (strong, nonatomic) UILabel *wrongLabel;
@property (strong,nonatomic) uncompleteImage *myImg;

- (IBAction)priorLevel;

- (IBAction)nextLevel;
@end
