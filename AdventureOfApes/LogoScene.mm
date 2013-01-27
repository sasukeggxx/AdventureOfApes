//
//  LogoScene.m
//  AdventureOfApes
//
//  Created by mumu ya on 13-1-17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "LogoScene.h"
#import "RoleSelectionScene.h"
#import "GameScene.h"

@implementation LogoScene

+(id)scene{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [LogoScene node];
    [scene addChild:layer];
    return scene;
    
}

-(id)init{
    if (self=[super init]) {
        
        CCLayerColor *bgcol=[CCLayerColor layerWithColor:ccc4(46, 131, 55,255)];//背景色
        [self addChild:bgcol z:0];
        
        CCLabelTTF *logoLabel = [CCLabelTTF labelWithString:@"LOGO" fontName:@"Marker Felt" fontSize:68];
        CGSize size = [[CCDirector sharedDirector] winSize];
        logoLabel.position = CGPointMake(size.width/2, 3*size.height/4);
        [self addChild:logoLabel];
        
        [CCMenuItemFont setFontSize:20];
        CCMenuItemFont *startItem = [CCMenuItemFont itemFromString:@"点击开始游戏" target:self selector:@selector(startItemTouched:)];
        CCMenu* menu = [CCMenu menuWithItems:startItem, nil];
        menu.position = CGPointMake(size.width/2, size.height/3);
        [self addChild:menu];
    }
    
    return self;
}

-(void) startItemTouched: (id)sender
{
     [[CCDirector sharedDirector]replaceScene:[GameScene scene]];
}
-(void)dealloc{
    
    [super dealloc];
    CCLOG(@"LogoScene called dealloc");
    
}
@end
