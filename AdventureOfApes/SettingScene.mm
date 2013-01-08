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
        
        [CCMenuItemFont setFontName: @"Marker Felt"];
        [CCMenuItemFont setFontSize:26];
		
        CCMenuItemFont *title1 = [CCMenuItemFont itemFromString: @"Music"];
        [title1 setIsEnabled:NO];
        [CCMenuItemFont setFontName: @"Marker Felt"];
        [CCMenuItemFont setFontSize:20];
        CCMenuItemToggle *item1 = [CCMenuItemToggle itemWithTarget:self selector:@selector(musicCallback:) items:
                                   [CCMenuItemFont itemFromString: @"ON"],
                                   [CCMenuItemFont itemFromString: @"OFF"],
                                   nil];
        
        [CCMenuItemFont setFontName: @"Marker Felt"];
        [CCMenuItemFont setFontSize:26];
        CCMenuItemFont *title2 = [CCMenuItemFont itemFromString: @"Sound"];
        [title2 setIsEnabled:NO];
        [CCMenuItemFont setFontName: @"Marker Felt"];
        [CCMenuItemFont setFontSize:20];
        CCMenuItemToggle *item2 = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundCallback:) items:
                                   [CCMenuItemFont itemFromString: @"ON"],
                                   [CCMenuItemFont itemFromString: @"OFF"],
                                   nil];
        
        CCLabelTTF *label=[CCLabelTTF labelWithString:@"Back" fontName:@"Marker Felt" fontSize:23];
        CCMenuItemLabel *back = [CCMenuItemLabel itemWithLabel:label target:self selector:@selector(backCallback:)];
        
        
        CCMenu *menu = [CCMenu menuWithItems:
                        title1, title2,
                        item1, item2,
                        back, nil]; // 9 items.
        [menu alignItemsInColumns:
         [NSNumber numberWithUnsignedInt:2],
         [NSNumber numberWithUnsignedInt:2],
         [NSNumber numberWithUnsignedInt:1],
         nil
         ];
        
        CCLayerColor *layC=[CCLayerColor layerWithColor:ccc4(221, 221, 221,255)];
        
        [self addChild:layC z:0];
        [self addChild: menu z:1];
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
