//
//  Banana.m
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-23.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Banana.h"


@implementation Banana

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
