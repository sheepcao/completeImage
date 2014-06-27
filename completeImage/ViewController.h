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



const int bigLevel = 5;

@interface ViewController : UIViewController

@property (strong, nonatomic) CustomIOS7AlertView *lockedAlert;
- (IBAction)animalBtn:(UIButton *)sender;
- (IBAction)takePhoto:(id)sender;


@end
