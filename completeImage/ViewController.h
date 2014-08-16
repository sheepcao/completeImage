//
//  ViewController.h
//  completeImage
//
//  Created by 张力 on 14-6-4.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gameLevelController.h"
#import "sharePhotoViewController.h"
#import "CustomIOS7AlertView.h"





@interface ViewController : UIViewController

@property (strong, nonatomic) CustomIOS7AlertView *lockedAlert;

@property (strong, nonatomic) UIButton *animal;
@property (strong, nonatomic) UIButton *plant;
@property (strong, nonatomic) UIButton *food ;
@property (strong, nonatomic) UIButton *sport;
@property (strong, nonatomic) UIButton *livingGood;
@property (strong, nonatomic) UIButton *moreFun;
@property (strong, nonatomic) UIButton *aboutUs;
@property (strong, nonatomic) UIButton *shareApp;



- (IBAction)animalBtn:(UIButton *)sender;
- (IBAction)sportBtn:(UIButton *)sender;
- (IBAction)livingGoodBtn:(UIButton *)sender;
- (IBAction)plantBtn:(UIButton *)sender;
- (IBAction)foodBtn:(UIButton *)sender;


@end
