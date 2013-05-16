//
//  ContactListener.m
//  WormVsBirdsDemo
//
//  Created by Alex Zen on 12-12-28.
//
//

#import "ContactListener.h"
#import "cocos2d.h"
#import "BodyNode.h"
#import "PlayerSpriteA.h"
#import "CCSpritePartInWorld.h"

void ContactListener::BeginContact(b2Contact* contact)
{
	b2Body* bodyA = contact->GetFixtureA()->GetBody();
	b2Body* bodyB = contact->GetFixtureB()->GetBody();
	BodyNode* bodyNodeA = (BodyNode*)bodyA->GetUserData();
	BodyNode* bodyNodeB = (BodyNode*)bodyB->GetUserData();
	
	if (bodyNodeA != NULL && bodyNodeB != NULL)
	{
//		bodyNodeA.color = ccMAGENTA;
//		bodyNodeB.color = ccMAGENTA;
	}
    
    //如过在旋转的时候碰撞墙壁则改变马达方向.
    if ([bodyNodeA isKindOfClass:[PlayerSpriteA class]]&&[bodyNodeB isKindOfClass:[CCSpritePartInWorld class]]) {
       b2JointEdge *jointEdge=bodyNodeA.body->GetJointList();
        if (jointEdge!=NULL) {
            b2RevoluteJoint *revoJoint=(b2RevoluteJoint *)jointEdge->joint;
            revoJoint->SetMotorSpeed(-1*revoJoint->GetMotorSpeed());
        }
      
    }
    
    if ([bodyNodeB isKindOfClass:[PlayerSpriteA class]]&&[bodyNodeA isKindOfClass:[CCSpritePartInWorld class]]) {
        b2JointEdge *jointEdge=bodyNodeB.body->GetJointList();
        if (jointEdge!=NULL) {
            b2RevoluteJoint *revoJoint=(b2RevoluteJoint *)jointEdge->joint;
            revoJoint->SetMotorSpeed(-1*revoJoint->GetMotorSpeed());
        }
        
    }
    
    
}


void ContactListener::EndContact(b2Contact* contact)
{
	b2Body* bodyA = contact->GetFixtureA()->GetBody();
	b2Body* bodyB = contact->GetFixtureB()->GetBody();
	BodyNode* spriteA = (BodyNode*)bodyA->GetUserData();
	BodyNode* spriteB = (BodyNode*)bodyB->GetUserData();
	
	if (spriteA != NULL && spriteB != NULL)
	{
//		spriteA.color = ccWHITE;
//		spriteB.color = ccWHITE;
	}
}