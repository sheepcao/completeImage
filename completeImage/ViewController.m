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
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    levelTop = [[ud objectForKey:@"saveLevel"] intValue];
    level = levelTop;
    
    if([ud objectForKey:@"saveShareState"]){
        haveShared = [NSMutableArray arrayWithArray:[[ud objectForKey:@"saveShareState"] componentsSeparatedByString:@","]];
    }else
    {
        haveShared = [[NSMutableArray alloc] init];
        for (int i = 0; i<bigLevel; i++) {
            haveShared[i] = @"0";

        }
        NSLog(@"%@",haveShared);

    }

    
    if (level<1 ||level>50) {
        level =1;
    }
    
    NSLog(@"%@",haveShared);


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
    if ( levelTop < level) {
        levelTop = level;
    }

    
    for (int i=bigLevel-1; i>0; i--) {
        UIButton *levelEntrance = (UIButton *)[self.view viewWithTag:(i+1)];
        UIImageView *lockImg = [[UIImageView alloc] initWithFrame:CGRectMake(levelEntrance.frame.size.width-19, levelEntrance.frame.size.height-15, 17, 17)];
        
        if (i>(levelTop-1)/10) {
            
            levelLock[i] = YES;
            [lockImg setImage:[UIImage imageNamed:@"suozi"]];
            [levelEntrance addSubview:lockImg];
            [levelEntrance bringSubviewToFront:lockImg];
        }else
        {
            levelLock[i] = NO;
            
            [lockImg setImage:nil];
            
        }
       
   
        
    }
    
}


- (IBAction)animalBtn:(UIButton *)sender {
    
    level = 1;
    
    if (levelLock[sender.tag-1]) {

        [self setupAlert];
        
        
    }else{
        
        self.game.backgroundImg = [UIImage imageNamed:@"植物背景6"];

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
    if (levelTop>MAXlevel) {
        level = MAXlevel;
    }else{
        level = levelTop;

    }
    


    [self.lockedAlert close];
    
    self.game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:self.game animated:YES completion:Nil ];
    
}
/*
 
- (IBAction)takePhoto:(id)sender {
    
    
    sharePhotoViewController *myShare = [[sharePhotoViewController alloc] initWithNibName:@"sharePhotoViewController" bundle:nil];
    myShare.frontImageName = @"flowerPhoto";
    
    myShare.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:myShare animated:YES completion:Nil ];
    
    
       
}
 */

- (IBAction)sportBtn:(UIButton *)sender {
    
    
    
    if (levelLock[sender.tag-1]) {
        
        [self setupAlert];
        
        
    }else{
        level = 11;
        self.game.backgroundImg = [UIImage imageNamed:@"animalBackground"];
        self.game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:self.game animated:YES completion:Nil ];
    }
    

}

- (IBAction)livingGoodBtn:(UIButton *)sender {
    
    
    
    if (levelLock[sender.tag-1]) {
        
        [self setupAlert];
        
        
    }else{
        level = 21;
        self.game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:self.game animated:YES completion:Nil ];
    }
    

}

- (IBAction)plantBtn:(UIButton *)sender {
    
   
    
    if (levelLock[sender.tag-1]) {
        
        [self setupAlert];
        
        
    }else{
         level = 31;
        self.game.backgroundImg = [UIImage imageNamed:@"plantBackground"];
        self.game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:self.game animated:YES completion:Nil ];
    }
    

}



- (IBAction)foodBtn:(UIButton *)sender {
    
    
    
    if (levelLock[sender.tag-1]) {
        
        [self setupAlert];
        
        
    }else{
        level = 41;
        self.game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:self.game animated:YES completion:Nil ];
    }
    

}

- (IBAction)moreBtn:(UIButton *)sender {
    
    
    
    if (levelLock[sender.tag-1]) {
        
        [self setupAlert];
        
        
    }else{
        level = 51;
        self.game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:self.game animated:YES completion:Nil ];
    }
    

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
