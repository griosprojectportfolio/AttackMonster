//
//  GameScene.m
//  GoalingBall
//
//  Created by GrepRuby on 24/12/14.
//  Copyright (c) 2014 GrepRuby. All rights reserved.
//

#import "GameScene.h"
#import "GameOverScene.h"
#import "Arrow.h"
#import "BowMan.h"
#import "Monster.h"

static inline CGPoint rwAdd(CGPoint a, CGPoint b) {
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint rwSub(CGPoint a, CGPoint b) {
    return CGPointMake(a.x - b.x, a.y - b.y);
}

static inline CGPoint rwMult(CGPoint a, float b) {
    return CGPointMake(a.x * b, a.y * b);
}

static inline float rwLength(CGPoint a) {
    return sqrtf(a.x * a.x + a.y * a.y);
}

    // Makes a vector have a length of 1
static inline CGPoint rwNormalize(CGPoint a) {
    float length = rwLength(a);
    return CGPointMake(a.x / length, a.y / length);
}

@interface GameScene () {

    SKSpriteNode *ball;
    int differenceTime;
}

@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;

@end

@implementation GameScene

#pragma mark - View life cycle

- (id)initWithSize:(CGSize)size {

    if (self = [super initWithSize:size]) {

        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
        self.backgroundColor = [UIColor purpleColor];

        BowMan *bowUser = [[BowMan alloc]initWithPosition:CGPointMake((size.width -  20)/2, 64)];
        [self addChild:bowUser];
    }

    return self;
}


#pragma mark - UITouch Event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self]; // location

    Arrow *arrow;
    CGPoint offset;
    //Arrow allocation
    @autoreleasepool {

        arrow = [[Arrow alloc]initWithPosition:CGPointMake((self.view.frame.size.width - 20)/2, 100)];
        offset = rwSub(location, arrow.position); //Arrow offset
        [self addChild:arrow];
    }

    //Get the direction of where to shoot
    CGPoint direction = rwNormalize(offset);

    //Make it shoot far enough
    CGPoint shootAmount = rwMult(direction, 1000);

    //Add the shoot amount to the current position
    CGPoint realDest = rwAdd(shootAmount, arrow.position);

    //Create the actions
    float velocity = 480.0/1.0;
    float realMoveDuration = self.size.width / velocity;

    SKAction * actionMove = [SKAction moveTo:realDest duration:realMoveDuration];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    [arrow runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
}

#pragma mark - SKScene method to update scene

- (void)update:(NSTimeInterval)currentTime {
    // Called before each frame is rendered

    int minutes = floor(currentTime/60);
    int seconds = round(currentTime - minutes * 60); //convert minute into second

    if (differenceTime != seconds) {

        // Determine where to spawn the monster along the Y axis
        int minX = 20 / 2;
        int maxX = super.frame.size.width - 20 / 2;
        int rangeX = maxX - minX;
        int actualX = (arc4random() % rangeX) + minX;

        //Add monster
        @autoreleasepool {
            Monster *monster = [[Monster alloc]initWithPosition:CGPointMake(actualX, self.view.frame.size.height-10)];
            [self addChild:monster];
        }
    }
    differenceTime = seconds; //Assign second
}

#pragma mark - Remove monster and arrow if they collides

- (void)arrow:(SKSpriteNode *)arrow didCollideWithMonster:(SKSpriteNode *)monster {

    NSLog(@"Hit");
    [arrow removeFromParent];
    [monster removeFromParent];

    if ([monster.name isEqualToString:@"BowMan"] || [arrow.name isEqualToString:@"BowMan"]) {

        [self runAction:[SKAction runBlock: ^(){

            GameOverScene *gameOver = [[GameOverScene alloc]initWithSize:self.size won:NO];
            SKTransition *trnsition = [SKTransition flipVerticalWithDuration:0.2];
            [self.view presentScene:gameOver transition:trnsition];
        }]];
    }
}

#pragma mark - SKPhysicsContact Delegate

- (void)didBeginContact:(SKPhysicsContact *)contact {

    SKPhysicsBody *firstBody, *secondBody;

    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {

        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {

        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }

    if ((firstBody.categoryBitMask & ArrowCategory) != 0 &&  (secondBody.categoryBitMask & monsterCategory) != 0) {
        [self arrow:(SKSpriteNode *) firstBody.node didCollideWithMonster:(SKSpriteNode *) secondBody.node];
    }
}

@end
