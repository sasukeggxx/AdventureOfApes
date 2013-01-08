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

@interface GameUtil : CCNode {
    
}

+(b2Vec2) toMeters:(CGPoint)point;
+(CGPoint) toPixels:(b2Vec2)vec;

+(CGPoint) locationFromTouch:(UITouch*)touch;
+(CGPoint) locationFromTouches:(NSSet*)touches;

+(CGPoint) screenCenter;
@end
