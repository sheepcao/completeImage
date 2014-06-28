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
        self.backgroundColor = [UIColor lightGrayColor];
        self.answerCN = [[UIButton alloc] initWithFrame:CGRectMake(50, 4, 100, 42)];
        self.answerEN = [[UIButton alloc] initWithFrame:CGRectMake(50, 54, 100, 42)];
        [self.answerCN setTitle:chinese forState:UIControlStateNormal];
        [self.answerEN setTitle:eng forState:UIControlStateNormal];
        
        
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
    [self.answerCN setTitle:chinese forState:UIControlStateNormal];
    [self.answerEN setTitle:eng forState:UIControlStateNormal];
    
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
