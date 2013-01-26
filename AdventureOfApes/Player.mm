//
//  Player.m
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-15.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Player.h"


@implementation Player


@synthesize life;
@synthesize collisionCount;
@synthesize speed;
@synthesize maxRadius;
@synthesize minRadius;
@synthesize tailName;



-(void)dealloc{
    [tailName release];
    [super dealloc];

}

@end
