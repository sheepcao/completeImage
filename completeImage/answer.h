//
//  answer.h
//  completeImage
//
//  Created by 张力 on 14-6-4.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface answer : NSObject

@property (nonatomic , strong) NSArray *choices;

-(id)initAnswers:(NSString *)first :(NSString *)second :(NSString *)third;

@end
