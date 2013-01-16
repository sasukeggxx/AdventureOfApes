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
#import "Helpers.h"
#import "CCRoundBy.h"

@implementation GameScene


+(id)scene{
    CCScene *scene=[CCScene node];
    CCLayer *layer=[GameScene node];
    [scene addChild:layer];
    return scene;

}

-(id)init{
    if (self=[super init]) {
        
        self.isTouchEnabled=YES;

        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"image.plist"];
        
        // load physics definitions
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"ground-shape.plist"];
        

        groundLayer=(CCLayer *)[CCBReader nodeGraphFromFile:@"bgLayer.ccb"];
        
        [self addChild:groundLayer z:-3];
        
        [self initTheWorld];//初始化世界
        
        [GameUtil enableBox2dDebugDrawing:debugDraw withWorld:world];//debug 物理世界渲染
        
        groundShape=[CreateGroundInWorld createGroundWithWorld:world];
        
        [self addChild:groundShape z:-2];
        
        [self initThePlayer];
        
        [self scheduleUpdate];
    }

    return self;
}



-(void)initThePlayer{
    player=[PlayerSpriteA addToWorld:world];
    [self addChild:player z:-1];

}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    CGPoint screenCenter=[GameUtil screenCenter];
    BodyNode *guanjian0=(BodyNode *)[groundShape getChildByTag:0];
    BodyNode *guanjian1=(BodyNode *)[groundShape getChildByTag:1];
    NSMutableArray *array=[NSMutableArray arrayWithObjects:guanjian0,guanjian1,nil];
    BodyNode *nearGuanjian=[GameUtil playerNearToBody:array withPlayer:player];
    
    NSArray *twoTouch = [touches allObjects];
    
    //Get both touches
    UITouch *tOne = [twoTouch objectAtIndex:0];
    CGPoint firstTouchLocation =[GameUtil locationFromTouch:tOne];//记录该次触摸点gl位置
    
    if (firstTouchLocation.x>screenCenter.x) {//如果点击右边
    
        
//        rope=[RopeSprite addToWorld:world];
//        [rope setRopeSpritePosition:ccp(nearGuanjian.position.x-rope.contentSize.width/2, nearGuanjian.position.y)];//设置绳子与挂件平行
//        [self addChild:rope z:-1];
//        
//        ropeJointDef.Initialize(nearGuanjian.body, rope.body,nearGuanjian.body->GetWorldCenter());
//        
//        
//        ropeJointDef.maxMotorTorque = 10.0f;
//     
//        ropeJointDef.enableMotor = true;
//        
//        ropeJoint=(b2RevoluteJoint *)nearGuanjian.body->GetWorld()->CreateJoint(&ropeJointDef);
//        
//        ropeJoint->SetMotorSpeed(6.0);
//        
//        
//       
//        playerJointDef.Initialize(rope.body,player.body,rope.body->GetWorldCenter());
//        playerJointDef.enableLimit=true;
//        
//        playerJoint=(b2RevoluteJoint *)rope.body->GetWorld()->CreateJoint(&playerJointDef);
        
           playerJointDef.Initialize(nearGuanjian.body,player.body,nearGuanjian.body->GetWorldCenter());
          
           playerJointDef.maxMotorTorque = 10.0f;
           playerJointDef.enableMotor = true;
           
        
           playerJoint=(b2RevoluteJoint *)nearGuanjian.body->GetWorld()->CreateJoint(&playerJointDef);
        
           playerJoint->SetMotorSpeed(5.0);
        
    }else if (firstTouchLocation.x<screenCenter.x){//如果点击左边则转向
    
        //  ropeJoint->SetMotorSpeed(ropeJoint->GetMotorSpeed() * -1);
          playerJoint->SetMotorSpeed(playerJoint->GetMotorSpeed() * -1);
    
    }
    
    
    
 

}
   

    


-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    CGPoint touchLocation =[GameUtil locationFromTouch:touch];//记录该次触摸位置
    CGPoint screenCenter=[GameUtil screenCenter];
    
    if (touchLocation.x>screenCenter.x) {//如果松开的是右边,玩家离开绳子做抛物线
        
        world->DestroyJoint(playerJoint);
      
//        [self removeChild:rope cleanup:NO];
//        
//        rope=nil;
        
    }
   


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
    
    b2Vec2 lowerLeftCorner = b2Vec2(0, -0.5);//左下角
    b2Vec2 lowerRightCorner = b2Vec2(widthInMeters, -0.5);//右下角
    b2Vec2 upperLeftCorner = b2Vec2(0, heightInMeters+3.0);//左上角
    b2Vec2 upperRightCorner = b2Vec2(widthInMeters, heightInMeters+3.0); //右上角
    
    
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



//处理每帧的物理变化
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
