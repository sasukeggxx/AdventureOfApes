//
//  CreateGroundInWorld.m
//  WormVsBirdsDemo
//
//  Created by Alex Zen on 12-12-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CreateGroundInWorld.h"
#import "CCSpritePartInWorld.h"
#import "CCBReader.h"
#import "GameUtil.h"
#import "GameScene.h"

@implementation CreateGroundInWorld



+(id) createGroundWithWorld:(b2World*)world withStage:(int)stageIndex{
    
    return [[[self alloc]initGroundWithWorld:world withStage:stageIndex]autorelease];

}

-(id) initGroundWithWorld:(b2World*)world withStage:(int)stageIndex
{
	if ((self = [super initWithFile:@"image.pvr.ccz" capacity:10]))
	{
       
        [self addChild:[CCSpritePartInWorld groundPartInWorld:world 
										  position:ccp(8, 297)
											  name:@"fgtWall"]];
		
        [self addChild:[CCSpritePartInWorld groundPartInWorld:world  
                                                         position:ccp(8, 172)
                                                             name:@"fgtWall"]];
        
      
        
        [self addChild:[CCSpritePartInWorld groundPartInWorld:world
                                                         position:ccp(8, 45)
                                                             name:@"fgtWall"]];
       
        
        [self addChild:[CCSpritePartInWorld groundPartInWorld:world
                                                         position:ccp(473, 298)
                                                             name:@"fgtWall2"]];
		
        [self addChild:[CCSpritePartInWorld groundPartInWorld:world
                                                     position:ccp(473, 170)
                                                         name:@"fgtWall2"]];

        [self addChild:[CCSpritePartInWorld groundPartInWorld:world
                                                     position:ccp(473, 45)
                                                         name:@"fgtWall2"]];
        
        

        
        //tree tag区间 0~5
        
        NSString *stageStr=[NSString stringWithFormat:@"GameObjectLayer%d.ccb",stageIndex];
        CCLayer *gameObjectLayer=(CCLayer *)[CCBReader nodeGraphFromFile:stageStr];                                                                                                                                                                                                                                                                                                                                                                                                                                                      
        for (int i=0; i<5; i++) {
             CCSprite *tree=(CCSprite *)[gameObjectLayer getChildByTag:i];
            if (tree!=nil) {
                [self addChild:[CCSpritePartInWorld groundPartInWorld:world
                                                             position:tree.position
                                                                 name:@"fgtTree"] z:0 tag:i];
            }

        }

	
    }
	
	return self;
}







-(void)dealloc{
    [super dealloc];
    
}
@end
