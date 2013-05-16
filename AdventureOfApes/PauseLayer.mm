//
//  PauseLayer.m
//  AdventureOfApes
//
//  Created by Alex Zen on 13-2-2.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "PauseLayer.h"
#import "GameScene.h"
#import "SecondStageSelectScene.h"
#import "GameScene.h"

@implementation PauseLayer


-(void)didLoadFromCCB
{
  
    
}

//点击继续按钮
-(void)pauseContiueTouch:(id)sender{
    CGSize size=[[CCDirector sharedDirector] winSize];
    GameScene *gameScene=(GameScene *)[self parent];
    [gameScene setIsPaused:NO];
    [gameScene schedule:@selector(countDownTime:) interval:1.0];
    
    id moveToOut=[CCMoveTo actionWithDuration:0.2 position:ccp(0, size.height)];
    [self runAction:moveToOut];

}


//点击菜单按钮返回小关
-(void)pauseMenuTouch:(id)sender{
    
    [[CCDirector sharedDirector] replaceScene:[SecondStageSelectScene scene]];
}


-(void)pauseReplayTouch:(id)sender{
    
    [[CCDirector sharedDirector] replaceScene:[GameScene sceneWithNum:1]];
}


@end
