//
//  teachingView.m
//  completeImage
//
//  Created by 张力 on 14-6-16.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "teachingView.h"

@implementation teachingView


SystemSoundID soundCN;
SystemSoundID soundEN;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(id)initWithWordsAndSound:(NSString *)chinese english:(NSString *)eng soundCN:(NSString *)sndCN soundEN:(NSString *)sndEN
{
    self = [super init];

    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"board" ]];

        self.answerCN = [[UIButton alloc] initWithFrame:CGRectMake(10, 13, 140, 45)];
        self.answerEN = [[UIButton alloc] initWithFrame:CGRectMake(10, 62, 140, 45)];
 /*//       self.answerCN .backgroundColor =[UIColor greenColor];
        [self.answerCN setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.answerEN setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       
        UIImageView *amplifierCN = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amplifier"] highlightedImage:[UIImage imageNamed:@"amplifier2"]];
        
        UIImageView *amplifierEN = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amplifier"] highlightedImage:[UIImage imageNamed:@"amplifier2"]];
        amplifierCN.frame = CGRectMake(105, 9, 25, 25);
        amplifierEN.frame = CGRectMake(105, 9, 25, 25);

        [self.answerCN addSubview:amplifierCN];
        [self.answerEN addSubview:amplifierEN];

        [self.answerCN setTitle:chinese forState:UIControlStateNormal];
        [self.answerEN setTitle:eng forState:UIControlStateNormal];
        self.answerCN.titleLabel.font = [UIFont fontWithName:@"SegoePrint" size:20];
        self.answerEN.titleLabel.font = [UIFont fontWithName:@"SegoePrint" size:20];
        [self bringSubviewToFront:self.answerCN];
 */
        [self.answerCN setImage:[UIImage imageNamed:chinese] forState:UIControlStateNormal];
        [self.answerEN setImage:[UIImage imageNamed:eng] forState:UIControlStateNormal];

        
        [self addSubview:self.answerEN];
        [self addSubview:self.answerCN];
        
        CFBundleRef CNbundle=CFBundleGetMainBundle();
        
        //获得声音文件URL
        CFURLRef soundfileurlCN=CFBundleCopyResourceURL(CNbundle,(__bridge CFStringRef)sndCN,CFSTR("wav"),NULL);
        //创建system sound 对象
        AudioServicesCreateSystemSoundID(soundfileurlCN, &soundCN);
        
        CFBundleRef ENbundle=CFBundleGetMainBundle();
        
        //获得声音文件URL
        CFURLRef soundfileurlEN=CFBundleCopyResourceURL(ENbundle,(__bridge CFStringRef)sndEN,CFSTR("wav"),NULL);
        //创建system sound 对象
        AudioServicesCreateSystemSoundID(soundfileurlEN, &soundEN);
        
        self.soundCNObj = [NSNumber numberWithInt:soundCN];
        self.soundENObj = [NSNumber numberWithInt:soundEN];
    }
    
    return self;

}


-(void)setWordsAndSound:(NSString *)chinese english:(NSString *)eng soundCN:(NSString *)sndCN soundEN:(NSString *)sndEN
{
//    [self.answerCN setTitle:chinese forState:UIControlStateNormal];
//    [self.answerEN setTitle:eng forState:UIControlStateNormal];
//    
    [self.answerCN setImage:[UIImage imageNamed:chinese] forState:UIControlStateNormal];
    [self.answerEN setImage:[UIImage imageNamed:eng] forState:UIControlStateNormal];
    
    CFBundleRef CNbundle=CFBundleGetMainBundle();
    
    //获得声音文件URL
    CFURLRef soundfileurlCN=CFBundleCopyResourceURL(CNbundle,(__bridge CFStringRef)sndCN,CFSTR("wav"),NULL);
    //创建system sound 对象
    AudioServicesCreateSystemSoundID(soundfileurlCN, &soundCN);
    
    CFBundleRef ENbundle=CFBundleGetMainBundle();
    
    //获得声音文件URL
    CFURLRef soundfileurlEN=CFBundleCopyResourceURL(ENbundle,(__bridge CFStringRef)sndEN,CFSTR("wav"),NULL);
    //创建system sound 对象
    AudioServicesCreateSystemSoundID(soundfileurlEN, &soundEN);
    
    self.soundCNObj = [NSNumber numberWithInt:soundCN];
    self.soundENObj = [NSNumber numberWithInt:soundEN];
}

@end
