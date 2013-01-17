//
//  Util.m
//  WormVsBirdsDemo
//
//  Created by Alex Zen on 12-12-24.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
#define PTM_RATIO 32 //单位常量
#import "GameUtil.h"

float distanceBetweenPoints(CGPoint p1, CGPoint p2){
    return sqrt( pow( (p1.x-p2.x) ,2) + pow( (p1.y-p2.y) ,2) );
}

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

    if (bodyNodes.count==0) {
        return nil;
    }
    NSMutableDictionary *distansDic=[NSMutableDictionary dictionaryWithCapacity:bodyNodes.count];
    NSMutableArray  *distanses=[NSMutableArray arrayWithCapacity:bodyNodes.count];
    for (int i=0; i<bodyNodes.count; i++) {
        BodyNode *bodyNode=[bodyNodes objectAtIndex:i];
//        CGFloat dis=ccpDistance(bodyNode.position, player.position);
//        [distansDic setObject:bodyNode forKey:[NSString stringWithFormat:@"%f",dis]];
//        [distanses addObject:[NSNumber numberWithFloat:(float)dis]];
          float dis=distanceBetweenPoints(bodyNode.position, player.position);
          [distansDic setObject:bodyNode forKey:[NSString stringWithFormat:@"%d",(int)dis]];
          [distanses addObject:[NSNumber numberWithInt:(int)dis]];
    }
  
    
    NSNumber *minDistans=[distanses objectAtIndex:0];
    
    for (int i=0; i<distanses.count; i++) {
        NSNumber *dis=[distanses objectAtIndex:i];
        if ([minDistans compare:dis]==NSOrderedDescending) {
            minDistans=dis;
        }
        
    }
    
    return [distansDic objectForKey:[NSString stringWithFormat:@"%d",[minDistans intValue]]];
}


-(void)dealloc{
    [super dealloc];
    
}
@end
