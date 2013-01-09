//
//  GameScene.m
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-8.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "BodyNode.h"
#import "GameUtil.h"
#import "CCBReader.h"
#import "CreateGroundInWorld.h"


@implementation GameScene


+(id)scene{
    CCScene *scene=[CCScene node];
    CCLayer *layer=[GameScene node];
    [scene addChild:layer];
    return scene;

}

-(id)init{
    if (self=[super init]) {
        [self isTouchEnabled];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"image.plist"];
        
        // load physics definitions
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"ground-shape.plist"];
        
        CCLayerColor *bgcol=[CCLayerColor layerWithColor:ccc4(46, 131, 55,255)];//背景色
        [self addChild:bgcol z:-4];
        
        CCLayer *groundLayer=(CCLayer *)[CCBReader nodeGraphFromFile:@"groundLayer.ccb"];
        [self addChild:groundLayer z:-3];
        
        
        [self initTheWorld];
        
        [GameUtil enableBox2dDebugDrawing:debugDraw withWorld:world];
        
        CreateGroundInWorld *groundShape=[CreateGroundInWorld createGroundWithWorld:world];
        
        [self addChild:groundShape z:-2];
        
        [self scheduleUpdate];
    }

    return self;
}


-(void)initTheWorld{
    
    //初始化世界
    b2Vec2 gravity=b2Vec2(0.0,-10);//重力常量
    bool allowBodiesToSleep=true;
    world=new b2World(gravity,allowBodiesToSleep);
    listener=new ContactListener();
    world->SetContactListener(listener);//设置碰撞监听器
    
    
    b2BodyDef containerBodydef;
    b2Body *containerBody=world->CreateBody(&containerBodydef);
    
    // for the ground body we'll need these values
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    float widthInMeters = screenSize.width / PTM_RATIO;//转换成米单位
    float heightInMeters = screenSize.height / PTM_RATIO;
    
    b2Vec2 lowerLeftCorner = b2Vec2(0, 0);//左下角
    b2Vec2 lowerRightCorner = b2Vec2(widthInMeters, 0);//右下角
    b2Vec2 upperLeftCorner = b2Vec2(0, heightInMeters);
    b2Vec2 upperRightCorner = b2Vec2(widthInMeters, heightInMeters);
    
    
    b2PolygonShape screenBoxShape;
    int density = 0;//密度
    
    // bottom
    screenBoxShape.SetAsEdge(lowerLeftCorner, lowerRightCorner);
    b2Fixture *bottom=containerBody->CreateFixture(&screenBoxShape, density);
    
    // top
    screenBoxShape.SetAsEdge(upperLeftCorner, upperRightCorner);
    b2Fixture *top=containerBody->CreateFixture(&screenBoxShape, density);
    
    // left side
    screenBoxShape.SetAsEdge(upperLeftCorner, lowerLeftCorner);
    b2Fixture *leftSide=containerBody->CreateFixture(&screenBoxShape, density);
    
    // right side
    screenBoxShape.SetAsEdge(upperRightCorner, lowerRightCorner);
    b2Fixture *rightSide=containerBody->CreateFixture(&screenBoxShape, density);
    
    // set the collision flags: category and mask
//    b2Filter collisonFilter;
//    collisonFilter.groupIndex = 0;
//    collisonFilter.categoryBits = 0x0010; // category = Wall
//    collisonFilter.maskBits = 0x0001;     // mask = bullet
    
    

    
}

-(void) update:(ccTime)delta{
    
    // The number of iterations influence the accuracy of the physics simulation. With higher values the
	// body's velocity and position are more accurately tracked but at the cost of speed.
	// Usually for games only 1 position iteration is necessary to achieve good results.
	float timeStep = 0.03f;
    float capedDelta=fminf(delta, 0.08f);//安全上限
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	world->Step(capedDelta, velocityIterations, positionIterations);
	
	// for each body, get its assigned sprite and update the sprite's position
	for (b2Body* body = world->GetBodyList(); body != nil; body = body->GetNext())
	{
		BodyNode* sprite = (BodyNode*)body->GetUserData();
		if (sprite != NULL)
		{
			// update the sprite's position to where their physics bodies are
			sprite.position = [GameUtil toPixels:body->GetPosition()];
			float angle = body->GetAngle();
			sprite.rotation = CC_RADIANS_TO_DEGREES(angle) * -1;
		}
	}
    
}




#ifdef DEBUG
-(void) draw
{
	// Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	// Needed states:  GL_VERTEX_ARRAY,
	// Unneeded states: GL_TEXTURE_2D, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	
	world->DrawDebugData();
	
	// restore default GL states
	glEnable(GL_TEXTURE_2D);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
}
#endif


-(void)dealloc{
   
    
    delete listener;
    listener=NULL;
    
    delete debugDraw;
    debugDraw=NULL;
    
    delete world;
    world=NULL;

    [super dealloc];
    CCLOG(@"GameScene called dealloc");
    
}
@end
