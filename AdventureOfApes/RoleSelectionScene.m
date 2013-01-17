//
//  RoleSelectionScene.m
//  AdventureOfApes
//
//  Created by mumu ya on 13-1-17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "RoleSelectionScene.h"
#import "MenuScene.h"
@implementation RoleSelectionScene

+(id)scene{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [RoleSelectionScene node];
    [scene addChild:layer];
    return scene;
    
}

-(id)init{
    if (self=[super init]) {
        
        CCLayerColor *bgcol=[CCLayerColor layerWithColor:ccc4(46, 131, 55,255)];//背景色
        [self addChild:bgcol z:0];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"请选择您的角色" fontName:@"STHeitiJ-Light"fontSize:20];
        CGSize size = [[CCDirector sharedDirector] winSize];
        label.position = CGPointMake(size.width/2, size.height/4);
        [self addChild:label];
        
        view = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, size.width, size.height)];
        
        UIButton *gagaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        gagaButton.frame = CGRectMake(size.width*0.1, size.height*0.2,100,120);
        [gagaButton setBackgroundImage:[UIImage imageNamed:@"tollgate-STONE.png"] forState:UIControlStateNormal];
        [gagaButton setTitle:@"gaga" forState:UIControlStateNormal];
        [gagaButton addTarget:self action:@selector(selectButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:gagaButton];
        
        UIButton *ladyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        ladyButton.frame = CGRectMake(size.width*0.3, size.height*0.2,100,120);
        [ladyButton setBackgroundImage:[UIImage imageNamed:@"tollgate-STONE.png"] forState:UIControlStateNormal];
        [ladyButton setTitle:@"lady" forState:UIControlStateNormal];
        [ladyButton addTarget:self action:@selector(selectButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:ladyButton];
        
        UIButton *ehehButton = [UIButton buttonWithType:UIButtonTypeCustom];
        ehehButton.frame = CGRectMake(size.width*0.5, size.height*0.2,100,120);
        [ehehButton setBackgroundImage:[UIImage imageNamed:@"tollgate-STONE.png"] forState:UIControlStateNormal];
        [ehehButton setTitle:@"eheh" forState:UIControlStateNormal];
        [ehehButton addTarget:self action:@selector(selectButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:ehehButton];
        
        UIButton *spiderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        spiderButton.frame = CGRectMake(size.width*0.7, size.height*0.2,100,120);
        [spiderButton setBackgroundImage:[UIImage imageNamed:@"tollgate-STONE.png"] forState:UIControlStateNormal];
        [spiderButton setTitle:@"spider" forState:UIControlStateNormal];
        [spiderButton addTarget:self action:@selector(selectButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:spiderButton];
        
        [[[CCDirector sharedDirector] openGLView] addSubview:view];
    }
    
    return self;
}

-(void) selectButtonTouched: (id)sender
{
    [[CCDirector sharedDirector]replaceScene:[MenuScene scene]];
}
-(void)dealloc{
    [view removeFromSuperview];
    [view release];
    [super dealloc];
    CCLOG(@"RoleSelectionScene called dealloc");
    
}
@end
