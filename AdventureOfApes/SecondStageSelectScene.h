//  二级关卡选择场景
//  SecondStageSelectScene.h
//  WormVsBirdsDemo
//
//  Created by Alex Zen on 12-12-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SecondStageSelectScene : CCLayer <UIScrollViewDelegate>{
    UIPageControl *pagecontrol;
    UIScrollView *scrollview;
    float height;
    NSMutableArray *smallState;
    NSMutableArray *smallCup;
    int buttonState;
    int smallCupNumber;
//    int i;
}
+(id)scene;
-(void)processMap:(NSDictionary*)dic;
-(CCLayer*) runRecipe;
@end
