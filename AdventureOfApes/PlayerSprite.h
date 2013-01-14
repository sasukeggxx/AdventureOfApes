//  玩家物理模型
//  Player.h
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-9.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BodyNode.h"

@interface PlayerSprite : BodyNode {
    
}

+(id)addToWorld:(b2World *) world;
-(void)setSpriteStartPosition;
-(id)initwithWorld:(b2World *) world;
@end
