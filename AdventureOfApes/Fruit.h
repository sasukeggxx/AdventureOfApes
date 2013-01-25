//
//  Fruit.h
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-23.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameObjectTag.h"

@interface Fruit : CCNode {
    FruitType fruitType;
    int scoreValue;//水果分值
}
@property (nonatomic,assign) FruitType fruitType;
@property (nonatomic,assign) int scoreValue;

@end
