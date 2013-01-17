//
//  Util.h
//  WormVsBirdsDemo
//
//  Created by Alex Zen on 12-12-24.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "BodyNode.h"


@interface GameUtil : CCNode {
    
}

+(b2Vec2) toMeters:(CGPoint)point;
+(CGPoint) toPixels:(b2Vec2)vec;

+(CGPoint) locationFromTouch:(UITouch*)touch;
+(CGPoint) locationFromTouches:(NSSet*)touches;

+(CGPoint) screenCenter;

//玩家最靠近哪个挂件
// return 最近的挂件
+(BodyNode *) playerNearToBody:(NSMutableArray *)bodyNodes withPlayer:(BodyNode *)player;


+(void) enableBox2dDebugDrawing:(GLESDebugDraw *) debugDraw withWorld:(b2World *) world;
@end
