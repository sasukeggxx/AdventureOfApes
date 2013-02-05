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
#import "Player.h"




@interface PlayerSpriteA : Player {
    float time; //时间计数,用于计算玩家悬空时间
   
}

+(id)addToWorld:(b2World *) world;
-(void)setSpriteStartPosition;
-(id)initwithWorld:(b2World *) world;
-(void)initTheTailWithLayer:(CCLayer *)layer;
-(void)initTheParticleTail;
@end
