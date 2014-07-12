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

double posX[MAXlevel] = {136,213,103,227,70,220,200,88,135.5,107.2,200,200.7,141.4,136,133.1,72.5,123.6,133.9};
double posY[MAXlevel] = {287,232,157,190,180,300,282,206,240.2,282.3,282,286.4,274.7,229.5,258.1,238.6,227.3,214.6};
double animationSpeed[MAXlevel] = {0,0,0,0.5,0.15,0,0.15,0,0.26,0.35,0.2,0.2,0.25,0.2,0.3,0.25,0.35,0.3};
bool haveFixed[MAXlevel] = {NO};

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

    self.picture.layer.borderWidth = 0;
    
    self.choices = [[NSMutableArray alloc] initWithObjects:self.answer1,self.answer2,self.answer3, nil];
    NSString *words1 = @"兔子,猫,鳄鱼,猪,羽毛球,橘子,狗,鸡,荷花,兔子,狗,柳树,蜜蜂,鲨鱼,奶嘴,厕所,钟表,蜡烛";
    wordsCN = [words1 componentsSeparatedByString:@","];
    NSString *words2 = @"rabbit,cat,aligator,pig,badminton,orange,dog,chicken,lotus,rabbit,dog,willow,bee,shark,pacifier,toilet,clock,candle";
    wordsEN = [words2 componentsSeparatedByString:@","];
   // NSString *backgroundNames = @"animalBackground,sportBackground,livingGoodBackground,plantBackground,foodBackground,moreBackground";
    NSString *backgroundNames = @"animalBackground";
    backgroundName = [backgroundNames componentsSeparatedByString:@","];

    self.empty = [[UIButton alloc] init];
    [self.empty setBackgroundColor:[UIColor clearColor]];
    [self.shareBtn setHidden:YES];

    self.questionMark = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
    // [self.questionMark setImage:[UIImage imageNamed:@"Q1"]];
    [self.empty addSubview:self.questionMark];
    
    arrayGif=[[NSMutableArray array] init];
    for (int i=1; i<5; i++) {
        UIImage *gif = [UIImage imageNamed:[NSString stringWithFormat:@"Q%d.png",i]];
        if (gif) {
            [arrayGif insertObject:gif atIndex:i-1];
            
        }
        else
        {
            [arrayGif insertObject:[UIImage imageNamed:[NSString stringWithFormat:@"Q1.png"]] atIndex:0];
        }
    }

    /*  使用webview播放gif，背景只能是白色。
    self.emptyGif = @"questionMark.gif";
    NSArray *gifArray = [ self.emptyGif componentsSeparatedByString:@"."];
    
    // 读取gif图片数据
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:[gifArray objectAtIndex:0] ofType:[gifArray objectAtIndex:1]]];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.userInteractionEnabled = NO;//用户不可交互
    [self.webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.empty addSubview:self.webView];
    [self.webView setHidden:YES];
    */
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"animalBackground"]];
    
}

- (void)viewDidAppear:(BOOL)animated

{
    
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
        //当前关卡所在主题为解锁状态并且当前进度和最高进度不在同一个主题，说明当前关卡应支持分享。
        if (levelTop == MAXlevel+1) {
            
            [self.shareBtn setHidden:NO];
            
        }else if ((!levelLock[(level-1)/10]) && ((levelTop-1)/10!=(level-1)/10)) {
            [self.shareBtn setHidden:NO];
        }
    }
    
    if (arrayGif.count>0) {
        //设置动画数组
        [self.questionMark setAnimationImages:arrayGif];
        //设置动画播放次数
        [self.questionMark setAnimationRepeatCount:10000];
        //设置动画播放时间
        [self.questionMark setAnimationDuration:0.8];
        //开始动画
        [self.questionMark startAnimating];
        
        
    }
    
   

}


-(void)setupWithEmptyPosition:(NSInteger )px :(NSInteger )py
{
    levelTop = levelTop<level?level:levelTop;
   // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:backgroundName[(level-1)/10] ]];
    [self.levelCount setText:[NSString stringWithFormat:@"%d",level]];
    self.levelCount.font = [UIFont fontWithName:@"FYTNT-" size:23];
    [self.levelCount setTextColor:[UIColor whiteColor]];
    
    NSString *pic = [NSString stringWithFormat:@"pic%d",level];
    
    NSString *an1 = [NSString stringWithFormat:@"an1-%d",level];
    
    NSString *an2 = [NSString stringWithFormat:@"an2-%d",level];
    
    NSString *an3 = [NSString stringWithFormat:@"an3-%d",level];
    
    
    
    [self setImages:an1:an2 :an3 :pic];
    
    
    [self.empty setFrame:CGRectMake(px, py, 55, 55)];
    [self setButton:self.empty];
    
    self.empty.tag = 0;
    
    for (int i =0; i<3; i++) {
        [((UIButton *)self.choices[i]) setHidden:NO];
    }
    [self.view addSubview:self.empty];
    
    [self.teachView removeFromSuperview];
    [self.empty removeTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.shareBtn setHidden:YES];
    

    if (!haveFixed[level-1]) {
        
        [self.nextButton setEnabled:NO];
        
    }else
    {
        [self.nextButton setEnabled:YES];
        //当前关卡所在主题为解锁状态并且当前进度和最高进度不在同一个主题，说明当前关卡应支持分享。
        if (levelTop == MAXlevel+1) {
            
            [self.shareBtn setHidden:NO];
            
        }else if ((!levelLock[(level-1)/10]) && ((levelTop-1)/10!=(level-1)/10)) {
            [self.shareBtn setHidden:NO];
        }
        
    }
 
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
    
    
    
    [self.picture setImage:[UIImage imageNamed:guess]];
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
            
            
            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(correctAnswer) userInfo:nil repeats:NO];
            
            
        }
        else
        {
            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(wrongAnswer) userInfo:nil repeats:NO];
            
            
        }
        
    }
    
    
    
}

-(void)animationOver
{
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
    
    
    [self.nextButton setEnabled:NO];
    [self.priorButton setEnabled:NO];
    
    self.teachView.frame = CGRectMake(80, 70, 160, 120);
    [self.teachView.answerCN addTarget:self action:@selector(chineseTap) forControlEvents:UIControlEventTouchUpInside];
    [self.teachView.answerEN addTarget:self action:@selector(englishTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.teachView];
    
    AudioServicesPlaySystemSound([self.teachView.soundCNObj intValue]);
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(sayEnglish) userInfo:nil repeats:NO];
    
    [self.empty setHidden:YES];

    arrayM=[[NSMutableArray array] init];
    for (int i=1; i<6; i++) {
        UIImage *gif = [UIImage imageNamed:[NSString stringWithFormat:@"level%d-%d.png",level,i]];
        if (gif) {
            [arrayM insertObject:gif atIndex:i-1];
            
        }
        else if(i == 1)
        {
            [arrayM removeAllObjects];
        }
    }
    
    if (arrayM.count>0) {
        //设置动画数组
        [self.picture setAnimationImages:arrayM];
        //设置动画播放次数
        [self.picture setAnimationRepeatCount:1];
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
    /*
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"sorry！"
     message:@"是这样么？再想想！"
     delegate:nil
     cancelButtonTitle:@"再看看"
     otherButtonTitles:nil];
     
     [ alert  show];
     */
    if([self.teachView superview])
    {
        [self.teachView removeFromSuperview];
    }
    
    self.wrongLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 70, 160, 120)];
  //  [self.wrongLabel setText:@"错误"];
    self.wrongLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"board" ]];
    self.wrongLabel.textAlignment = NSTextAlignmentCenter;
    UIImageView *cryFace = [[UIImageView alloc] initWithFrame:CGRectMake(45, 25, 70, 70)];
    cryFace.image = [UIImage imageNamed:@"wrongImg"];
    [self.wrongLabel addSubview:cryFace];
    [self.view addSubview:self.wrongLabel];
    
    //5秒后按钮自动退回
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(choiceBack) userInfo:nil repeats:NO];
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
    
    if (level%10==0 && [haveShared[level/11] isEqualToString:@"0"])
    {
        
        sharePhotoViewController *myShare = [[sharePhotoViewController alloc] initWithNibName:@"sharePhotoViewController" bundle:nil];
        myShare.frontImageName = @"flowerPhoto";
        
        myShare.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:myShare animated:YES completion:Nil ];
        
    }

    
    if (haveFixed[level-1]) {
        
        if (level<MAXlevel) {
            level++;
            
            [self.myImg setEmptyX:posX[level-1] Y:posY[level-1]];
            [self setupWithEmptyPosition:self.myImg.positionX :self.myImg.positionY];
            [self.teachView setWordsAndSound:wordsCN[level-1] english:wordsEN[level-1] soundCN:wordsCN[level-1] soundEN:wordsEN[level-1]];
            
        }else if(level == MAXlevel )
        {
            
            return;
            
        }
    }
}

- (IBAction)backToLevel {
    
    [self dismissViewControllerAnimated:YES completion:Nil];
    
}

- (IBAction)share {
    
    
    sharePhotoViewController *myShare = [[sharePhotoViewController alloc] initWithNibName:@"sharePhotoViewController" bundle:nil];
    myShare.frontImageName = @"flowerPhoto";
    
    myShare.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:myShare animated:YES completion:Nil ];

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

@end
