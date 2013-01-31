//
//  StageSelectScene.m
//  WormVsBirdsDemo
//
//  Created by Alex Zen on 12-12-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "BigStageSelectScene.h"
#import "SecondStageSelectScene.h"
#import "MenuScene.h"
#import "SimpleAudioEngine.h"

@implementation BigStageSelectScene

+(id)scene{
    CCScene *scene=[CCScene node];
    CCLayer *layer=[BigStageSelectScene node];
    [scene addChild:layer];
    return scene;
}

-(id)init{
    
    if (self=[super init]) {
        
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite *mapBg = [CCSprite spriteWithFile:@"mapBg.png"];
        mapBg.position = ccp(size.width/2,size.height/2);
        [self addChild:mapBg z:-1];//add blackground
        speed = 30.0f;
        
        //添加大关森林
        CCSprite  *forestSprite = [CCSprite spriteWithFile:@"forest.png"];
        //CCSprite  *forestSpriteLock = [CCSprite spriteWithFile:@"forestLock.png"];
        CCMenuItemSprite *forestItem = [CCMenuItemSprite itemFromNormalSprite:forestSprite selectedSprite:nil disabledSprite:nil target:self selector:@selector(btnCall:)];
        forestMenu = [CCMenu menuWithItems:
                      forestItem,nil];
        forestMenu.position=ccp(size.width*0.33,size.height*0.63);
        [self addChild:forestMenu z:1 tag:101];
        
        //添加大关洞穴
        CCSprite  *caveSprite = [CCSprite spriteWithFile:@"cave.png"];
        CCSprite *caveSpriteLock = [CCSprite spriteWithFile:@"caveLock.png"];
        CCMenuItemSprite *caveItem = [CCMenuItemSprite itemFromNormalSprite:caveSprite selectedSprite:nil disabledSprite:caveSpriteLock target:self selector:@selector(btnCall:)];
        caveItem.isEnabled=NO;
        caveMenu = [CCMenu menuWithItems:caveItem, nil];
        caveMenu.position =ccp(size.width*0.36,size.height*0.31);
        [self addChild:caveMenu z:1 tag:103];
       
        //添加大关火山
        CCSprite  *volcanoSprite = [CCSprite spriteWithFile:@"volcano.png"];
        CCSprite *volcanoSpriteLock = [CCSprite spriteWithFile:@"volcaLock.png"];
        CCMenuItemSprite *volcanoItem = [CCMenuItemSprite itemFromNormalSprite:volcanoSprite selectedSprite:nil disabledSprite:volcanoSpriteLock target:self selector:@selector(btnCall:)];
        volcanoItem.isEnabled=NO;
        volcanoMenu = [CCMenu menuWithItems:volcanoItem, nil];
        volcanoMenu.position =ccp(size.width*0.78,size.height*0.52);
        [self addChild:volcanoMenu z:1 tag:102];
        volcanoMenu.isTouchEnabled = NO;
        
        //添加返回按钮
        CCSprite  *backSprite = [CCSprite spriteWithFile:@"back.png"];
        CCMenuItemSprite *backItem = [CCMenuItemSprite itemFromNormalSprite:backSprite  selectedSprite:nil target:self selector:@selector(backCall:)];
        backMenu = [CCMenu menuWithItems:
                        backItem,nil];
        backMenu.position = ccp(backSprite.contentSize.width/2,size.height-backSprite.contentSize.height/2);
        [self addChild:backMenu z:1];
        
        //添加角色选择按钮
        CCSprite  *roleSelectionSprite = [CCSprite spriteWithFile:@"roleSelection.png"];
        CCMenuItemSprite *roleSelectionItem = [CCMenuItemSprite itemFromNormalSprite:roleSelectionSprite  selectedSprite:nil target:self selector:@selector(roleSelectionCall:)];
        CCMenu *roleSelectionMenu = [CCMenu menuWithItems:
                            roleSelectionItem,nil];
        roleSelectionMenu.position = ccp(size.width-roleSelectionSprite.contentSize.width/2,size.height-roleSelectionSprite.contentSize.height/2);
        [self addChild:roleSelectionMenu z:3];

        canTouch=YES;//角色选择能触摸
        
        //addFog
        [self initrFog];
        [self initlFog];
        [self initFog1];
        [self initFog2];
        [self initFog3];
        [self initFog4];
        [self initFog5];
        [self initFog6];
        [self initFog7];
    }
    return self;
}

-(void)initlFog
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *lfog = [CCSprite spriteWithFile:@"fog.png"];
    lfog.position = ccp(size.width-20,60);
    [self addChild:lfog z:2];
    CCMoveTo *moveOut = [CCMoveTo actionWithDuration:(lfog.contentSize.width+20)/speed position:ccp(size.width+lfog.contentSize.width, 60)];
    CCCallFunc* call = [CCCallFuncN actionWithTarget:self selector:@selector(removeFog:)];
    [lfog runAction:[CCSequence actions:moveOut,call, nil]];
}
-(void)initrFog
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *rfog = [CCSprite spriteWithFile:@"fog.png"];
    rfog.position = ccp(rfog.contentSize.width/4,40);
    [self addChild:rfog z:2];
    CCMoveTo *moveOut = [CCMoveTo actionWithDuration:(size.width+5/4*rfog.contentSize.width)/speed position:ccp(size.width+rfog.contentSize.width, 40)];
    CCCallFunc* call = [CCCallFuncN actionWithTarget:self selector:@selector(removeFog:)];
    [rfog runAction:[CCSequence actions:moveOut,call, nil]];
}
-(void) removeFog:(CCNode*)node
{
	// removes the node from its parent
	[node removeFromParentAndCleanup:YES];
}

-(void)initFog1
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *fog1 = [CCSprite spriteWithFile:@"fog.png"];
    fog1.position = ccp(-0.6*fog1.contentSize.width,40);
    [self addChild:fog1 z:2];
    CCMoveTo *moveOut = [CCMoveTo actionWithDuration:(size.width+1.6*fog1.contentSize.width)/speed position:ccp(size.width+fog1.contentSize.width, 40)];
    CCCallFunc* call = [CCCallFuncN actionWithTarget:self selector:@selector(removeFog1:)];
    [fog1 runAction:[CCSequence actions:moveOut,call, nil]];
}
-(void) removeFog1:(CCNode*)node
{
	// removes the node from its parent
	[node removeFromParentAndCleanup:YES];
	[self initFog1];
}
-(void)initFog2
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *fog2 = [CCSprite spriteWithFile:@"fog.png"];
    fog2.position = ccp(-1.8*fog2.contentSize.width,40);
    [self addChild:fog2 z:2];
    CCMoveTo *moveOut = [CCMoveTo actionWithDuration:(size.width+2.8*fog2.contentSize.width)/speed position:ccp(size.width+fog2.contentSize.width, 45)];
    CCCallFunc* call = [CCCallFuncN actionWithTarget:self selector:@selector(removeFog2:)];
    [fog2 runAction:[CCSequence actions:moveOut,call, nil]];
}
-(void) removeFog2:(CCNode*)node
{
	// removes the node from its parent
	[node removeFromParentAndCleanup:YES];
	[self initFog2];
}

-(void)initFog3
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *fog3 = [CCSprite spriteWithFile:@"fog.png"];
    fog3.position = ccp(-2.3*fog3.contentSize.width,40);
    [self addChild:fog3 z:2];
    CCMoveTo *moveOut = [CCMoveTo actionWithDuration:(size.width+3.5*fog3.contentSize.width)/speed position:ccp(size.width+fog3.contentSize.width, 40)];
    CCCallFunc* call = [CCCallFuncN actionWithTarget:self selector:@selector(removeFog3:)];
    [fog3 runAction:[CCSequence actions:moveOut,call, nil]];
}
-(void) removeFog3:(CCNode*)node
{
	// removes the node from its parent
	[node removeFromParentAndCleanup:YES];
	[self initFog3];
}
-(void)initFog4
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *fog4 = [CCSprite spriteWithFile:@"fog.png"];
    fog4.position = ccp(-3.1*fog4.contentSize.width,40);
    [self addChild:fog4 z:2];
    CCMoveTo *moveOut = [CCMoveTo actionWithDuration:(size.width+4.1*fog4.contentSize.width)/speed position:ccp(size.width+fog4.contentSize.width, 45)];
    CCCallFunc* call = [CCCallFuncN actionWithTarget:self selector:@selector(removeFog4:)];
    [fog4 runAction:[CCSequence actions:moveOut,call, nil]];
}
-(void) removeFog4:(CCNode*)node
{
	// removes the node from its parent
	[node removeFromParentAndCleanup:YES];
	[self initFog4];
}
-(void)initFog5
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *fog5 = [CCSprite spriteWithFile:@"fog.png"];
    fog5.position = ccp(-3.7*fog5.contentSize.width,40);
    [self addChild:fog5 z:2];
    CCMoveTo *moveOut = [CCMoveTo actionWithDuration:(size.width+4.7*fog5.contentSize.width)/speed position:ccp(size.width+fog5.contentSize.width, 40)];
    CCCallFunc* call = [CCCallFuncN actionWithTarget:self selector:@selector(removeFog5:)];
    [fog5 runAction:[CCSequence actions:moveOut,call, nil]];
}

-(void) removeFog5:(CCNode*)node
{
	// removes the node from its parent
	[node removeFromParentAndCleanup:YES];
	[self initFog5];
}
-(void)initFog6
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *fog6 = [CCSprite spriteWithFile:@"fog.png"];
    fog6.position = ccp(-4.4*fog6.contentSize.width,40);
    [self addChild:fog6 z:2];
    CCMoveTo *moveOut = [CCMoveTo actionWithDuration:(size.width+5.2*fog6.contentSize.width)/speed position:ccp(size.width+fog6.contentSize.width, 40)];
    CCCallFunc* call = [CCCallFuncN actionWithTarget:self selector:@selector(removeFog6:)];
    [fog6 runAction:[CCSequence actions:moveOut,call, nil]];
}

-(void) removeFog6:(CCNode*)node
{
	// removes the node from its parent
	[node removeFromParentAndCleanup:YES];
	[self initFog6];
}
 
-(void)initFog7
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *fog7 = [CCSprite spriteWithFile:@"fog.png"];
    fog7.position = ccp(-5*fog7.contentSize.width,40);
    [self addChild:fog7 z:2];
    CCMoveTo *moveOut = [CCMoveTo actionWithDuration:(size.width+6*fog7.contentSize.width)/speed position:ccp(size.width+fog7.contentSize.width, 40)];
    CCCallFunc* call = [CCCallFuncN actionWithTarget:self selector:@selector(removeFog7:)];
    [fog7 runAction:[CCSequence actions:moveOut,call, nil]];
}

-(void) removeFog7:(CCNode*)node
{
	// removes the node from its parent
	[node removeFromParentAndCleanup:YES];
	[self initFog7];
}
//roleSlection
-(void)roleSelectionCall:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"monkey.wav"];//add 
   
    if(canTouch)
    {
    canTouch = NO;//角色选择不能触摸
    forestMenu.isTouchEnabled = NO;//设置森林按钮不能点击
    caveMenu.isTouchEnabled = NO;//设置洞穴按钮不能点击
    volcanoMenu.isTouchEnabled = NO;//设置火山按钮不能点击
    backMenu.isTouchEnabled = NO;//设置返回按钮不能点击
        
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCLayerColor *bgcol1=[CCLayerColor layerWithColor:ccc4(0,0,0,155)];//背景色
    [self addChild:bgcol1 z:3 tag:100];
     
    CCSprite * roleBgBg = [CCSprite spriteWithFile:@"roleBgBg.png"];
    roleBgBg.position = ccp(size.width/2,size.height/2);
    [self addChild:roleBgBg z:4];
    //添加四个角色
    CCSprite * roleBg = [CCSprite spriteWithFile:@"roleBg.png"];
    roleBg.position = ccp(roleBg.contentSize.width,roleBg.contentSize.height/2);
    [roleBgBg addChild:roleBg z:1];
        
    CCSprite  *gagaSprite = [CCSprite spriteWithFile:@"gaga.png"];
    CCMenuItemSprite *gagaItem = [CCMenuItemSprite itemFromNormalSprite:gagaSprite  selectedSprite:nil target:self selector:@selector(selectButtonTouched:)];
        
    CCSprite  *ladySprite = [CCSprite spriteWithFile:@"tollgate-STONE.png"];
    CCMenuItemSprite *ladyItem = [CCMenuItemSprite itemFromNormalSprite:ladySprite  selectedSprite:nil target:self selector:@selector(selectButtonTouched:)];
    
    CCSprite  *ehehSprite = [CCSprite spriteWithFile:@"tollgate-STONE.png"];
    CCMenuItemSprite *ehehItem = [CCMenuItemSprite itemFromNormalSprite:ehehSprite
                                                         selectedSprite:nil target:self selector:@selector(selectButtonTouched:)];
    CCSprite  *spiderSprite = [CCSprite spriteWithFile:@"tollgate-STONE.png"];
    CCMenuItemSprite *spiderItem = [CCMenuItemSprite itemFromNormalSprite:spiderSprite
                                                         selectedSprite:nil target:self selector:@selector(selectButtonTouched:)];
    CCMenu *selectionMenu = [CCMenu menuWithItems:
                                 gagaItem,ladyItem,ehehItem,spiderItem, nil];
    [roleBgBg addChild:selectionMenu z:10 tag:200];
    [selectionMenu alignItemsHorizontallyWithPadding:0];
    selectionMenu.position=ccp(size.width/2, size.height/2);
    
    }
    else{
        
    }
}

-(void) selectButtonTouched: (id)sender
{
    [self removeChildByTag:100 cleanup:YES];
    forestMenu.isTouchEnabled = YES;//设置森林按钮能点击
    caveMenu.isTouchEnabled = YES;//设置洞穴按钮能点击
    volcanoMenu.isTouchEnabled = YES;//设置火山按钮能点击
    backMenu.isTouchEnabled = NO;//设置返回按钮能点击
    canTouch = YES;//设置角色按钮能点击
}
//点击btn图标
-(void)btnCall:(CCNode*)node{
    
    CCScaleTo *scaleBy = [CCScaleTo actionWithDuration:0.2 scale:0.6f];
    CCCallFunc *func = [CCCallFunc actionWithTarget:self selector:@selector(skip:)];
    [node runAction:[CCSequence actions:scaleBy,func, nil]];
}

//
-(void)skip:(id)sender{
   
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.2 scene:[SecondStageSelectScene scene]]];
}
//点击返回图标
-(void)backCall:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.2 scene:[MenuScene scene]]];
   
}

-(void)dealloc{
    
    [super dealloc];
    CCLOG(@"StageSelectScene called dealloc");
    
}

@end
