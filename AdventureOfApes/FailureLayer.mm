//
//  FailureLayer.m
//  AdventureOfApes
//
//  Created by Alex Zen on 13-2-5.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "FailureLayer.h"
#import "SecondStageSelectScene.h"
#import "GameScene.h"


@implementation FailureLayer



//点击菜单按钮返回小关
-(void)failureMenuTouch:(id)sender{
    
    [[CCDirector sharedDirector] replaceScene:[SecondStageSelectScene scene]];
}


-(void)failureReplayTouch:(id)sender{
    
    [[CCDirector sharedDirector] replaceScene:[GameScene sceneWithNum:1]];
}




@end
