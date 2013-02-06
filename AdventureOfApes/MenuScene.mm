//
//  MenuScene.m
//  AdventureOfApes
//
//  Created by mumu ya on 13-1-17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "MenuScene.h"
#import "BigStageSelectScene.h"
#import "SimpleAudioEngine.h"
@implementation MenuScene
+(id)scene{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [MenuScene node];
    [scene addChild:layer];
    return scene;
    
}

-(id)init{
    if (self=[super init]) {
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite *bg = [CCSprite spriteWithFile:@"menuBg.png"];
        bg.position = ccp(size.width/2,size.height/2);
        [self addChild:bg z:-1];
        
        CCSprite *bg1 = [CCSprite spriteWithFile:@"menuBg1.png"];
        bg1.position = ccp(size.width-bg1.contentSize.width/2+6,size.height*0.1-5);
        [self addChild:bg1 z:2];
        
        CCMenuItem *storyModeItem = [CCMenuItemImage itemFromNormalImage:
                                     @"storyMode.png"selectedImage:@"sstoryMode.png"disabledImage:nil target:self selector:@selector(storyModeItemTouched:)];
        CCMenuItem *challengeModeItem = [CCMenuItemImage itemFromNormalImage:@"challengeMode.png" selectedImage:@"schallengeMode.png" disabledImage:@"challengeModeLock.png" target:self selector: @selector(btnCall:)];
        challengeModeItem.isEnabled = NO;
        CCMenu *menu = [CCMenu menuWithItems:
                        storyModeItem,challengeModeItem, nil];
        menu.position=ccp(size.width*0.5,size.height*0.72);
        [menu alignItemsHorizontallyWithPadding:58];
        [self addChild:menu z:3];
        
        CCSprite *settingBgSprite = [CCSprite spriteWithFile:@"settingBg.png"];
        [self addChild:settingBgSprite z:3];
        settingBgSprite.position = ccp (size.width*0.92,size.height*0.1);
    
        CCMenuItem *settingItem = [CCMenuItemImage itemFromNormalImage:@"set.png" selectedImage:nil target:self selector: @selector(settingItemTouched:)];
        CCMenu *settingMenu = [CCMenu menuWithItems:
                                   settingItem, nil]; 
        settingMenu.position=ccp(settingBgSprite.contentSize.width/2,settingBgSprite.contentSize.height/2);
        [settingBgSprite addChild:settingMenu z:4];
        
       //add achievement
        CCMenuItem* achievementItem = [CCMenuItemImage itemFromNormalImage:@"achievement.png" selectedImage:@"sachievement.png"disabledImage:@"achievementLock.png" target:self selector:@selector(btnCall:)];
        achievementItem.isEnabled = NO;
        CCMenu *achievementMenu = [CCMenu menuWithItems:
                        achievementItem, nil];
        [achievementMenu alignItemsHorizontally];
        achievementMenu.position=ccp(size.width*0.08,size.height*0.1);
        [self addChild:achievementMenu z:3];
        mode =1;
        
        
        CCMenuItem *faceBookItem = [CCMenuItemImage itemFromNormalImage:@"faceBook.png" selectedImage:@"sfaceBook.png" target:self selector: @selector(openFaceBookURL:)];
        CCMenuItem *twitterItem = [CCMenuItemImage itemFromNormalImage:@"twinter.png" selectedImage:@"stwinter.png" target:self selector: @selector(openTwitterURL:)];
        CCMenu *URLMenu = [CCMenu menuWithItems:
                               faceBookItem,twitterItem, nil];
        [URLMenu alignItemsHorizontallyWithPadding:13];
        URLMenu.position=ccp(142,20);
        [self addChild:URLMenu z:3];
    
        settingSprite =[CCSprite spriteWithFile:@"settingFrame.png"];
        settingSprite.position=ccp(size.width*0.92,-size.height*0.15);
        [self addChild:settingSprite z:1 tag:88];
        
        shakeOnItem = [CCMenuItemImage itemFromNormalImage:@"shakeOn.png" selectedImage:nil
                                                    target:self selector:nil];
        shakeOffItem = [CCMenuItemImage itemFromNormalImage:@"shakeoff.png" selectedImage:nil                                                           target:self selector:nil];
        CCMenuItemToggle *shakeToggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(shakeButtonTapped:) items:shakeOnItem,shakeOffItem,nil];
        
        
        soundOnItem = [CCMenuItemImage itemFromNormalImage:@"soundOn.png" selectedImage:nil
                                                    target:self selector:nil];
        soundOffItem = [CCMenuItemImage itemFromNormalImage:@"soundOff.png" selectedImage:nil                                                           target:self selector:nil];
        
        CCMenuItemToggle *soundToggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundButtonTapped:) items:soundOnItem,soundOffItem,nil];
        
        languageChItem = [CCMenuItemImage itemFromNormalImage:@"languageChina.png" selectedImage:nil
                                                       target:self selector:nil];
        languageEnItem = [CCMenuItemImage itemFromNormalImage:@"languageEn.png" selectedImage:nil                                                           target:self selector:nil];
        
        CCMenuItemToggle *languageToggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundButtonTapped:) items:languageChItem,languageEnItem,nil];
        CCMenu *toggleMenu = [CCMenu menuWithItems:
                              shakeToggle,soundToggle,languageToggle,
                              nil];
        [toggleMenu alignItemsVerticallyWithPadding:1];
        toggleMenu.position=ccp(settingSprite.contentSize.width/2,settingSprite.contentSize.height/2);
        [settingSprite addChild:toggleMenu z:11];
    }
    
    return self;
}

-(void)storyModeItemTouched:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"spiling.wav"];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.2 scene:[BigStageSelectScene scene]]];
}

-(void)settingItemTouched:(CCNode*)node{
   
     CCRotateBy* rotateBy = [CCRotateBy actionWithDuration:0.2 angle:360];
     CGSize screenSize = [[CCDirector sharedDirector] winSize];
    mode++;
    
	if (mode > 1)
	{
		mode = 0;
	}
	
	switch (mode)
	{
		case 0:
        
        {
            
            [node runAction:[CCRepeat actionWithAction:rotateBy times:2]];
            CCMoveTo *moveIn = [CCMoveTo actionWithDuration:0.5 position:ccp(screenSize.width*0.92, screenSize.height*0.44)];
            CCEaseIn *easeMoveIn = [CCEaseIn actionWithAction:moveIn rate:0.5];
            [settingSprite runAction:[CCSequence actions:easeMoveIn,nil]];
            
        }
			break;
		case 1:
        {
            [node runAction:[CCRepeat actionWithAction:[rotateBy reverse] times:2]];
            CCMoveTo *moveOut = [CCMoveTo actionWithDuration:0.5 position:ccp(screenSize.width*0.92, -screenSize.height*0.15)];
            CCEaseInOut *easeMoveOut = [CCEaseInOut actionWithAction:moveOut rate:1];
            [settingSprite runAction:[CCSequence actions:easeMoveOut, nil]];
        }
			break;
	}
    
    
}

-(void) shakeButtonTapped: (id) sender
{
    CCMenuItemToggle *toggleItem = (CCMenuItemToggle *)sender;
    if([toggleItem selectedItem]==shakeOnItem){//设置ON时
        
    }else{
        
        
        
    }
    
}


-(void) soundButtonTapped: (id) sender
{
    CCMenuItemToggle *toggleItem = (CCMenuItemToggle *)sender;
    if([toggleItem selectedItem]==soundOnItem){//设置ON时
        
    }else{
        
        
    }
    
    
}

-(void) openFaceBookURL:(id)sender
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
}

-(void) openTwitterURL:(id)sender
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
}//点击返回图标
//点击btn图标
-(void)btnCall:(id)sender{
    
 //   [[CCDirector sharedDirector]replaceScene:[MainScene scene]];
    
    
}
/*-(void) selectButtonTouched: (id)sender
{
    [[CCDirector sharedDirector]replaceScene:[MainScene scene]];
}*/
-(void)dealloc{
    
    [super dealloc];
    
}
@end
