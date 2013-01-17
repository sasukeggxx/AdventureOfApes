//
//  SettingScene.m
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-8.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "SettingScene.h"


@implementation SettingScene

+(id)scene{
    CCScene *scene=[CCScene node];
    CCLayer *layer=[SettingScene node];
    [scene addChild:layer];
    return scene;
    
}
-(id)init{
    if ((self=[super init])) {
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCLayerColor *layC=[CCLayerColor layerWithColor:ccc4(46, 131, 55,255)];
        [self addChild:layC z:0];
        
        [CCMenuItemFont setFontName: @"Marker Felt"];
        [CCMenuItemFont setFontSize:20];
        CCMenuItemFont *title1 = [CCMenuItemFont itemFromString: @"震动"];
        [title1 setIsEnabled:NO];
        
        [CCMenuItemFont setFontName: @"Marker Felt"];
        [CCMenuItemFont setFontSize:20];
        CCMenuItemFont *title2 = [CCMenuItemFont itemFromString: @"背景音乐"];
        [title2 setIsEnabled:NO];
        
        CCMenu *menu1 = [CCMenu menuWithItems:
                         title1, title2,
                         nil];
        [menu1 alignItemsVerticallyWithPadding:20];
        menu1.position=ccp(size.width*0.2,size.height*0.5);
        [self addChild: menu1 z:1];
        
        [CCMenuItemFont setFontName: @"Marker Felt"];
        [CCMenuItemFont setFontSize:20];
        CCMenuItemToggle *item1 = [CCMenuItemToggle itemWithTarget:self selector:@selector(musicCallback:) items:
                                   [CCMenuItemFont itemFromString: @"ON"],
                                   [CCMenuItemFont itemFromString: @"OFF"],
                                   nil];
        
        
        [CCMenuItemFont setFontName: @"Marker Felt"];
        [CCMenuItemFont setFontSize:20];
        CCMenuItemToggle *item2 = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundCallback:) items:
                                   [CCMenuItemFont itemFromString: @"ON"],
                                   [CCMenuItemFont itemFromString: @"OFF"],
                                   nil];
        
        CCMenu *menu2 = [CCMenu menuWithItems:
                         item1, item2,
                         nil];
        [menu2 alignItemsVerticallyWithPadding:20];
        menu2.position=ccp(size.width*0.7,size.height*0.5);
         [self addChild:menu2 z:1];
        
        CCLabelTTF *label=[CCLabelTTF labelWithString:@"Back" fontName:@"Marker Felt" fontSize:23];
        CCMenuItemLabel *back = [CCMenuItemLabel itemWithLabel:label target:self selector:@selector(backCallback:)];
        CCMenu *menu3 = [CCMenu menuWithItems:
                         back,
                         nil];
        menu3.position=ccp(size.width*0.5,size.height*0.2);
         [self addChild:menu3 z:1];
                

    }
    
    
    return self;
}

-(void) musicCallback: (id) sender
{
    //  NSLog(@"%d",[sender selectedIndex]);
    if([sender selectedIndex]==1){//设置OFF时
        
    }else{
      
        
        
    }
    
}


-(void) soundCallback: (id) sender
{
    
    if([sender selectedIndex]==1){
       
    }else{
      
        
    }
    
    
}

-(void) backCallback: (id) sender
{
   
    [[CCDirector sharedDirector] popScene];
    
}


-(void)dealloc{
    
    [super dealloc];
    CCLOG(@"SettingScene called dealloc");
    
}
@end
