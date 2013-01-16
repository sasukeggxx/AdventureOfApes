//
//  Util.m
//  WormVsBirdsDemo
//
//  Created by Alex Zen on 12-12-24.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
#define PTM_RATIO 32 //单位常量
#import "GameUtil.h"



@implementation GameUtil

+(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

+(CGPoint) locationFromTouches:(NSSet*)touches
{
	return [self locationFromTouch:[touches anyObject]];
}

// convenience method to convert a CGPoint to a b2Vec2
+(b2Vec2) toMeters:(CGPoint)point
{
	return b2Vec2(point.x / PTM_RATIO, point.y / PTM_RATIO);
}

// convenience method to convert a b2Vec2 to a CGPoint
+(CGPoint) toPixels:(b2Vec2)vec
{
	return ccpMult(CGPointMake(vec.x, vec.y), PTM_RATIO);
}

+(CGPoint) screenCenter
{
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	return CGPointMake(screenSize.width * 0.5f, screenSize.height * 0.5f);
}


//允许显示调试信息
+(void) enableBox2dDebugDrawing:(GLESDebugDraw *) debugDraw withWorld:(b2World *) world
{
	// Debug Draw functions
	debugDraw = new GLESDebugDraw([[CCDirector sharedDirector] contentScaleFactor] * PTM_RATIO);
	world->SetDebugDraw(debugDraw);
	
	uint32 flags = 0;
	flags |= b2DebugDraw::e_shapeBit;
	flags |= b2DebugDraw::e_jointBit;
	//flags |= b2DebugDraw::e_aabbBit;
	//flags |= b2DebugDraw::e_pairBit;
	//flags |= b2DebugDraw::e_centerOfMassBit;
	debugDraw->SetFlags(flags);
}

+(BodyNode *) playerNearToBody:(NSMutableArray *)bodyNodes withPlayer:(BodyNode *)player{

    
    
    return [bodyNodes objectAtIndex:0];
}


-(void)dealloc{
    [super dealloc];
    
}
@end
