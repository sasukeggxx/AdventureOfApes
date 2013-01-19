//
//  StageSelectScene.m
//  WormVsBirdsDemo
//
//  Created by Alex Zen on 12-12-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "BigStageSelectScene.h"
#import "StoreScene.h"
#import "SecondStageSelectScene.h"

@implementation BigStageSelectScene
+(id)scene{
    CCScene *scene=[CCScene node];
    CCLayer *layer=[BigStageSelectScene node];
    [scene addChild:layer];
    return scene;
}

-(id)init{
    
    if (self=[super init]) {
        
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite  *ilandSprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"2.png"]];
        CCSprite *silandSprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"11.png"]];
        
        CCMenuItemSprite *ilandItem = [CCMenuItemSprite itemFromNormalSprite:ilandSprite selectedSprite:silandSprite target:self selector:@selector(btnCall:)];
        
        CCSprite  *seaSprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"1.png"]];
        CCSprite *sseaSprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"11.png"]];
        CCMenuItemSprite *seaItem = [CCMenuItemSprite itemFromNormalSprite:seaSprite selectedSprite:sseaSprite target:self selector: @selector(btnCall:)];
        
        CCSprite  *landSprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"3.png"]];
        CCSprite *slandSprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"11.png"]];
        CCMenuItemLabel *landItem = [CCMenuItemSprite itemFromNormalSprite:landSprite  selectedSprite:slandSprite target:self selector:@selector(btnCall:)];
        
        CCMenu *menu = [CCMenu menuWithItems:
                        ilandItem,seaItem,nil]; // 1 items.
        
        [menu alignItemsHorizontallyWithPadding:40];
        menu.position=ccp(size.width*0.5,size.height*0.7);
        
        CCMenu *menu1 = [CCMenu menuWithItems:landItem, nil];
        menu1.position =ccp(size.width*0.5,size.height*0.2);
     
        CCLayerColor *bgcol=[CCLayerColor layerWithColor:ccc4(46, 131, 55,255)];//背景色
        
        [self addChild:bgcol z:0];
        [self addChild:menu z:1];
        [self addChild:menu1 z:1];
        

        
    }
    return self;
}



//点击btn图标
-(void)btnCall:(id)sender{
    //CCScaleTo *scaleBy1 = [CCScaleTo actionWithDuration:2 scale:1.0f];
    //CCScaleTo *scaleTo1 = [CCScaleTo actionWithDuration:0.01 scale:0.6f];
    //CCDelayTime* waitAction = [CCDelayTime actionWithDuration:0.2]; //等待3秒
    //CCCallFunc* vanishAction = [CCCallFunc actionWithTarget:self selector:@selector(backCall:)]; //调用removeSprite:方法
    //CCSequence *scaleSequence = [CCSequence actions: scaleTo1,waitAction,vanishAction, nil];
    //CCRepeatForever *repeatScale = [CCRepeatForever actionWithAction:scaleSequence];
    //[i runAction:repeatScale];
    [[CCDirector sharedDirector]replaceScene:[SecondStageSelectScene scene]];         
    
}

//点击返回图标
-(void)backCall:(id)sender{
    
   // [[CCDirector sharedDirector]replaceScene:[MainScene scene]];
       
}

-(void)dealloc{
    
    
    [super dealloc];
    CCLOG(@"StageSelectScene called dealloc");
    
}

@end
