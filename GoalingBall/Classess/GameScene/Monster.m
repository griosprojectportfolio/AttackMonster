//
//  Monster.m
//  GoalingBall
//
//  Created by GrepRuby on 29/12/14.
//  Copyright (c) 2014 GrepRuby. All rights reserved.
//

#import "Monster.h"

@implementation Monster


- (instancetype)initWithPosition:(CGPoint)position {

    if(self = [super initWithPosition:position]) {

        self = [self initWithImageNamed:@"monster"];

        [self addMonsterWithPosition:position];
    }
    return self;
}

#pragma mark- Add monster

- (void)addMonsterWithPosition:(CGPoint)position {

    // Create sprite
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.dynamic = YES;
    self.physicsBody.categoryBitMask =  monsterCategory;
    self.physicsBody.contactTestBitMask =  ArrowCategory;

    // and along a random position along the Y axis as calculated above
    self.position = CGPointMake(position.x, position.y);

    // Determine speed of the monster
    int minDuration = 2.0;
    int maxDuration = 6.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;

    // Create the actions
    SKAction * actionMove = [SKAction moveTo:CGPointMake(position.x, -40/2) duration:actualDuration];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    [self runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
}

@end
