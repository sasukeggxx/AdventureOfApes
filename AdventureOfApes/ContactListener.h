//
//  ContactListener.h
//  WormVsBirdsDemo
//
//  Created by Alex Zen on 12-12-28.
//
//


#import "Box2D.h"

class ContactListener :public b2ContactListener
{
    private:
        void BeginContact(b2Contact* contact);
        void EndContact(b2Contact* contact);
};
