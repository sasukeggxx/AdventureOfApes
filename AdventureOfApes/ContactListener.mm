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

void ContactListener::BeginContact(b2Contact* contact)
{
	b2Body* bodyA = contact->GetFixtureA()->GetBody();
	b2Body* bodyB = contact->GetFixtureB()->GetBody();
	BodyNode* bodyNodeA = (BodyNode*)bodyA->GetUserData();
	BodyNode* bodyNodeB = (BodyNode*)bodyB->GetUserData();
	
	if (bodyNodeA != NULL && bodyNodeB != NULL)
	{
		bodyNodeA.color = ccMAGENTA;
		bodyNodeB.color = ccMAGENTA;
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
		spriteA.color = ccWHITE;
		spriteB.color = ccWHITE;
	}
}