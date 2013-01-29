//
//  Player.m
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-9.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "PlayerSpriteA.h"
#import "GameUtil.h"
#import "GameObjectTag.h"
#import "GameScene.h"


@implementation PlayerSpriteA


+(id)addToWorld:(b2World *) world{

    return [[[self alloc]initwithWorld:world]autorelease];
}

-(id)initwithWorld:(b2World *) world{

    if (self=[super initWithShape:@"fgtBoy" inWord:world withB2Type:b2_dynamicBody]) {

        self.life=3;
        
        self.maxRadius=340.0;//最大半径
        
        self.minRadius=30.0;//最小半径
        
        self.speed=5.0; //初始速度
        
        self.collisionCount=0; //初始碰撞次数
        
        self.tailName=@"tail.png";
        
        super.body->SetAngularDamping(0.9f);
        
        [self setSpriteStartPosition];
        
    

       
        
    }
    return self;

}

-(void)initTheTailWithLayer:(CCLayer *)layer{

    CCSprite *tailSprite=[CCSprite spriteWithFile:self.tailName];
    CCMotionStreak* streak = [CCMotionStreak streakWithFade:0.5f
                                                     minSeg:10.f
                                                      image:self.tailName
                                                      width:tailSprite.contentSize.width
                                                      length:tailSprite.contentSize.height
                                                      color:ccc4(255, 0, 255, 255)];
	[layer addChild:streak z:-2 tag:ParallaxSceneTagRibbon];
    
    
}

//设置精灵在屏幕出现的位置
-(void) setSpriteStartPosition
{
    // set the ball's position
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    CGPoint startPos = ccp(CCRANDOM_0_1()*size.width, size.height);//精灵出现位置
    
    body->SetTransform([GameUtil toMeters:startPos], 0.0f);//位置,角度
    body->SetLinearVelocity(b2Vec2_zero);//速度重置
    body->SetAngularVelocity(0.0f);
    
    [self schedule:@selector(applyForce:)];
    
    body->SetLinearVelocity(b2Vec2(7, 0));//偏移速度
    
    
}


//应用力将玩家在屏幕上方悬空
-(void) applyForce:(ccTime)delta{
    float m=self.body->GetMass(); //质量
    b2Vec2 backGravity=-1*self.body->GetWorld()->GetGravity(); //重力加速度
    self.body->ApplyForce(m*backGravity, self.body->GetPosition());
    time=time+delta;
    if (time>3) {//如果超过三秒则取消悬空
        [self unschedule:_cmd];
        time=0.0;
    }
    
}

-(void) update:(ccTime)delta{
        
    
    
    
   

   

}




-(void)dealloc{

    [super dealloc];

}

@end
