//
//  WinLayer.m
//  AdventureOfApes
//
//  Created by Alex Zen on 13-2-5.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "WinLayer.h"
#import "SecondStageSelectScene.h"
#import "GameScene.h"

@implementation WinLayer




//点击菜单按钮返回小关
-(void)victoryMenuTouch:(id)sender{
    
    [[CCDirector sharedDirector] replaceScene:[SecondStageSelectScene scene]];
}


-(void)victoryReplayTouch:(id)sender{
    
    [[CCDirector sharedDirector] replaceScene:[GameScene scene]];
}


@end