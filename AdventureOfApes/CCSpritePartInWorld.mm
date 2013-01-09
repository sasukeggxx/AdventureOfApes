//
//  CreateGroundPartInWorld
//  WormVsBirdsDemo
//
//  Created by Alex Zen on 12-12-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CCSpritePartInWorld.h"
#import "GameUtil.h"


@implementation CCSpritePartInWorld


-(id) initWithWorld:(b2World*)world position:(CGPoint)pos name:(NSString *)name
{
	if ((self = [super initWithShape:name inWord:world]))
	{
        // set the body position
        body->SetTransform([GameUtil toMeters:pos], 0.0f);
        
        // make the body static
        body->SetType(b2_staticBody);
	}
	return self;
}

+(id) groundPartInWorld:(b2World*)world position:(CGPoint)pos name:(NSString*)name{

    return [[[self alloc] initWithWorld:world position:pos name:name] autorelease];


}

-(void)dealloc{
    [super dealloc];
    
}
@end
