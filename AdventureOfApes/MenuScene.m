//
//  MenuScene.m
//  AdventureOfApes
//
//  Created by mumu ya on 13-1-17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "MenuScene.h"
#import "BigStageSelectScene.h"
#import "SettingScene.h"
@implementation MenuScene
+(id)scene{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [MenuScene node];
    [scene addChild:layer];
    return scene;
    
}

-(id)init{
    if (self=[super init]) {
        
        CCLayerColor *bgcol = [CCLayerColor layerWithColor:ccc4(46, 131, 55,255)];//背景色
        [self addChild:bgcol z:0];
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCLabelTTF *storyModeLab=[CCLabelTTF labelWithString:@"剧情模式" fontName:@"Marker Felt" fontSize:20];
        CCMenuItemLabel *storyModeItem = [CCMenuItemLabel itemWithLabel:storyModeLab target:self selector:@selector(storyModeItemTouched:)];
        
        CCLabelTTF *challengeModeLab=[CCLabelTTF labelWithString:@"挑战模式" fontName:@"Marker Felt" fontSize:20];
        CCMenuItemLabel *challengeModeItem = [CCMenuItemLabel itemWithLabel:challengeModeLab target:self selector:@selector(btnCall:)];
        
        CCLabelTTF *settingLab=[CCLabelTTF labelWithString:@"选项设置" fontName:@"Marker Felt" fontSize:20];
        CCMenuItemLabel *settingItem = [CCMenuItemLabel itemWithLabel:settingLab target:self selector:@selector(settingItemTouched:)];
        
        CCLabelTTF *achievementLab=[CCLabelTTF labelWithString:@"成就" fontName:@"Marker Felt" fontSize:20];
        CCMenuItemLabel *achievementItem = [CCMenuItemLabel itemWithLabel:achievementLab target:self selector:@selector(btnCall:)];
        
        CCLabelTTF *backLab=[CCLabelTTF labelWithString:@"退出游戏" fontName:@"Marker Felt" fontSize:20];
        CCMenuItemLabel *backItem = [CCMenuItemLabel itemWithLabel:backLab target:self selector:@selector(btnCall:)];
        
        CCMenu *menu = [CCMenu menuWithItems:
                        storyModeItem,challengeModeItem,settingItem,achievementItem,backItem, nil]; // 1 items.
        
        
        [menu alignItemsVerticallyWithPadding:20];
        menu.position=ccp(size.width*0.2,size.height*0.5);
        [self addChild:menu];
        
    }
    
    return self;
}

-(void)storyModeItemTouched:(id)sender
{
   [[CCDirector sharedDirector]replaceScene:[BigStageSelectScene scene]];
}

-(void)settingItemTouched:(id)sender
{
    [[CCDirector sharedDirector]pushScene:[SettingScene scene]];
}
//点击返回图标
-(void)btnCall:(id)sender{
    
 //   [[CCDirector sharedDirector]replaceScene:[MainScene scene]];
    
    
}
/*-(void) selectButtonTouched: (id)sender
{
    [[CCDirector sharedDirector]replaceScene:[MainScene scene]];
}*/
-(void)dealloc{
    
    [super dealloc];
    CCLOG(@"RoleSelectionScene called dealloc");
    
}
@end
