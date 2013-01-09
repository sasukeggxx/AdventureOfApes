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

#define PTM_RATIO 32 //单位常量

@interface GameScene : CCLayer {
    b2World *world; // 定义世界
    ContactListener *listener;
    GLESDebugDraw* debugDraw;

}

+(id)scene;
-(void)initTheWorld;

@end
