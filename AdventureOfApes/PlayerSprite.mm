//
//  Player.m
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-9.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "PlayerSprite.h"
#import "GameUtil.h"


@implementation PlayerSprite


+(id)addToWorld:(b2World *) world{

    return [[[self alloc]initwithWorld:world]autorelease];
}

-(id)initwithWorld:(b2World *) world{

    if (self=[super initWithShape:@"long" inWord:world]) {

        super.body->SetType(b2_dynamicBody);
        
        super.body->SetAngularDamping(0.9f);
        
        [self setSpriteStartPosition];
        
        //[self scheduleUpdate];
        
    }
    return self;

}

-(void) setSpriteStartPosition
{
    // set the ball's position
    CGPoint startPos = ccp(80, 280);//精灵出现位置
    
    body->SetTransform([GameUtil toMeters:startPos], 0.0f);//位置,角度
    body->SetLinearVelocity(b2Vec2_zero);//速度重置
    body->SetAngularVelocity(0.0f);
}

-(void)dealloc{

    [super dealloc];

}

@end
