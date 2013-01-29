//
//  CreateGroundInWorld.h
//  WormVsBirdsDemo
//
//  Created by Alex Zen on 12-12-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

@interface CreateGroundInWorld : CCSpriteBatchNode {
    
}
+(id) createGroundWithWorld:(b2World*)world;
-(id) initGroundWithWorld:(b2World*)world;




@end
