//
//  GameScene.h
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-8.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "ContactListener.h"
#import "PlayerSpriteA.h"
#import "RopeSprite.h"
#import "CreateGroundInWorld.h"

#define PTM_RATIO 32 //单位常量

@interface GameScene : CCLayer {
    b2World *world; // 定义世界
    ContactListener *listener;
    GLESDebugDraw* debugDraw;
    PlayerSpriteA *player;
    RopeSprite *rope;
   // CCSprite *player;
    CreateGroundInWorld *groundShape;
    CCLayer *groundLayer;
    b2RevoluteJointDef ropeJointDef;  //绳子定位挂件关节
    b2RevoluteJoint *ropeJoint;
    b2RevoluteJointDef playerJointDef;//绳子末端关节
    b2RevoluteJoint *playerJoint;

}

+(id)scene;
-(void)initTheWorld;
-(void)initThePlayer;
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end