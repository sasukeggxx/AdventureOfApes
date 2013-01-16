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
        
        
        [self addChild:[CCSpritePartInWorld groundPartInWorld:world
                                                     position:ccp(159, 204)
                                                         name:@"fgtTree"] z:0 tag:0];
        
        [self addChild:[CCSpritePartInWorld groundPartInWorld:world
                                                     position:ccp(295, 111)
                                                         name:@"fgtTree"] z:0 tag:1];
        
        [self addChild:[CCSpritePartInWorld groundPartInWorld:world
                                                     position:ccp(382, 238)
                                                         name:@"fgtTree"] z:0 tag:2];
        
        


	
    }
	
	return self;
}





+(id) createGroundWithWorld:(b2World*)world withCCBFile:(NSString *)ccbFile{
    
    
    return [[self alloc] initGroundWithWorld:world withCCBFile:ccbFile];
    
}

-(id) initGroundWithWorld:(b2World*)world withCCBFile:(NSString *)ccbFile{
    CCLayer *ground=(CCLayer *)[CCBReader nodeGraphFromFile:@"backGround.ccb"];//最
    CCArray *array=ground.children;
    for (int i=0; i<array.count; i++) {
        CCSprite *sprite=[array objectAtIndex:i];

        
    }
    
    
    
    return self;
}



-(void)dealloc{
    [super dealloc];
    
}
@end
