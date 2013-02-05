//
//  InputLayer.m
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-18.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "InputLayer.h"
#import "SecondStageSelectScene.h"
#import "GameObjectTag.h"
#import "GameScene.h"

@implementation InputLayer




-(void)pauseBtnTouch:(id)sender
{
    
    GameScene *gameScene=(GameScene *)[self parent];
    [gameScene setIsPaused:YES];//暂停
    [gameScene unschedule:@selector(countDownTime:)];
    
    if ([gameScene getChildByTag:pauseLayerTag]) { //如果pauselayer存在则只移动
        CCLayer *pauseLayer=(CCLayer *)[gameScene getChildByTag:pauseLayerTag];
        id moveToCenter=[CCMoveTo actionWithDuration:0.2 position:CGPointZero];
        [pauseLayer runAction:moveToCenter];
        return;
    }
    
    
    CCLayer *pauseLayer=(CCLayer *)[CCBReader nodeGraphFromFile:@"pauseLayer.ccb"];
    [gameScene addChild:pauseLayer z:1 tag:pauseLayerTag];
    id moveToCenter=[CCMoveTo actionWithDuration:0.2 position:CGPointZero];
    [pauseLayer runAction:moveToCenter];

}






@end
