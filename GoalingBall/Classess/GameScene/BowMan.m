//
//  BowMan.m
//  GoalingBall
//
//  Created by GrepRuby on 30/12/14.
//  Copyright (c) 2014 GrepRuby. All rights reserved.
//

#import "BowMan.h"

@implementation BowMan

- (instancetype)initWithPosition:(CGPoint)position  {

    if(self = [super initWithPosition:position])  {

        self = [self initWithImageNamed:@"bowUser.png"];
        [self addBowManWithPosition:position];
    }
    return self;
}


- (void) addBowManWithPosition:(CGPoint)position {

    self.name = @"BowMan";
    self.position = CGPointMake(position.x, position.y);
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/2];
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = YES;
    self.physicsBody.collisionBitMask = YES;

        // self.physicsBody.categoryBitMask = ArrowCategory;
        // self.physicsBody.contactTestBitMask = monsterCategory;
        // projectile.physicsBody.collisionBitMask = monsterCategory;
        // self.physicsBody.usesPreciseCollisionDetection = YES;
}


@end
