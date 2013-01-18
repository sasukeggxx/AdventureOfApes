//
//  Player.m
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-9.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "PlayerSpriteA.h"
#import "GameUtil.h"


@implementation PlayerSpriteA


+(id)addToWorld:(b2World *) world{

    return [[[self alloc]initwithWorld:world]autorelease];
}

-(id)initwithWorld:(b2World *) world{

    if (self=[super initWithShape:@"fgtBoy" inWord:world withB2Type:b2_dynamicBody]) {

        self.maxRadius=120.0;//最大半径
        
        self.minRadius=self.contentSize.width+10.0;//最小半径
        
        self.speed=5.0; //初始速度
        
        self.collisionCount=0; //初始碰撞次数
        
        super.body->SetAngularDamping(0.9f);
        
        [self setSpriteStartPosition];
        
        [self scheduleUpdate];
        
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


-(void) update:(ccTime)delta{
    
    if (self.position.y<-10) {//玩家死了
        [self setSpriteStartPosition];
    }



}


-(void)dealloc{

    [super dealloc];

}

@end
