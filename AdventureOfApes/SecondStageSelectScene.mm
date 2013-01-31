//
//  SecondStageSelectScene.m
//  WormVsBirdsDemo
//
//  Created by Alex Zen on 12-12-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "SecondStageSelectScene.h"
#import "GameScene.h"
#import "BigStageSelectScene.h"
@implementation SecondStageSelectScene

+(id)scene{
    CCScene *scene=[CCScene node];
    
    CCLayer *layer=[SecondStageSelectScene node];
    
    [scene addChild:layer];
    
    return scene;
}

-(id)init{
    if (self=[super init]) {
        CGSize size = [[CCDirector sharedDirector] winSize];
        buttonState = NO;
        CCSprite *bg = [CCSprite spriteWithFile:@"smallBg.png"];
        bg.position = ccp(size.width/2, size.height/2);
        [self addChild:bg z:-1];
        //添加返回按钮
        CCSprite  *backSprite = [CCSprite spriteWithFile:@"smallBack.png"];
        CCSprite  *sbackSprite = [CCSprite spriteWithFile:@"ssmallBack.png"];
        CCMenuItemSprite *backItem = [CCMenuItemSprite itemFromNormalSprite:backSprite selectedSprite:sbackSprite disabledSprite:nil target:self selector:@selector(backCall:)];
        backItem.isEnabled = YES;
        CCMenu *backMenu = [CCMenu menuWithItems:
                            backItem,nil];
        backMenu.position=ccp(backSprite.contentSize.width/2+5,size.height-backSprite.contentSize.height/2-5);
        [bg addChild:backMenu z:0];
        
        scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(backSprite.contentSize.width, 0, size.width-backSprite.contentSize.width, size.height)];//设置scrollview的可视界面大小，这里设置为全屏
        scrollview.pagingEnabled =  YES;//滚动时，自动滚动到子视图subview的边界
        scrollview.contentSize = CGSizeMake(size.width*1, size.height);//设置scrollview的滚动范围，因为有1个界面，所以是480*1
        scrollview.alwaysBounceHorizontal = YES;//在水平方向滚到头的时候有反弹的效果
        [scrollview setShowsHorizontalScrollIndicator:YES];//隐藏滚动条
        scrollview.delegate=self;//设置代理
        
        CCSprite *bgImg=[CCSprite spriteWithFile:@"smallCupBg.png"];
        CCSprite *image= [CCSprite spriteWithFile:@"threeMonkey.png"];
        //todo 小关数据需要从配置文件读取
        
        //以下是临时往scrollview添加上12个小关按钮
        
        for(int i=1;i<5;i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(size.width*0.03+size.width*(i-1)*0.2,size.height*0.12,bgImg.contentSize.width, bgImg.contentSize.height);
            //button.adjustsImageWhenDisabled = YES;
            //[button setEnabled:NO];
            [button setBackgroundImage:[UIImage imageNamed:@"smallCupBgLock.png"] forState:UIControlStateDisabled];
            [button setBackgroundImage:[UIImage imageNamed:@"smallCupBg.png"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"ssmallCupBg.png"] forState:UIControlStateHighlighted];
            //if(buttonState)
            //{
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"small-%d.png",i]]forState:UIControlStateNormal];
            //}
            [button addTarget:self action:@selector(btnCall:) forControlEvents:UIControlEventTouchUpInside];
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"threeMonkey.png"]];
            [scrollview addSubview:imgView];
            imgView.frame =CGRectMake(size.width*0.03+size.width*(i-1)*0.2, size.height*0.12+bgImg.contentSize.height, image.contentSize.width, image.contentSize.height);
            [imgView release];
            [scrollview addSubview:button];
        }
        for(int i=5;i<9;i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(size.width*0.03+size.width*(i-5)*0.2,size.height*0.4,bgImg.contentSize.width, bgImg.contentSize.height);
            button.adjustsImageWhenDisabled = YES;
            [button setEnabled:NO];
            [button setBackgroundImage:[UIImage imageNamed:@"smallCupBgLock.png"] forState:UIControlStateDisabled];
            [button setBackgroundImage:[UIImage imageNamed:@"smallCupBg.png"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"ssmallCupBg.png"] forState:UIControlStateHighlighted];
            if(buttonState)
            {
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"small-%d.png",i]]forState:UIControlStateNormal];
            }
               [button addTarget:self action:@selector(btnCall:) forControlEvents:UIControlEventTouchUpInside];
            
               
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"threeMonkey.png"]];
            [scrollview addSubview:imgView];
            imgView.frame =CGRectMake(size.width*0.03+size.width*(i-5)*0.2, size.height*0.4+bgImg.contentSize.height, image.contentSize.width, image.contentSize.height);
            [imgView release];

            [scrollview addSubview:button];
        }
        
        for(int i=9;i<=12;i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(size.width*0.03+size.width*(i-9)*0.2,size.height*0.68,bgImg.contentSize.width, bgImg.contentSize.height);
            button.adjustsImageWhenDisabled = YES;
            [button setEnabled:NO];
            [button setBackgroundImage:[UIImage imageNamed:@"smallCupBgLock.png"] forState:UIControlStateDisabled];            [button setBackgroundImage:[UIImage imageNamed:@"smallCupBg.png"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"ssmallCupBg.png"] forState:UIControlStateHighlighted];
            if(buttonState)
            {
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"small-%d.png",i]]forState:UIControlStateNormal];
            }
            
            [button addTarget:self action:@selector(btnCall:) forControlEvents:UIControlEventTouchUpInside];
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"threeMonkey.png"]];
            [scrollview addSubview:imgView];
            imgView.frame =CGRectMake(size.width*0.03+size.width*(i-9)*0.2, size.height*0.68+bgImg.contentSize.height, image.contentSize.width, image.contentSize.height);
            [imgView release];
            [scrollview addSubview:button];
            
        }
        
        [[[CCDirector sharedDirector] openGLView] addSubview:scrollview];
        
        //设置分页显示用的小点
        pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(size.width*0.4,size.height*0.87, 100, 50)];
        //pagecontrol.hidesForSinglePage = YES;
        //pagecontrol.userInteractionEnabled = NO;
        pagecontrol.numberOfPages = 1;//1页
        
        [[[CCDirector sharedDirector] openGLView] addSubview:pagecontrol];
        
        
    }
    return self;
}

//滚动时换页
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    //NSLog(@"%d",index);
    pagecontrol.currentPage = index;
    
    
}

//点击btn图标
-(void)btnCall:(id)sender{
    
   [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.2 scene:[GameScene scene]]];
    
}

//点击返回图标
-(void)backCall:(id)sender{
   
        [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.2 scene:[BigStageSelectScene scene]]];
        
    }
    



-(void)dealloc{
    [scrollview removeFromSuperview];
    [scrollview release];
    [pagecontrol removeFromSuperview];
    [pagecontrol release];
    [super dealloc];
    CCLOG(@"SecondStageSelectScene called dealloc");
    
}

@end
