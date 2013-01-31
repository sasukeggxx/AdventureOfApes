//
//  MainScene.m
//  WormVsBirdsDemo
//
//  Created by 曾 哲 on 12-12-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainScene.h"
#import "BigStageSelectScene.h"


@implementation MainScene

+(id)scene{
    CCScene *scene=[CCScene node];
    CCLayer *layer=[MainScene node];
    [scene addChild:layer];
    return scene;
}

-(id)init{
    if (self=[super init]) {
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCLabelTTF *titleLab = [CCLabelTTF labelWithString:@"人猿大冒险" fontName:@"Marker Felt"
                                                  fontSize:40];
        titleLab.position=ccp(size.width*0.5,size.height*0.8 );
        [titleLab setColor:ccORANGE];
        
        CCLabelTTF *battleLab=[CCLabelTTF labelWithString:@"新游戏" fontName:@"Marker Felt" fontSize:30];
        CCMenuItemLabel *battleItem = [CCMenuItemLabel itemWithLabel:battleLab target:self selector:@selector(battleCall:)];
                
        CCLabelTTF *storeLab=[CCLabelTTF labelWithString:@"商店" fontName:@"Marker Felt" fontSize:20];
        CCMenuItemLabel *storeItem = [CCMenuItemLabel itemWithLabel:storeLab target:self selector:@selector(storeSceneCall:)];
        
        CCLabelTTF *settingLab=[CCLabelTTF labelWithString:@"设置" fontName:@"Marker Felt" fontSize:20];
        CCMenuItemLabel *settingItem = [CCMenuItemLabel itemWithLabel:settingLab target:self selector:@selector(settingCall:)];
        
        
        CCMenu *menu = [CCMenu menuWithItems:
                        battleItem,storeItem,settingItem,nil]; // 6 items.
        
        menu.position=ccp(size.width*0.5,size.height*0.25);
        
        
        [menu alignItemsInColumns:
         [NSNumber numberWithUnsignedInt:1],
         [NSNumber numberWithUnsignedInt:2],
         [NSNumber numberWithUnsignedInt:1],
         nil
         ];
        
        CCLayerColor *bgcol=[CCLayerColor layerWithColor:ccc4(46, 131, 55,255)];//背景色
        
        [self addChild:bgcol z:0];
        [self addChild:titleLab z:1];
        [self addChild:menu z:1];
        
    }
    return self;
}

//点击征战图标
-(void)battleCall:(id)sender{
    
   [[CCDirector sharedDirector]replaceScene:[BigStageSelectScene scene]];
    
    
}




-(void)dealloc{
    
    [super dealloc];
    CCLOG(@"MainScene called dealloc");
    
}
@end
