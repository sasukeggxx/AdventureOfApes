//  玩家基类
//  Player.h
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Player : CCSprite {
    int collisionCount;  //碰撞次数
    float speed;         //玩家速度
    float maxRadius;     //最大半径
    float minRadius;     //最小半径
}
@property (assign,nonatomic) int collisionCount;
@property (assign,nonatomic) float speed;
@property (assign,nonatomic) float maxRadius;
@property (assign,nonatomic) float minRadius;

@end
