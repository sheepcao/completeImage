//
//  gameLevelController.m
//  completeImage
//
//  Created by 张力 on 14-6-22.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "gameLevelController.h"

@interface gameLevelController ()

@end

@implementation gameLevelController

double posX[MAXlevel] = {216.6,113.1,107.4,118.5,90.6,/**/141.4,48.9,136,116,198.8,/**/200,200.7,141.4,136,133.1,/**/72.5,123.6,133.9,130.7,41.1/**/};
double posY[MAXlevel] = {277.1,284.3,282.5,195.1,340.1,/**/274.7,324.5
    ,229.5,227.6,232.7/**/,282,286.4,274.7,229.5,258.1,/**/238.6,227.3,214.6,283.8,259.1/**/};
double animationSpeed[MAXlevel] = {0.15,0.18,0.15,0.2,0.22,/**/0.19,0.22,0.2,0.22,0.17,/**/0.2,0.2,0.25,0.2,0.3,/**/0.25,0.35,0.3,0.25,0.3/**/};
double repeatTime[MAXlevel] = {3,1,3,1,1,/**/2,2,1,1,3,/**/1,1,1,1,1,/**/1,1,1,1,1/**/};
double largeEmpty[bigLevel] = {122.22,0,0,0,0,0};
bool haveFixed[MAXlevel] = {NO};
bool notJumpOver = NO;



NSArray *wordsCN;
NSArray *wordsEN;
NSArray *backgroundName;

NSMutableArray  *arrayM;
NSMutableArray  *arrayGif;




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (int i=0; i<levelTop-1; i++) {
        haveFixed[i]= YES;
    }
    NSLog(@"levelTop:%d,fixed:%d",levelTop,haveFixed[levelTop-1]);
    
    self.answer1 = [[UIButton alloc] initWithFrame:CGRectMake(33, 470, 55, 55)];
    self.answer1.tag = 1;
    self.answer2 = [[UIButton alloc] initWithFrame:CGRectMake(131, 470, 55, 55)];
    self.answer2.tag = 2;
    self.answer3 = [[UIButton alloc] initWithFrame:CGRectMake(228, 470, 55, 55)];
    self.answer3.tag = 3;

    [self.answer1 setBackgroundImage:[UIImage imageNamed:@"choiceBackground"] forState:UIControlStateNormal];
    [self.answer2 setBackgroundImage:[UIImage imageNamed:@"choiceBackground"] forState:UIControlStateNormal];
    [self.answer3 setBackgroundImage:[UIImage imageNamed:@"choiceBackground"] forState:UIControlStateNormal];
    [self.answer1 addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.answer2 addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.answer3 addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];


    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        
        self.picture = [[UIImageView alloc] initWithFrame: CGRectMake(33, 157, 250, 230)];
        self.animationBegin = [[UIButton alloc] initWithFrame:CGRectMake(33, 157, 250, 230)];
        posY[level-1] -=32;

        [self.answer1 setFrame:CGRectMake(33, 400, 55, 55)];
        [self.answer2 setFrame:CGRectMake(131, 400, 55, 55)];
        [self.answer3 setFrame:CGRectMake(228, 400, 55, 55)];
        
    }else
    {
        self.picture = [[UIImageView alloc] initWithFrame:CGRectMake(33, 190, 250, 230)];
        self.animationBegin = [[UIButton alloc] initWithFrame:CGRectMake(33, 190, 250, 230)];
        
    }
    [self.view addSubview:self.answer1];
    [self.view addSubview:self.answer2];
    [self.view addSubview:self.answer3];
    self.animationBegin.backgroundColor = [UIColor clearColor];
    self.picture.layer.borderWidth = 0;
    [self.view addSubview:self.picture];
    [self.view addSubview:self.animationBegin];
    [self.view bringSubviewToFront:self.animationBegin];
    [self.animationBegin addTarget:self action:@selector(animationTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.choices = [[NSMutableArray alloc] initWithObjects:self.answer1,self.answer2,self.answer3, nil];
    NSString *words1 = @"猪,猫,兔子,鸡,青蛙,蜜蜂,狗,鲨鱼,蜗牛,考拉,狗,柳树,蜜蜂,鲨鱼,奶嘴,厕所,钟表,蜡烛,向日葵,牵牛花";
    wordsCN = [words1 componentsSeparatedByString:@","];
    NSString *words2 = @"pig,cat,rabbit,chicken,frog,bee,dog,shark,snail,koala,dog,willow,bee,shark,pacifier,toilet,clock,candle,sunflower,glory";
    wordsEN = [words2 componentsSeparatedByString:@","];
   // NSString *backgroundNames = @"animalBackground,sportBackground,livingGoodBackground,plantBackground,foodBackground,moreBackground";
    NSString *backgroundNames = @"animalBackground";
    backgroundName = [backgroundNames componentsSeparatedByString:@","];

    self.empty = [[UIButton alloc] init];
    [self.empty setBackgroundColor:[UIColor clearColor]];
    self.empty.layer.borderWidth = 0;

//share change task.    [self.shareBtn setHidden:YES];

    self.questionMark = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
    self.questionMark.layer.borderWidth = 0;
    self.questionMark.alpha = 0.8;
    [self.empty addSubview:self.questionMark];
    
    arrayGif=[[NSMutableArray array] init];
    UIImage *gif = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QuestionMark" ofType:@"png"]];
    [arrayGif addObject:gif];
    
    [arrayGif addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"透明" ofType:@"png"]]];
    
     self.view.backgroundColor = [UIColor colorWithPatternImage:    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"animalBackground" ofType:@"png"]]];
    
    
  //set ad......iad and admob
    
    self.iAdBannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0.0,self.view.frame.size.height - GAD_SIZE_320x50.height,GAD_SIZE_320x50.width,GAD_SIZE_320x50.height)];
    
    [self.iAdBannerView setDelegate:self];
    self.iAdBannerView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.iAdBannerView];
    self.bannerIsVisible = YES;
    
    self.gAdBannerView = [[GADBannerView alloc]
                          initWithFrame:CGRectMake(0.0,self.view.frame.size.height - GAD_SIZE_320x50.height,GAD_SIZE_320x50.width,GAD_SIZE_320x50.height)];
    
    self.gAdBannerView.adUnitID = ADMOB_ID;//调用id
    
    self.gAdBannerView.delegate = self;
    self.gAdBannerView.rootViewController = self;
    self.gAdBannerView.backgroundColor = [UIColor clearColor];
    [self.gAdBannerView loadRequest:[GADRequest request]];
    

    
}

- (void)viewDidAppear:(BOOL)animated

{
    

    [self.animationBegin setHidden:YES];
    
    for (int i =0; i<3; i++) {
        [self setButton:(UIButton *)self.choices[i]];
    }
    
    
    self.myImg = [[uncompleteImage alloc] initWithEmptyX:posX[level-1] Y:posY[level-1]];
    [self setupWithEmptyPosition:self.myImg.positionX :self.myImg.positionY];

    
    self.teachView = [[teachingView alloc] initWithWordsAndSound:wordsCN[level-1] english:wordsEN[level-1] soundCN:wordsCN[level-1] soundEN:wordsEN[level-1]];
    
    if (!haveFixed[level-1]) {
        
        [self.nextButton setEnabled:NO];
        
    }else
    {
        [self.nextButton setEnabled:YES];
        /*当前关卡所在主题为解锁状态并且当前进度和最高进度不在同一个主题，说明当前关卡应支持分享。
        if (levelTop == MAXlevel+1) {
            
            [self.shareBtn setHidden:NO];
            
        }else if ((!levelLock[(level-1)/10]) && ((levelTop-1)/10!=(level-1)/10)) {
            [self.shareBtn setHidden:NO];
        }
         share change task.
         */
    }
    
    if (arrayGif.count>0) {
        //设置动画数组
        [self.questionMark setAnimationImages:arrayGif];
        //设置动画播放次数
        [self.questionMark setAnimationRepeatCount:100000];
        //设置动画播放时间
        [self.questionMark setAnimationDuration:2*1.0];
        //开始动画
        [self.questionMark startAnimating];
        
        
    }
    
   

}


-(void)setupWithEmptyPosition:(NSInteger )px :(NSInteger )py
{
    levelTop = levelTop<level?level:levelTop;
    [self.levelCount setText:[NSString stringWithFormat:@"%d",level]];
    self.levelCount.font = [UIFont fontWithName:@"SegoePrint" size:23];
    [self.levelCount setTextColor:[UIColor blackColor]];
    
    NSString *pic = [NSString stringWithFormat:@"pic%d",level];
    
    NSString *an1 = [NSString stringWithFormat:@"an1-%d",level];
    
    NSString *an2 = [NSString stringWithFormat:@"an2-%d",level];
    
    NSString *an3 = [NSString stringWithFormat:@"an3-%d",level];
    
    
    
    [self setImages:an1:an2 :an3 :pic];
    
    if (level%10 == 9) {
        [self.empty setFrame:CGRectMake(px, py, largeEmpty[(level-1)/10], largeEmpty[(level-1)/10])];
        
        [self.questionMark setFrame:CGRectMake(0, 0, largeEmpty[(level-1)/10], largeEmpty[(level-1)/10])];

    }else
    {
   
        [self.empty setFrame:CGRectMake(px, py, 55, 55)];
        
        [self.questionMark setFrame:CGRectMake(0, 0, 55, 55)];
    }
    [self setButton:self.empty];
    self.empty.layer.borderWidth = 0;
    
    self.empty.tag = 0;
    
    for (int i =0; i<3; i++) {
        [((UIButton *)self.choices[i]) setHidden:NO];
    }
    [self.view addSubview:self.empty];
    
    [self.teachView removeFromSuperview];
    [self.empty removeTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    
//share change task.    [self.shareBtn setHidden:YES];
    

    if (!haveFixed[level-1]) {
        
        [self.nextButton setEnabled:NO];
        
    }else
    {
        [self.nextButton setEnabled:YES];
  
        
    }
    
    [self.animationBegin setHidden:YES];//每关开始不可点击。

 
}

-(void)setImages:(NSString *)rightAns :(NSString *)wrong1 :(NSString *)wrong2 :(NSString *)guess
{
    unsigned int randomNumber = arc4random();
    
    int correctAns = randomNumber%MAXanswer;
    UIButton *rightBtn = self.choices[correctAns];
    
    [rightBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:rightAns ofType:@"png"]] forState:UIControlStateNormal];
    correct[level-1] = correctAns+1;
    
    [self.choices[(correctAns+1)%3] setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", wrong1] ofType:@"png"]]forState:UIControlStateNormal];
    [self.choices[(correctAns+2)%3] setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", wrong2] ofType:@"png"]]forState:UIControlStateNormal];
    
    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", wrong1] ofType:@"png"]];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", guess] ofType:@"png"];
    UIImage *myImage = [UIImage imageWithContentsOfFile:path];
    [self.picture setImage:myImage];

    [self.empty setImage:nil forState:UIControlStateNormal];
    [self.questionMark setHidden:NO];
    
    
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
            [self.questionMark setHidden:NO];
            
            for (int i = 0; i<3; i++) {
                if ([((UIButton *) self.choices[i]) isHidden]) {
                    [((UIButton *) self.choices[i]) setHidden:NO];
                }
            }
            [self.wrongLabel removeFromSuperview];
            
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
        [self.questionMark setHidden:YES];

        [self.empty setImage:((UIButton *) self.choices[sender.tag-1]).imageView.image forState:UIControlStateNormal];
        self.empty.layer.borderWidth = 0;
        
        
        if (sender.tag == correct[level-1] ) {
            
            
            
            [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(correctAnswer) userInfo:nil repeats:NO];
            
            
        }
        else
        {
            
            [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(wrongAnswer) userInfo:nil repeats:NO];
            
            
        }
        
    }
    
    
    
}

-(void)animationOver
{
    [self.animationBegin setHidden:NO];

    [self.empty setHidden:NO];
    if (!haveFixed[level-1]) {
        levelTop++;

        haveFixed[level-1] = YES;

    }
    [self.nextButton setEnabled:YES];
    [self.priorButton setEnabled:YES];

    NSLog(@"%d",haveFixed[level-1]);
    NSLog(@"%d",levelTop);
    
    [self.empty addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)sayEnglish
{
    AudioServicesPlaySystemSound([self.teachView.soundENObj intValue]);
    
    
}

-(void)correctAnswer{
    
    
    notJumpOver = YES;
    [self.nextButton setEnabled:NO];
    [self.priorButton setEnabled:NO];

    
    /* fit for 4-inch screen */
//    if ([[UIScreen mainScreen] bounds].size.height == 480) {
//        self.teachView.frame = CGRectMake(80, 60, 160, 100);
//        
//    }else
//    {
//        self.teachView.frame = CGRectMake(80, 70, 160, 120);
//
//    }
    
    [self.teachView.answerCN addTarget:self action:@selector(chineseTap) forControlEvents:UIControlEventTouchUpInside];
    [self.teachView.answerEN addTarget:self action:@selector(englishTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.teachView];
    
    AudioServicesPlaySystemSound([self.teachView.soundCNObj intValue]);
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(sayEnglish) userInfo:nil repeats:NO];
    
    [self.empty setHidden:YES];

    arrayM=[[NSMutableArray array] init];
    for (int i=1; i<15; i++) {

        UIImage *gif = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"level%d-%d",level,i] ofType:@"png"]];
        if (gif) {
            [arrayM insertObject:gif atIndex:i-1];
            
        }
        else if(i == 1)
        {
            [arrayM removeAllObjects];
            break;
        }
        else
        {
            for (int j=i-1; j<arrayM.count; j++) {
                [arrayM removeObjectAtIndex:j];
            }
            
//            if (arrayM.count>i-1) {
//                [arrayM removeObjectAtIndex:i-1];//make every level's animation with different image count.
//
//            }
        }
    }
    
    if (arrayM.count>0) {
        //设置动画数组
        [self.picture setAnimationImages:arrayM];
        //设置动画播放次数
        [self.picture setAnimationRepeatCount:repeatTime[level-1]];
        //设置动画播放时间
        [self.picture setAnimationDuration:5*animationSpeed[level-1]];
        //开始动画
        [self.picture startAnimating];
        
        
    }
    
    double timeInterval =(1.5*self.picture.animationDuration > 3.5)?(1.5*self.picture.animationDuration):3.5;
   
    [self performSelector:@selector(animationOver) withObject:nil afterDelay:timeInterval];
    
    
    
    
}


-(void)choiceBack
{
    //correct记录的是选项tag，1～3而非0～2.
    for (int i = 0; i<3; i++) {
        if ( [((UIButton *) self.choices[i]) isHidden ] && ((i+1) == correct[level-1]) ) {
            return;
        }else if( [((UIButton *) self.choices[i]) isHidden ])
            [((UIButton *) self.choices[i]) setHidden:NO];

    }
    
    if (self.empty.imageView.image) {
        [self.empty setImage:nil forState:UIControlStateNormal];
        [self.questionMark setHidden:NO];
/*
        for (int i = 0; i<3; i++) {
            if ( [((UIButton *) self.choices[i]) isHidden ] ) {
                [((UIButton *) self.choices[i]) setHidden:NO];

            }
        }
 */       
        [self.wrongLabel removeFromSuperview];
        
        [self.empty removeTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    
}

-(void)wrongAnswer{
    
    int scoreTemp = [[scores objectAtIndex:((level-1)/10)] intValue];
    
    [scores setObject:[NSNumber numberWithInt:(scoreTemp +1)] atIndexedSubscript:((level-1)/10)];
    
    
    if([self.teachView superview])
    {
        [self.teachView removeFromSuperview];
    }
    
    
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        
            self.wrongLabel = [[UIImageView alloc] initWithFrame:CGRectMake(80, 60, 160, 100)];
    }else
    {
        self.wrongLabel = [[UIImageView alloc] initWithFrame:CGRectMake(80, 70, 160, 120)];
    }

    [self.wrongLabel setImage:[UIImage imageNamed:@"board" ]];
    [self.wrongLabel setContentMode:UIViewContentModeScaleToFill];

    UIImageView *cryFace = [[UIImageView alloc] initWithFrame:CGRectMake(45, 15, 65, 65)];
    cryFace.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wrongImg" ofType:@"png"]];
    [self.wrongLabel addSubview:cryFace];
    [self.view addSubview:self.wrongLabel];
    
    //5秒后按钮自动退回
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(choiceBack) userInfo:nil repeats:NO];
    [self.empty addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
   //cancel the border..
    //self.empty.layer.borderWidth = 1.0f;
    
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
        [self.teachView setWordsAndSound:wordsCN[level-1] english:wordsEN[level-1] soundCN:wordsCN[level-1] soundEN:wordsEN[level-1]];
        
    }
}


- (IBAction)priorLevel {
    
    
    
    if (level>1) {
        level--;
        
        [self.myImg setEmptyX:posX[level-1] Y:posY[level-1]];
        [self setupWithEmptyPosition:self.myImg.positionX :self.myImg.positionY];
        [self.teachView setWordsAndSound:wordsCN[level-1] english:wordsEN[level-1] soundCN:wordsCN[level-1] soundEN:wordsEN[level-1]];
        
        
    }else if(level ==1)
    {
        return;
    }
}



- (IBAction)nextLevel {
    
    [arrayM removeAllObjects];
    if (!notJumpOver) {
        int scoreTemp = [[scores objectAtIndex:((level-1)/10)] intValue];
        
        [scores setObject:[NSNumber numberWithInt:(scoreTemp +2)] atIndexedSubscript:((level-1)/10)];
    }
    
    
    if (level%10==0
/*&& [haveShared[level/11] isEqualToString:@"0"]*/)
    {
//        [self performSelector:@selector(switchToReward) withObject:nil afterDelay:0.35f];
        rewardViewController *myReward = [[rewardViewController alloc] initWithNibName:@"rewardViewController" bundle:nil];
        myReward.frontImageName = @"animalShare";
        myReward.levelReward = [[NSNumber alloc] initWithInt:((level-1)/10)];
        myReward.afterShutter = NO;
        myReward.backImage.image = nil;

        
        myReward.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:myReward animated:YES completion:Nil ];

        
    }

    [self performSelector:@selector(changeImgs) withObject:nil afterDelay:0.35f];
    
    }
-(void)changeImgs
{
    
    if (haveFixed[level-1]) {
        
        if (level<MAXlevel) {
            level++;
            notJumpOver = NO;

            [self.myImg setEmptyX:posX[level-1] Y:posY[level-1]];
            [self setupWithEmptyPosition:self.myImg.positionX :self.myImg.positionY];
            [self.teachView setWordsAndSound:wordsCN[level-1] english:wordsEN[level-1] soundCN:wordsCN[level-1] soundEN:wordsEN[level-1]];
            
        }else if(level == MAXlevel )
        {
            
            return;
            
        }
    }

}

//-(void)switchToReward
//{
//    
//    rewardViewController *myReward = [[rewardViewController alloc] initWithNibName:@"rewardViewController" bundle:nil];
//    myReward.frontImageName = @"flowerPhoto";
//    
//    myReward.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self presentViewController:myReward animated:YES completion:Nil ];
//}

- (IBAction)backToLevel {
    
    [self dismissViewControllerAnimated:YES completion:Nil];
    
}

- (IBAction)share {
    
    
    sharePhotoViewController *myShare = [[sharePhotoViewController alloc] initWithNibName:@"sharePhotoViewController" bundle:nil];
    myShare.frontImageName = @"animalShare";
    myShare.afterShutter = NO;
    myShare.backImage.image = nil;
    
    myShare.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:myShare animated:YES completion:Nil ];

}

- (IBAction)animationTapped:(id)sender {
    [self.nextButton setEnabled:NO];
    [self.priorButton setEnabled:NO];
    [self.empty setHidden:YES];

    
    if (arrayM.count>0) {
              //开始动画
        [self.picture startAnimating];
    }
    
    [self performSelector:@selector(animationOnly) withObject:nil afterDelay:self.picture.animationDuration * repeatTime[level-1]];

}
-(void)animationOnly
{
    [self.nextButton setEnabled:YES];
    [self.priorButton setEnabled:YES];
    [self.empty setHidden:NO];
}

-(void)chineseTap
{
    AudioServicesPlaySystemSound([self.teachView.soundCNObj intValue]);

}

-(void)englishTap
{
    AudioServicesPlaySystemSound([self.teachView.soundENObj intValue]);

}
-(void)emptyDisappear
{
    [self.empty setHidden:YES];
    [self.questionMark setHidden:YES];
}
-(void)emptyAppear
{
    [self.empty setHidden:NO];
    [self.questionMark setHidden:NO];
}


#pragma mark - AdViewDelegates


- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    NSLog(@"Admob load");
    
}

// An error occured
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"Admob error: %@", error);
    [self.gAdBannerView removeFromSuperview];
}

-(void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"iad failed");
    [self.iAdBannerView removeFromSuperview];
    self.bannerIsVisible = NO;
    
    [self.view addSubview:self.gAdBannerView];
        
  
}


-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"iAd will load");
}
-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    NSLog(@"iAd did finish");
    
}


@end
