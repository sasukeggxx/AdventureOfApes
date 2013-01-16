//
//  RopeSprite.h
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-15.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BodyNode.h"

@interface RopeSprite : BodyNode {
    
}
+(id)addToWorld:(b2World *) world;
-(void)setRopeSpritePosition:(CGPoint) pos;
-(id)initwithWorld:(b2World *) world;

@end
