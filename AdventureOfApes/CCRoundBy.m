//
//  CCRoundBy.m
//  LionAndMouse
//
//  Created by Danny on 12-6-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CCRoundBy.h"


@implementation CCRoundBy
@synthesize turn;
@synthesize radius;
@synthesize center;
@synthesize startPos;

-(id) initWithDuration: (ccTime) t turn:(BOOL)aTurn center:(CGPoint)aCenter radius:(CGFloat)aRadius
{
    if (self = [super initWithDuration:t])
    {
        self.turn = aTurn;
        self.center = aCenter;
        self.radius = aRadius;
        
    }
    return self;
}
-(id) initWithDuration: (ccTime) t turn:(BOOL)aTurn startPos:(CGPoint)aStartPos center:(CGPoint)aCenter radius:(CGFloat)aRadius{
    
    if (self = [super initWithDuration:t])
    {
        self.turn = aTurn;
        self.center = aCenter;
        self.radius = aRadius;
        self.startPos= aStartPos;
        
    }
    return self;
}

+(id) actionWithDuration: (ccTime) t turn:(BOOL)aTurn startPos:(CGPoint) aStartPos center:(CGPoint)aCenter radius:(CGFloat)aRadius{

    return [[[self alloc] initWithDuration:t turn:aTurn  startPos:aStartPos center:aCenter radius:aRadius] autorelease];
}

+(id)actionWithDuration: (ccTime) t turn:(BOOL)aTurn center:(CGPoint)aCenter radius:(CGFloat)aRadius
{
    return [[[self alloc] initWithDuration:t turn:aTurn center:aCenter radius:aRadius] autorelease];
}

-(void) startWithTarget:(id)aTarget
{
	[super startWithTarget:aTarget];
    CCNode *target = (CCNode *)aTarget;
    startAngle = target.rotation;
    if (turn)
    {
        target.position = ccpAdd(center, ccp( - radius, 0));
    }
    else
    {
        target.position = ccpAdd(center, ccp(radius, 0));
    }
}

- (void)update:(ccTime)time
{
    CGFloat rotate = startAngle + 360.0f * time;
    if (turn)
    {
        rotate *= -1;
    }
    CCNode *aTarget = (CCNode *)self.target;
    aTarget.rotation = rotate;
    CGFloat fradian = rotate * M_PI / 180.0f;
    CGPoint pos = ccp(center.x + radius * sin(fradian), center.y + radius * cos(fradian));
    aTarget.position = pos;
}

- (CCActionInterval*) reverse
{
    BOOL aTurn = self.turn;
	return [CCRoundBy actionWithDuration:self.duration turn:aTurn center:self.center radius:self.radius];
}
@end
