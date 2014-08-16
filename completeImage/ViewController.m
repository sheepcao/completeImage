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
@property (nonatomic ,strong) UIButton *cancelInAlert;

@property (nonatomic ,strong) NSMutableArray *lockImg;
@end

@implementation ViewController

bool levelLock[bigLevel];


- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        [self.view setFrame:CGRectMake(0, 0, 320, 480)];
        self.animal = [[UIButton alloc] initWithFrame:CGRectMake(66+17, 92.5-40, 87, 123)];
        self.plant = [[UIButton alloc] initWithFrame:CGRectMake(146+17, 167.5-40, 95, 121)];
        self.food = [[UIButton alloc] initWithFrame:CGRectMake(57+17, 245-40, 94, 122)];
        self.sport = [[UIButton alloc] initWithFrame:CGRectMake(176+17,293-40, 95, 122)];
        self.livingGood = [[UIButton alloc] initWithFrame:CGRectMake(79+17, 369-40, 93, 124)];
        self.moreFun = [[UIButton alloc] initWithFrame:CGRectMake(216+17, 47-40, 76, 84)];
        self.aboutUs = [[UIButton alloc] initWithFrame:CGRectMake(208+26, 418-32, 75, 88)];
        self.shareApp = [[UIButton alloc] initWithFrame:CGRectMake(25-16, 13, 72, 83)];
        
    }else
    {
        [self.view setFrame:CGRectMake(0, 0, 320, 568)];
        self.animal = [[UIButton alloc] initWithFrame:CGRectMake(66, 92.5, 87, 123)];
        self.plant = [[UIButton alloc] initWithFrame:CGRectMake(146, 167.5, 95, 121)];
        self.food = [[UIButton alloc] initWithFrame:CGRectMake(57, 245, 94, 122)];
        self.sport = [[UIButton alloc] initWithFrame:CGRectMake(176,293, 95, 122)];
        self.livingGood = [[UIButton alloc] initWithFrame:CGRectMake(79, 369, 93, 124)];
        self.moreFun = [[UIButton alloc] initWithFrame:CGRectMake(216, 47, 76, 84)];
        self.aboutUs = [[UIButton alloc] initWithFrame:CGRectMake(208, 418, 75, 88)];
        self.shareApp = [[UIButton alloc] initWithFrame:CGRectMake(25, 13, 72, 83)];

    }
    self.animal.tag = 1;
    self.plant.tag = 2;
    self.food.tag = 3;
    self.sport.tag = 4;
    self.livingGood.tag = 5;
    
    [self.animal setImage:[UIImage imageNamed:@"b4"] forState:UIControlStateNormal];
    [self.plant setImage:[UIImage imageNamed:@"b7"] forState:UIControlStateNormal];
    [self.food setImage:[UIImage imageNamed:@"b5"] forState:UIControlStateNormal];
    [self.sport setImage:[UIImage imageNamed:@"b6"] forState:UIControlStateNormal];
    [self.livingGood setImage:[UIImage imageNamed:@"b8"] forState:UIControlStateNormal];
    [self.moreFun setImage:[UIImage imageNamed:@"b2"] forState:UIControlStateNormal];
    [self.aboutUs setImage:[UIImage imageNamed:@"b3"] forState:UIControlStateNormal];
    [self.shareApp setImage:[UIImage imageNamed:@"b1"] forState:UIControlStateNormal];
    
    [self.animal addTarget:self action:@selector(animalBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.plant addTarget:self action:@selector(plantBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.food addTarget:self action:@selector(foodBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.sport addTarget:self action:@selector(sportBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.livingGood addTarget:self action:@selector(livingGoodBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.shareApp addTarget:self action:@selector(shareFunc) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: self.animal];
    [self.view addSubview: self.plant];

    [self.view addSubview: self.food];

    [self.view addSubview: self.sport];

    [self.view addSubview: self.livingGood];

    [self.view addSubview: self.moreFun];

    [self.view addSubview: self.aboutUs];

    [self.view addSubview: self.shareApp];



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
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        homeBackground.image = [UIImage imageNamed:@"level480"];

        
    }else
    {
        homeBackground.image = [UIImage imageNamed:@"level"];
        
    }
    

    self.lockImg = [[NSMutableArray alloc] init];
    for (int i = 0; i <5; i++) {
        levelLock[i] = NO;
        UIButton *levelEntrance = (UIButton *)[self.view viewWithTag:(i+1)];
        UIImageView *lockImage =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"suozi" ]];
        [lockImage setFrame:CGRectMake(levelEntrance.frame.size.width/2-17, levelEntrance.frame.size.height-53, 28, 28)];
        [self.lockImg insertObject:lockImage atIndex:i];
    }

    
    [self.view addSubview:homeBackground];
    [self.view sendSubviewToBack:homeBackground];

}

- (void)viewDidAppear:(BOOL)animated
{
//    if ([[UIScreen mainScreen] bounds].size.height == 480) {
//        
//        // redraw every button.
//        
//        for (int i = 1; i<7; i++) {
//            
//            UIButton *animal = (UIButton *)[self.view viewWithTag:i];
//            CGRect frame = animal.frame;
//            frame.origin.y-=40;
//            frame.origin.x+=17;
//            [animal setFrame:frame];
//            
//        }
//        
//        
//        UIButton *animal = (UIButton *)[self.view viewWithTag:7];
//        CGRect frame = animal.frame;
//        frame.origin.y-=32;
//        frame.origin.x+=26;
//        [animal setFrame:frame];
//        
//        UIButton *shareApp = (UIButton *)[self.view viewWithTag:8];
//        CGRect frame1 = shareApp.frame;
////        frame1.origin.y=;
//        frame1.origin.x-=16;
//        [shareApp setFrame:frame1];
//        
//        
//
//
//        
//    }
    
    
    if ( levelTop < level) {
        levelTop = level;
    }

    
    for (int i=(bigLevel-1); i>0; i--) {

        UIButton *levelEntrance = (UIButton *)[self.view viewWithTag:(i+1)];

        
        if (i>(levelTop-1)/10) {
            
            levelLock[i] = YES;

            [levelEntrance addSubview:self.lockImg[i]];
            [levelEntrance bringSubviewToFront:self.lockImg[i]];
        }else
        {
            levelLock[i] = NO;
            
            [self.lockImg[i] removeFromSuperview];
            
        }
       
   
        
    }
    
}



- (IBAction)animalBtn:(UIButton *)sender {

    
    
    level = 1;
    [scores setObject:[NSNumber numberWithInt:0] atIndexedSubscript:(level-1)/10];
    
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
    
    UIImageView *imageInTag = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300 , 211)];
    imageInTag.image = [UIImage imageNamed:@"tagAlert.png"];

    [tmpCustomView addSubview:imageInTag];
    [tmpCustomView sendSubviewToBack:imageInTag];
    tmpCustomView.backgroundColor = [UIColor whiteColor];
    
    
    self.lockedInAlert = [[UIButton alloc] initWithFrame:CGRectMake(40, 125, 90, 47)];
    [self.lockedInAlert setImage:[UIImage imageNamed:@"okButton"] forState:UIControlStateNormal];
    self.cancelInAlert = [[UIButton alloc] initWithFrame:CGRectMake(170, 125, 90, 47)];
    [self.cancelInAlert setImage:[UIImage imageNamed:@"cancelButton"] forState:UIControlStateNormal];
    
//    [self.lockedInAlert setTitle:@"前往当前进度" forState:UIControlStateNormal];
//    self.lockedInAlert.titleLabel.font = [UIFont systemFontOfSize:14.0];
//    self.lockedInAlert.titleLabel.textColor = [UIColor redColor];


//    self.lockedInAlert.backgroundColor = [UIColor greenColor];
    [self.lockedInAlert addTarget:self action:@selector(goToLevelNow) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelInAlert addTarget:self action:@selector(closeAlert) forControlEvents:UIControlEventTouchUpInside];

    [tmpCustomView addSubview:self.lockedInAlert];
    [tmpCustomView addSubview:self.cancelInAlert];
    
    CustomIOS7AlertView *alert = [[CustomIOS7AlertView alloc] init];
    [alert setButtonTitles:[NSMutableArray arrayWithObjects:nil]];
    alert.backgroundColor = [UIColor whiteColor];
    
    [alert setContainerView:tmpCustomView];
    
    self.lockedAlert = alert;
    [alert show];
    


}

-(void)closeAlert
{
    [self.lockedAlert close];
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

- (IBAction)sportBtn:(UIButton *)sender {
    
    
    
    if (levelLock[sender.tag-1]) {
        
        [self setupAlert];
        
        
    }else{
        level = 31;
        [scores setObject:[NSNumber numberWithInt:0] atIndexedSubscript:(level-1)/10];

        self.game.backgroundImg = [UIImage imageNamed:@"animalBackground"];
        self.game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:self.game animated:YES completion:Nil ];
    }
    

}

- (IBAction)livingGoodBtn:(UIButton *)sender {
    
    
    
    if (levelLock[sender.tag-1]) {
        
        [self setupAlert];
        
        
    }else{
        level = 41;
        [scores setObject:[NSNumber numberWithInt:0] atIndexedSubscript:(level-1)/10];

        self.game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:self.game animated:YES completion:Nil ];
    }
    

}

- (IBAction)plantBtn:(UIButton *)sender {
    
   
    
    if (levelLock[sender.tag-1]) {
        
        [self setupAlert];
        
        
    }else{
         level = 11;
        [scores setObject:[NSNumber numberWithInt:0] atIndexedSubscript:(level-1)/10];

        self.game.backgroundImg = [UIImage imageNamed:@"plantBackground"];
        self.game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:self.game animated:YES completion:Nil ];
    }
    

}



- (IBAction)foodBtn:(UIButton *)sender {
    
    
    
    if (levelLock[sender.tag-1]) {
        
        [self setupAlert];
        
        
    }else{
        level = 21;
        [scores setObject:[NSNumber numberWithInt:0] atIndexedSubscript:(level-1)/10];

        self.game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:self.game animated:YES completion:Nil ];
    }
    

}

- (IBAction)moreBtn:(UIButton *)sender {
    
    
    
    if (levelLock[sender.tag-1]) {
        
        [self setupAlert];
        
        
    }else{
        level = 51;
        [scores setObject:[NSNumber numberWithInt:0] atIndexedSubscript:(level-1)/10];

        self.game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:self.game animated:YES completion:Nil ];
    }
    

}



-(void)shareFunc
{
    UIImage *imageShare = [UIImage imageNamed:@"AppIcon"];
        //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"Smart Baby\n下载地址：http://itunes.apple.com/cn/app/daysinline/id844914780?mt=8"
                                       defaultContent:@"下载地址：http://itunes.apple.com/cn/app/daysinline/id844914780?mt=8"
                                                image:[ShareSDK pngImageWithImage:imageShare]
                                                title:@"宝宝猜猜猜"
                                                  url:@"http://itunes.apple.com/cn/app/daysinline/id844914780?mt=8"
                                          description:@"下载地址：http://itunes.apple.com/cn/app/daysinline/id844914780?mt=8"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}


@end
