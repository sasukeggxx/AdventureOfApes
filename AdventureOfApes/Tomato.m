//
//  Tomato.m
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-24.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Tomato.h"


@implementation Tomato

-(id)init{
    if (self=[super init]) {
        NSLog(@"load ok");
    }
    return self;
}

-(void)dealloc{
    [super dealloc];
    
}
@end
