//  大关选择场景
//  StageSelectScene.h
//  WormVsBirdsDemo
//
//  Created by Alex Zen on 12-12-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BigStageSelectScene : CCLayer <UIScrollViewDelegate>{
    CCMenu *forestMenu;
    CCMenu *caveMenu;
    CCMenu *volcanoMenu;
    CCMenu *backMenu;
    BOOL canTouch;
    float speed;
}
+(id)scene;
-(void) initrFog;
-(void) initlFog;
-(void) initFog1;//addFog
-(void) initFog2;
-(void) initFog3;
-(void) initFog4;
-(void) initFog5;
-(void) initFog6;
-(void) initFog7;
@end
