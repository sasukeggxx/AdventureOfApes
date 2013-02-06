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
        CCSprite *bg = [CCSprite spriteWithFile:@"smallstageBg.png"];
        bg.position = ccp(size.width/2, size.height/2);
        [self addChild:bg z:-1];
        
        CCSprite *monkeySprite = [CCSprite spriteWithFile:@"monkeyCup.png"];
        CCSprite *orangutanSprite = [CCSprite spriteWithFile:@"orangutanCup.png"];
        
        //添加返回按钮
        CCSprite  *backSprite = [CCSprite spriteWithFile:@"back.png"];
        CCSprite  *sbackSprite = [CCSprite spriteWithFile:@"sback.png"];
        CCMenuItemSprite *backItem = [CCMenuItemSprite itemFromNormalSprite:backSprite selectedSprite:sbackSprite disabledSprite:nil target:self selector:@selector(backCall:)];
        backItem.isEnabled = YES;
        CCMenu *backMenu = [CCMenu menuWithItems:
                            backItem,nil];
        backMenu.position=ccp(backSprite.contentSize.width/2,size.height-backSprite.contentSize.height/2);
        [bg addChild:backMenu z:0];
        
        scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(backSprite.contentSize.width-10, 0, size.width-backSprite.contentSize.width, size.height)];//设置scrollview的可视界面大小，这里设置为全屏
        scrollview.pagingEnabled =  YES;//滚动时，自动滚动到子视图subview的边界
        scrollview.contentSize = CGSizeMake(size.width*1, size.height);//设置scrollview的滚动范围，因为有1个界面，所以是480*1
        scrollview.alwaysBounceHorizontal = YES;//在水平方向滚到头的时候有反弹的效果
        [scrollview setShowsHorizontalScrollIndicator:YES];//隐藏滚动条
        scrollview.delegate=self;//设置代理
        
        CCSprite *bgImg=[CCSprite spriteWithFile:@"smallstageCupBg.png"];
        
        //todo 小关数据需要从配置文件读取
        
        //以下是临时往scrollview添加上12个小关按钮
        [self runRecipe];//获取stageData.plist
        for(int i=0;i<12;i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImageView *monkeyimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"monkeyCup.png"]];
            UIImageView *monkeyimg2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"monkeyCup.png"]];
            UIImageView *orangutanimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"orangutanCup.png"]];
            switch (i/4) {
   
                 case 0:
                   
                {
                    button.frame = CGRectMake(size.width*0.025+size.width*(i)*0.2,size.height*0.12,bgImg.contentSize.width, bgImg.contentSize.height);
                    monkeyimg.frame =CGRectMake(size.width*0.025+size.width*(i)*0.2, size.height*0.12+bgImg.contentSize.height,monkeySprite.contentSize.width, monkeySprite.contentSize.height);
                    monkeyimg2.frame =CGRectMake(size.width*0.025+size.width*(i)*0.2+monkeySprite.contentSize.width, size.height*0.12+bgImg.contentSize.height, monkeySprite.contentSize.width, monkeySprite.contentSize.height);
                    orangutanimg.frame =CGRectMake(size.width*0.025+size.width*(i)*0.2+2*monkeySprite.contentSize.width, size.height*0.12+bgImg.contentSize.height, orangutanSprite.contentSize.width, orangutanSprite.contentSize.height);
                    
                }
                    break;
                case 1:
                   
                {
                    button.frame = CGRectMake(size.width*0.025+size.width*(i-4)*0.2,size.height*0.4,bgImg.contentSize.width, bgImg.contentSize.height);
                    
                    monkeyimg.frame =CGRectMake(size.width*0.025+size.width*(i-4)*0.2, size.height*0.4+bgImg.contentSize.height, monkeySprite.contentSize.width, monkeySprite.contentSize.height);
                    monkeyimg2.frame =CGRectMake(size.width*0.025+size.width*(i-4)*0.2+monkeySprite.contentSize.width, size.height*0.4+bgImg.contentSize.height, monkeySprite.contentSize.width, monkeySprite.contentSize.height);
                    orangutanimg.frame =CGRectMake(size.width*0.025+size.width*(i-4)*0.2+2*monkeySprite.contentSize.width, size.height*0.4+bgImg.contentSize.height, orangutanSprite.contentSize.width, orangutanSprite.contentSize.height);
                }
                   break;
                case 2:
                    button.frame = CGRectMake(size.width*0.025+size.width*(i-8)*0.2,size.height*0.68,bgImg.contentSize.width, bgImg.contentSize.height);
                    
                    monkeyimg.frame =CGRectMake(size.width*0.025+size.width*(i-8)*0.2, size.height*0.68+bgImg.contentSize.height, monkeySprite.contentSize.width, monkeySprite.contentSize.height);
                    monkeyimg2.frame =CGRectMake(size.width*0.025+size.width*(i-8)*0.2+monkeySprite.contentSize.width, size.height*0.68+bgImg.contentSize.height, monkeySprite.contentSize.width, monkeySprite.contentSize.height);
                    orangutanimg.frame =CGRectMake(size.width*0.025+size.width*(i-8)*0.2+2*monkeySprite.contentSize.width, size.height*0.68+bgImg.contentSize.height, orangutanSprite.contentSize.width, orangutanSprite.contentSize.height);                    break;
                default:
                    break;
            }
            
            //CCLOG(@"%@",[smallState objectAtIndex:i]);
            buttonState = [[smallState objectAtIndex:i] intValue];
            if(buttonState)
            {
                button.adjustsImageWhenDisabled = YES;
                [button setEnabled:NO];
            }
            else
            {
                [button setEnabled:YES];
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"small%d.png",i+1]]forState:UIControlStateNormal];
                
            }
            smallCupNumber = [[smallCup objectAtIndex:i]intValue];
            
            switch (smallCupNumber) {//添加奖杯
                case 1:
                    [scrollview addSubview:monkeyimg];
                    break;
                case 2:
                    [scrollview addSubview:monkeyimg];
                    [scrollview addSubview:monkeyimg2];
                    break;
                case 3:
                    [scrollview addSubview:monkeyimg];
                    [scrollview addSubview:monkeyimg2];
                    [scrollview addSubview:orangutanimg];
                    break;
                default:
                    break;
            }
            
            [button setBackgroundImage:[UIImage imageNamed:@"smallCupstageBgLock.png"] forState:UIControlStateDisabled];
            [button setBackgroundImage:[UIImage imageNamed:@"smallstageCupBg.png"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"ssmallstageCupBg.png"] forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(btnCall:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollview addSubview:button];
            [monkeyimg release];
            [monkeyimg2 release];
            [orangutanimg release];
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

NSString* getActualPath(NSString *file)
{
    NSArray* path = [file componentsSeparatedByString:@"."];
    NSString* actualPath = [[NSBundle mainBundle] pathForResource:[path objectAtIndex:0] ofType:[path objectAtIndex:1]];
    return actualPath;
}

-(CCLayer*) runRecipe{
    NSString *filename = @"stageData.plist";
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:getActualPath(filename)];
    
    [self processMap:dic];
    return self;
}

-(void)processMap:(NSDictionary*)dic
{
    NSArray *nodes = [dic objectForKey:@"bigStages"];
    smallState = [[[NSMutableArray alloc]init]autorelease];//小关是否锁定
    smallCup = [[[NSMutableArray alloc]init]autorelease];//小关奖杯
    NSMutableDictionary *muDic =[[[NSMutableDictionary alloc]initWithCapacity:20]autorelease];
    for(int i=0;i<1;i++)//大关循环
    {
        NSArray *smallItemsData = [nodes objectAtIndex:i];
        for(int j=0;j<[smallItemsData count];j++)//小关循环
        {
            //CCLOG(@"smallItemsData=%d",[smallItemsData count]);
            muDic = [smallItemsData objectAtIndex:j];
           // CCLOG(@"muDic=%@",muDic);
            [smallState addObject:[muDic objectForKey:@"isLock"]];//小关状态
            [smallCup addObject:[muDic objectForKey:@"monkeyCup"]];//小关奖杯
            //CCLOG(@"small=%@",smallCup);
        }
    }
    
    
}
//滚动时换页
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    //NSLog(@"%d",index);
    
    
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
