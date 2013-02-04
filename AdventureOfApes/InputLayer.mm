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
    if ([gameScene getChildByTag:pauseLayerTag]) {
        return;
    }
    [gameScene setIsPaused:YES];//暂停
    [gameScene unschedule:@selector(countDownTime:)];
    
    CCLayer *pauseLayer=(CCLayer *)[CCBReader nodeGraphFromFile:@"pauseLayer.ccb"];
    [gameScene addChild:pauseLayer z:1 tag:pauseLayerTag];
    id moveToCenter=[CCMoveTo actionWithDuration:0.3 position:ccp(0, 2)];
    [pauseLayer runAction:moveToCenter];

}






@end
