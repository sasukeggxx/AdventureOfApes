//
//  RopeSprite.m
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-15.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "RopeSprite.h"
#import "GameUtil.h"


@implementation RopeSprite

+(id)addToWorld:(b2World *) world{
    
    return [[[self alloc]initwithWorld:world]autorelease];
}

-(id)initwithWorld:(b2World *) world{
    
    if (self=[super initWithShape:@"fgtRope2" inWord:world withB2Type:b2_dynamicBody]) {
             
       
        
      
        
        //[self scheduleUpdate];
        
    }
    return self;
    
}

-(void) setRopeSpritePosition:(CGPoint)pos
{
   
    body->SetTransform([GameUtil toMeters:pos], 0.0f);//位置,角度
    body->SetLinearVelocity(b2Vec2_zero);//速度重置
    body->SetAngularVelocity(0.0f);
}

-(void)dealloc{
    
    [super dealloc];
    
}

@end
