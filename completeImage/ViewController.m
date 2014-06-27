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
@property (nonatomic ,strong) UIButton *lockedInAlert;
@end

@implementation ViewController

bool levelLock[bigLevel];


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    level =8;
    
    
    self.game = [[gameLevelController alloc] initWithNibName:@"gameLevelController" bundle:nil];
    UIImageView *homeBackground = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    
    homeBackground.image = [UIImage imageNamed:@"level"];
    
    for (int i = 0; i <bigLevel; i++) {
        levelLock[i] = NO;
    }
    


    
    [self.view addSubview:homeBackground];
    [self.view sendSubviewToBack:homeBackground];

}

- (void)viewDidAppear:(BOOL)animated
{
    for (int i=bigLevel-1; i>(level/10); i--) {
        
        
        levelLock[i] = YES;
        
        
        UIButton *levelEntrance = (UIButton *)[self.view viewWithTag:(i+1)];
        [levelEntrance setImage:[ UIImage imageNamed:@"suozi"] forState:UIControlStateNormal];
        [levelEntrance setImage:[[ UIImage alloc] init] forState:UIControlStateSelected];
        
        ((UIButton *)[self.view viewWithTag:i+1]).imageView.alpha = 0.2;
        
        
    }
}


- (IBAction)animalBtn:(UIButton *)sender {
    
    if (levelLock[sender.tag-1]) {

        [self setupAlert];
        
        
    }else{
        
        self.game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:self.game animated:YES completion:Nil ];
    }
 
}

-(void)setupAlert
{
    
    UIView *tmpCustomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , 300, 211)];
    
    UIImageView *imageInTag = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 211)];
    imageInTag.image = [UIImage imageNamed:@"tagAlert.png"];

    [tmpCustomView addSubview:imageInTag];
    [tmpCustomView sendSubviewToBack:imageInTag];
    
    self.lockedInAlert = [[UIButton alloc] initWithFrame:CGRectMake(100, 140, 100, 40)];
    [self.lockedInAlert setTitle:@"前往当前进度" forState:UIControlStateNormal];
    self.lockedInAlert.titleLabel.font = [UIFont systemFontOfSize:14.0];
    self.lockedInAlert.titleLabel.textColor = [UIColor redColor];


    self.lockedInAlert.backgroundColor = [UIColor greenColor];
    [self.lockedInAlert addTarget:self action:@selector(goToLevelNow) forControlEvents:UIControlEventTouchUpInside];
    [tmpCustomView addSubview:self.lockedInAlert];
    
    CustomIOS7AlertView *alert = [[CustomIOS7AlertView alloc] init];
    [alert setButtonTitles:[NSMutableArray arrayWithObjects:nil]];
    
    [alert setContainerView:tmpCustomView];
    
    self.lockedAlert = alert;
    [alert show];
    


}

-(void)goToLevelNow
{
    
    [self.lockedAlert close];
    
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
