//
//  uncompleteImage.h
//  completeImage
//
//  Created by 张力 on 14-6-4.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface uncompleteImage : NSObject
{
    double positionX;
    double positionY;
}

@property (nonatomic , strong) UIImageView *uncompleteIMG;
@property (nonatomic , strong) UIButton *emptyIMG;


-(id)initWithEmpty:(NSString *)fullImage :(NSNumber *)pos_x :(NSNumber *)pos_y;
@end
