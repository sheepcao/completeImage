//
//  ViewController.m
//  completeImage
//
//  Created by 张力 on 14-6-4.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic ,strong)gameLevelController *game;
//@property (nonatomic ,strong) NSArray *levelLock;
@end

@implementation ViewController

bool levelLock[bigLevel] = {YES};


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    level =4;
    
    
    self.game = [[gameLevelController alloc] initWithNibName:@"gameLevelController" bundle:nil];
    UIImageView *homeBackground = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    
    homeBackground.image = [UIImage imageNamed:@"level"];
    
    for (int i = 0; i <(level/10)+1; i++) {
        levelLock[i] = NO;
    }
    
    for (int i=bigLevel; i>(level/10)+1; i--) {
        
     
        UIButton *levelEntrance = (UIButton *)[self.view viewWithTag:i];
        [levelEntrance setImage:[ UIImage imageNamed:@"suozi"] forState:UIControlStateNormal];
        ((UIButton *)[self.view viewWithTag:i]).imageView.alpha = 0.2;
    }

    
    [self.view addSubview:homeBackground];
    [self.view sendSubviewToBack:homeBackground];

}

- (IBAction)animalBtn:(id)sender {
    
    self.game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:self.game animated:YES completion:Nil ];
 
}

- (IBAction)takePhoto:(id)sender {
    
    
    sharePhotoViewController *myShare = [[sharePhotoViewController alloc] initWithNibName:@"sharePhotoViewController" bundle:nil];
    myShare.frontImageName = @"flowerPhoto";
    
    myShare.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:myShare animated:YES completion:Nil ];
    
    
       
}






/*
- (void) setup: (UIView *) aView
{
    //获取相机界面的view
     plcameraview = [aView subviewWithClass:NSClassFromString(@"PLCameraView")];
    if (!plcameraview) return;
    
    //相机原有控件全部透明
    NSArray *svarray = [plcameraview subviews];
    for (int i = 1; i < svarray.count; i++)  [[svarray objectAtIndex:i] setAlpha:0.0f];
    
    //加入自己的UI界面
#if 1
    self.navbar = [[[UINavigationBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)] autorelease];
    UINavigationItem *navItem = [[[UINavigationItem alloc] init] autorelease];
    navItem.rightBarButtonItem = BARBUTTON(@"Shoot", @selector(shoot:));
    navItem.leftBarButtonItem = BARBUTTON(@"Cancel", @selector(dismiss:));
    
    [(UINavigationBar *)self.navbar pushNavigationItem:navItem animated:NO];
    [plcameraview addSubview:self.navbar];
#endif
}

//启动相机
- (void) getStarted: (id) sender
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType =  UIImagePickerControllerSourceTypeCamera;
    [self presentModalViewController:ipc animated:YES];
    [self performSelector:@selector(setup:) withObject:ipc.view afterDelay:0.5f];
}
 */


@end
