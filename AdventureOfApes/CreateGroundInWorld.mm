//
//  CreateGroundInWorld.m
//  WormVsBirdsDemo
//
//  Created by Alex Zen on 12-12-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CreateGroundInWorld.h"
#import "CreateGroundPartInWorld.h"
#import "CCBReader.h"

@implementation CreateGroundInWorld

+(id) createGroundWithWorld:(b2World*)world{
    
    return [[[self alloc]initGroundWithWorld:world]autorelease];

}

-(id) initGroundWithWorld:(b2World*)world
{
	if ((self = [super initWithFile:@"image.pvr.ccz" capacity:10]))
	{
       
//        [self addChild:[CreateGroundPartInWorld groundPartInWorld:world //第一块地面
//										  position:ccp(56, 34)
//											  name:@"fightingground"]];
//		
//        [self addChild:[CreateGroundPartInWorld groundPartInWorld:world  //第二块地面
//                                                         position:ccp(232, 34)
//                                                             name:@"fightingground"]];
		

	
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
