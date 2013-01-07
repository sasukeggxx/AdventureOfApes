//
//  StoreScene.m
//  WormVsBirdsDemo
//
//  Created by Alex Zen on 12-12-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "StoreScene.h"
#import "MainScene.h"

@implementation StoreScene

+(id)scene{
    CCScene *scene=[CCScene node];
    CCLayer *starLayer=[StoreScene node];
    [scene addChild:starLayer];
    return scene;
}

-(id)init{
    if (self=[super init]) {
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCLabelTTF *titleLab = [CCLabelTTF labelWithString:@"商店界面" fontName:@"Marker Felt"
                                                  fontSize:40];
        titleLab.position=ccp(size.width*0.5,size.height*0.8);
        [titleLab setColor:ccORANGE];
        
        CCLabelTTF *backLab=[CCLabelTTF labelWithString:@"返回" fontName:@"Marker Felt" fontSize:20];
        CCMenuItemLabel *backItem = [CCMenuItemLabel itemWithLabel:backLab target:self selector:@selector(backCall:)];
        
        CCMenu *menu = [CCMenu menuWithItems:
                        backItem,nil]; // 1 items.
        
        menu.position=ccp(size.width-backLab.contentSize.width,size.height*0.2);
        
        CCLayerColor *bgcol=[CCLayerColor layerWithColor:ccc4(46, 131, 55,255)];//背景色
        
        [self addChild:bgcol z:0];
        [self addChild:titleLab z:1];
        [self addChild:menu z:1];
        
    }
    return self;
}


//点击返回图标
-(void)backCall:(id)sender{
    
    [[CCDirector sharedDirector]replaceScene:[MainScene scene]];
    
    
}

-(void)dealloc{
    
    [super dealloc];
    CCLOG(@"StoreScene called dealloc");
    
}
@end
