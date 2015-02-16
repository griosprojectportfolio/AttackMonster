//
//  Arrow.m
//  GoalingBall
//
//  Created by GrepRuby on 29/12/14.
//  Copyright (c) 2014 GrepRuby. All rights reserved.
//

#import "Arrow.h"

@implementation Arrow

#pragma mark - View instanciate

- (instancetype)initWithPosition:(CGPoint)position  {

    if(self = [super initWithPosition:position]) {

        positionArrow = position;// CGPointMake(200, 10);

        self = [self initWithImageNamed:@"Arrow"];
        [self addArrowWithPosition:positionArrow];

            // [self addLocationWithAction:position];
        [self configureEmittersWithPosition:position];
    }
    return self;
}

#pragma mark - Add arrow

- (void) addArrowWithPosition:(CGPoint)position1 {

    self.name = @"Arrow";
    self.position = CGPointMake(position1.x, position1.y);
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/2];
    self.physicsBody.dynamic = YES;
    self.physicsBody.categoryBitMask = ArrowCategory;
    self.physicsBody.contactTestBitMask = monsterCategory;
        // projectile.physicsBody.collisionBitMask = monsterCategory;
    self.physicsBody.usesPreciseCollisionDetection = YES;
}

/*- (void)addLocationWithAction:(CGPoint)location {

    CGPoint offset = rwSub(location, self.position);

        // 6 - Get the direction of where to shoot
    CGPoint direction = rwNormalize(offset);

        // 7 - Make it shoot far enough to be guaranteed off screen
    CGPoint shootAmount = rwMult(direction, 1000);

        // 8 - Add the shoot amount to the current position
    CGPoint realDest = rwAdd(shootAmount, self.position);

        // 9 - Create the actions
    float velocity = 480.0/1.0;
    float realMoveDuration = self.size.width / velocity;
    SKAction * actionMove = [SKAction moveTo:realDest duration:realMoveDuration];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    [self runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
} */

#pragma mark - Configure Emitter 

- (void)configureEmittersWithPosition:(CGPoint)position {

    // Emitter
    NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"Fire" ofType:@"sks"];
    SKEmitterNode *smokeTrailLeft = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];

    // Emitter
    SKEmitterNode *smokeTrailRight = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];

    smokeTrailLeft.position = CGPointMake(-10, 5);
    smokeTrailLeft.name = @"spaceDustTrails";
    smokeTrailLeft.zPosition = 0;
    [self addChild:smokeTrailLeft];

    smokeTrailRight.position = CGPointMake(10, 5);
    smokeTrailRight.name = @"spaceDustTrails";
        // smokeTrailRight.xAcceleration = 65;
    smokeTrailRight.zPosition = 0;
    [self addChild:smokeTrailRight];
}

@end
