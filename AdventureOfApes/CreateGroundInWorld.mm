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

@implementation CreateGroundInWorld

+(id) createGroundWithWorld:(b2World*)world{
    
    return [[[self alloc]initGroundWithWorld:world]autorelease];

}

-(id) initGroundWithWorld:(b2World*)world
{
	if ((self = [super initWithFile:@"image.pvr.ccz" capacity:10]))
	{
       
        [self addChild:[CCSpritePartInWorld groundPartInWorld:world 
										  position:ccp(10, 297)
											  name:@"fgtWall"]];
		
        [self addChild:[CCSpritePartInWorld groundPartInWorld:world  
                                                         position:ccp(10, 172)
                                                             name:@"fgtWall"]];
        
      
        
        [self addChild:[CCSpritePartInWorld groundPartInWorld:world
                                                         position:ccp(10, 45)
                                                             name:@"fgtWall"]];
       
        
        [self addChild:[CCSpritePartInWorld groundPartInWorld:world
                                                         position:ccp(476, 298)
                                                             name:@"fgtWall2"]];
		
        [self addChild:[CCSpritePartInWorld groundPartInWorld:world
                                                     position:ccp(476, 170)
                                                         name:@"fgtWall2"]];

        [self addChild:[CCSpritePartInWorld groundPartInWorld:world
                                                     position:ccp(476, 45)
                                                         name:@"fgtWall2"]];
        
        
//        [self addChild:[CCSpritePartInWorld groundPartInWorld:world
//                                                     position:ccp(122, 231)
//                                                         name:@"fgtTree"] z:0 tag:0];
//        
//        [self addChild:[CCSpritePartInWorld groundPartInWorld:world
//                                                     position:ccp(353, 231)
//                                                         name:@"fgtTree"] z:0 tag:1];
//        
//        [self addChild:[CCSpritePartInWorld groundPartInWorld:world
//                                                     position:ccp(217, 92)
//                                                         name:@"fgtTree"] z:0 tag:2];
        
        CCLayer *gameObjectLayer=(CCLayer *)[CCBReader nodeGraphFromFile:@"GameObjectLayer.ccb"];
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
