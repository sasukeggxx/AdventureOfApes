// 
//  PlayerA.m
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "PlayerA.h"


@implementation PlayerA



+(id)player{

    return [[[self alloc]initWithImg]autorelease];

}

-(id)initWithImg{
    if (self=[super initWithFile:@"long.png"]) {
        speed=1.0;
        collisionCount=0;
        maxRadius=50;
        minRadius=5;   
    }
    return self;
}


-(void)dealloc{

    [super dealloc];

}

@end
