//
//  Player.h
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-15.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BodyNode.h"

@interface Player : BodyNode {
    int collisionCount;  //碰撞次数
    float speed;         //玩家速度
    float maxRadius;     //最大半径
    float minRadius;     //最小半径
}
@property (nonatomic,assign) int collisionCount;
@property (nonatomic,assign) float speed;
@property (nonatomic,assign) float maxRadius;
@property (nonatomic,assign) float minRadius;


@end
