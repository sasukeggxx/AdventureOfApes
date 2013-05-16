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
#import "CreateGroundInWorld.h"
#import "GameObjectTag.h"

#define PTM_RATIO 32 //单位常量

@interface GameScene : CCLayer {
    b2World *world; // 定义世界
    ContactListener *listener;
    GLESDebugDraw* debugDraw;
    PlayerSpriteA *player;

    CreateGroundInWorld *groundShape;
    
    b2RevoluteJointDef ropeJointDef;
    b2Body *ropeBody;
    
    //绳子定位挂件关节
    b2RevoluteJoint *ropeJoint;
    b2RevoluteJoint *playerJoint;
    
    BodyNode *nearGuanjian;
    
    int score;  //分值
    CCLayer *bgLayer;
    CCLayer *inputLayer;
    CCLayer *gameObjectLayer;
    GameOverType gameOverType;
    
    BOOL isPaused;//是否暂停
    
    int stageIndex;

}

@property (nonatomic,assign) BOOL isPaused;
@property (nonatomic,assign) int stageIndex;


+(id)sceneWithNum:(int) stageNum;
-(void)initTheWorld;
-(void)initThePlayer;
-(id)initWithStageNum:(int)stageNum;
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end
