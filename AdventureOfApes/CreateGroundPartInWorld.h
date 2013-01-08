//  创建游戏场景的物理世界
//  CreateGroundPartInWorld.h
//  WormVsBirdsDemo
//
//  Created by Alex Zen on 12-12-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BodyNode.h"
#import "Box2D.h"

@interface CreateGroundPartInWorld : BodyNode {
    
}

+(id) groundPartInWorld:(b2World*)world position:(CGPoint)pos name:(NSString*)name;

-(id) initWithWorld:(b2World*)world position:(CGPoint)pos name:(NSString *)name;
@end
