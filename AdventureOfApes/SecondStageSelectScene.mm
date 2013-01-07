//
//  SecondStageSelectScene.m
//  WormVsBirdsDemo
//
//  Created by Alex Zen on 12-12-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "SecondStageSelectScene.h"
#import "MainScene.h"


@implementation SecondStageSelectScene



+(id)scene{
    CCScene *scene=[CCScene node];
    
    CCLayer *starLayer=[SecondStageSelectScene node];
    
    [scene addChild:starLayer];
    
    return scene;
}

-(id)init{
    if (self=[super init]) {
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCLayerColor *bgcol=[CCLayerColor layerWithColor:ccc4(46, 131, 55,255)];//背景色        
        [self addChild:bgcol z:0];
     

        scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];//设置scrollview的可视界面大小，这里设置为全屏
        scrollview.pagingEnabled =  YES;//滚动时，自动滚动到子视图subview的边界
        scrollview.contentSize = CGSizeMake(size.width*1, size.height);//设置scrollview的滚动范围，因为有1个界面，所以是480*1
        scrollview.alwaysBounceHorizontal = YES;//在水平方向滚到头的时候有反弹的效果
        [scrollview setShowsHorizontalScrollIndicator:YES];//隐藏滚动条
        scrollview.delegate=self;//设置代理
        
        
        CCSprite *bgImg=[CCSprite spriteWithFile:@"tollgate-STONE.png"];
        //todo 小关数据需要从配置文件读取
        //以下是临时往scrollview添加上8个小关按钮
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(size.width*0.1, size.height*0.1, bgImg.contentSize.width,bgImg.contentSize.height);
        [button1 setBackgroundImage:[UIImage imageNamed:@"tollgate-STONE.png"] forState:UIControlStateNormal];
        [button1 setImage:[UIImage imageNamed:@"tollgate-1.png"] forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(btnCall:) forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:button1];
        
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame = CGRectMake(size.width*0.3,size.height*0.1,bgImg.contentSize.width, bgImg.contentSize.height);
        [button2 setBackgroundImage:[UIImage imageNamed:@"tollgate-STONE.png"] forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"tollgate-2.png"] forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(btnCall:) forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:button2];
        
        UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        button3.frame = CGRectMake(size.width*0.5, size.height*0.1,bgImg.contentSize.width, bgImg.contentSize.height);
        [button3 setBackgroundImage:[UIImage imageNamed:@"tollgate-STONE.png"] forState:UIControlStateNormal];
        [button3 setImage:[UIImage imageNamed:@"tollgate-3.png"] forState:UIControlStateNormal];
        [button3 addTarget:self action:@selector(btnCall:) forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:button3];
        
        UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        button4.frame = CGRectMake(size.width*0.7, size.height*0.1, bgImg.contentSize.width, bgImg.contentSize.height);
        [button4 setBackgroundImage:[UIImage imageNamed:@"tollgate-STONE.png"] forState:UIControlStateNormal];
        [button4 setImage:[UIImage imageNamed:@"tollgate-4.png"] forState:UIControlStateNormal];
        [button4 addTarget:self action:@selector(btnCall:) forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:button4];
        
        UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
        button5.frame = CGRectMake(size.width*0.1, size.height*0.4, bgImg.contentSize.width, bgImg.contentSize.height);
        [button5 setBackgroundImage:[UIImage imageNamed:@"tollgate-STONE.png"] forState:UIControlStateNormal];
        [button5 setImage:[UIImage imageNamed:@"tollgate-5.png"] forState:UIControlStateNormal];
        [button5 addTarget:self action:@selector(btnCall:) forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:button5];
        
        UIButton *button6 = [UIButton buttonWithType:UIButtonTypeCustom];
        button6.frame = CGRectMake(size.width*0.3,size.height*0.4,bgImg.contentSize.width, bgImg.contentSize.height);
        [button6 setBackgroundImage:[UIImage imageNamed:@"tollgate-STONE.png"] forState:UIControlStateNormal];
        [button6 setImage:[UIImage imageNamed:@"tollgate-6.png"] forState:UIControlStateNormal];
        [button6 addTarget:self action:@selector(btnCall:) forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:button6];
        
      
        
        
        
        
        [[[CCDirector sharedDirector] openGLView] addSubview:scrollview];
        
        //设置分页显示用的小点
        pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(size.width*0.4,size.height*0.8, 100, 50)];
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
    
  
    
}

//点击返回图标
-(void)backCall:(id)sender{
    
    [[CCDirector sharedDirector]replaceScene:[MainScene scene]];
    
    
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
