//
//  InputLayer.m
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-18.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "InputLayer.h"
#import "SecondStageSelectScene.h"


@implementation InputLayer


-(id)init{

    if (self=[super init]) {
        
        CCMenuItemSprite *backItem=[CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"backBtn.png"]
                                                          selectedSprite:[CCSprite spriteWithFile:@"backBtn.png"] disabledSprite:[CCSprite spriteWithFile:@"backBtn.png"]
                                                                  target:self selector:@selector(backBtnTouched:)];
        
      
        
        
        CCMenu *menu = [CCMenu menuWithItems:backItem,nil];
        
          menu.position=ccp(60.0, 280.0);
        
        [self addChild:menu];
    }

    return  self;
}

-(void) backBtnTouched: (id) sender
{
    //  NSLog(@"%d",[sender selectedIndex]);
    [[CCDirector sharedDirector] replaceScene:[SecondStageSelectScene scene]];
}



-(void)dealloc{
    [super dealloc]; 

}



@end
