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

@implementation PauseLayer


-(void)didLoadFromCCB
{
  
    
}

//点击继续按钮
-(void)pauseContiueTouch:(id)sender{
    GameScene *gameScene=(GameScene *)[self parent];
    [gameScene setIsPaused:NO];
    [gameScene schedule:@selector(countDownTime:) interval:1.0];
    
    id moveToOut=[CCMoveTo actionWithDuration:0.3 position:ccp(0, 267)];
    [self runAction:moveToOut];
     NSLog(@"%d",[self numberOfRunningActions]);
    
    [self removeFromParentAndCleanup:YES];

}


//点击菜单按钮返回小关
-(void)pauseMenuTouch:(id)sender{
    NSLog(@"ok");
    [[CCDirector sharedDirector] replaceScene:[SecondStageSelectScene scene]];
}
@end
