//
//  StageSelectScene.m
//  WormVsBirdsDemo
//
//  Created by Alex Zen on 12-12-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "BigStageSelectScene.h"
#import "StoreScene.h"
#import "MainScene.h"
#import "SecondStageSelectScene.h"

@implementation BigStageSelectScene
+(id)scene{
    CCScene *scene=[CCScene node];
    CCLayer *starLayer=[BigStageSelectScene node];
    [scene addChild:starLayer];
    return scene;
}

-(id)init{
    
    if (self=[super init]) {
        
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCLabelTTF *backLab=[CCLabelTTF labelWithString:@"返回" fontName:@"Marker Felt" fontSize:20];
        CCMenuItemLabel *backItem = [CCMenuItemLabel itemWithLabel:backLab target:self selector:@selector(backCall:)];
        
        CCMenu *menu = [CCMenu menuWithItems:
                        backItem,nil]; // 1 items.
        
        menu.position=ccp(size.width-backLab.contentSize.width,size.height*0.1);
        
     
        CCLayerColor *bgcol=[CCLayerColor layerWithColor:ccc4(46, 131, 55,255)];//背景色
        
        [self addChild:bgcol z:0];
        [self addChild:menu z:1];
        

        
    }
    return self;
}



//点击btn图标
-(void)btnCall:(id)sender{
    
    [[CCDirector sharedDirector]replaceScene:[SecondStageSelectScene scene]];
    
}

//点击返回图标
-(void)backCall:(id)sender{
    
    [[CCDirector sharedDirector]replaceScene:[MainScene scene]];
    
    
}

-(void)dealloc{
    
    
    [super dealloc];
    CCLOG(@"StageSelectScene called dealloc");
    
}

@end
