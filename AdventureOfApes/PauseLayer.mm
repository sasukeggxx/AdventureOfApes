//
//  PauseLayer.m
//  AdventureOfApes
//
//  Created by Alex Zen on 13-2-2.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "PauseLayer.h"
#import "GameScene.h"

@implementation PauseLayer


-(void)didLoadFromCCB
{
  
    
}

-(void)pauseContiueTouch:(id)sender{
    GameScene *gameScene=(GameScene *)[self parent];
    [gameScene setIsPaused:NO];
    
    id moveToOut=[CCMoveTo actionWithDuration:0.3 position:ccp(0, 267)];
    [self runAction:moveToOut];
     NSLog(@"%d",[self numberOfRunningActions]);
    
    [self removeFromParentAndCleanup:YES];
    
   

}


@end
