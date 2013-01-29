//
//  CreateGroundWithCCB.m
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-29.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//
#define PTM_RATIO 32 //单位常量
#import "CreateGroundWithCCB.h"
#import "GameUtil.h"
#import "CCBReader.h"

@implementation CreateGroundWithCCB
+(id) createGroundWithWorld:(b2World*)world withCCBFile:(NSString *)ccbFile{
    
    
    return [[[self alloc] initGroundWithWorld:world withCCBFile:ccbFile]autorelease];
    
}

-(id) initGroundWithWorld:(b2World*)world withCCBFile:(NSString *)ccbFile{
    
    CCLayer *layer=(CCLayer *)[CCBReader nodeGraphFromFile:ccbFile];//最
    
    CCSprite *child;
    
    CCARRAY_FOREACH(layer.children, child){
        
        
        b2BodyDef bodyDef;
        
        bodyDef.type=b2_staticBody;
        
        bodyDef.position=[GameUtil toMeters:child.position];
        
        bodyDef.userData=child;
        
        b2Body *body = world->CreateBody(&bodyDef);
        
        b2PolygonShape staticBox;
        
        float childWidthMeters = child.contentSize.width / PTM_RATIO;
        
        float childHeightMeters = child.contentSize.height / PTM_RATIO;
        
        staticBox.SetAsBox(childWidthMeters*0.5, childHeightMeters*0.5);
        
        b2FixtureDef fixtureDef;
        
        fixtureDef.shape = &staticBox;
        
        fixtureDef.density = 0.3f;
        
        fixtureDef.friction = 0.0f;
        
        fixtureDef.restitution = 0.0f;
        
        body->CreateFixture(&fixtureDef);
        
        [self addChild:child];
        
    }
    
    
    
    return self;
}


@end
