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
    int life;            //玩家生命值
    float speed;         //玩家速度
    float maxRadius;     //最大半径
    float minRadius;     //最小半径
    NSString *tailName;  //玩家尾巴
    bool isCircle;       //玩家是否在转圈
    BodyNode *cirleWithGuanjian;   //玩家围着哪个挂件转圈
}
@property (nonatomic,assign) int collisionCount;
@property (nonatomic,assign) int life;
@property (nonatomic,assign) float speed;
@property (nonatomic,assign) float maxRadius;
@property (nonatomic,assign) float minRadius;
@property (nonatomic,retain) NSString *tailName;
@property (nonatomic,assign) bool isCircle;
@property (nonatomic,retain) BodyNode *cirleWithGuanjian; 


@end
