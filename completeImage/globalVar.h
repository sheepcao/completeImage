//
//  globalVar.h
//  completeImage
//
//  Created by 张力 on 14-6-25.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#ifndef completeImage_globalVar_h
#define completeImage_globalVar_h

#define IPhoneHeight (([UIScreen mainScreen].bounds.size.height == 568.0)?568:480)
#define bigLevel 6


int level ;
NSNumber *levelSaved;
int levelTop;
NSMutableArray *haveShared;
NSMutableArray *scores;
NSString *haveSharedString;

#endif
