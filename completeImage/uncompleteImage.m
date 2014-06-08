//
//  uncompleteImage.m
//  completeImage
//
//  Created by 张力 on 14-6-4.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "uncompleteImage.h"

@implementation uncompleteImage


const int EMPTY_AREA_EDGE = 55;

-(id)initWithEmpty:(NSString *)fullImage :(NSNumber *)pos_x :(NSNumber *)pos_y
{
    
    
    self = [super init];
    if (self) {
        // Initialization code
        
        positionX = [pos_x floatValue];
        positionY = [pos_y floatValue];
        [self.uncompleteIMG setImage:[UIImage imageNamed:fullImage]];
        self.emptyIMG = [[UIButton alloc] initWithFrame:CGRectMake(positionX, positionY, EMPTY_AREA_EDGE, EMPTY_AREA_EDGE)];
    

    }
    return self;


}

@end
