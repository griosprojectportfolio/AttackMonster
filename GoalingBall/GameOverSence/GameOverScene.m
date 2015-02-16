//
//  GameOverScene.m
//  SpriteKitSimpleGame
//
//  Created by Main Account on 9/4/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "GameOverScene.h"
#import "GameScene.h"
 
@implementation GameOverScene

#pragma mark - Initialize view with size

- (id)initWithSize:(CGSize)size won:(BOOL)won {

    if (self = [super initWithSize:size]) {
 
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
 
        NSString * message;
        if (won) {
            message = @"You Won! :)";
        } else {
            message = @"You Lose :[";
        }
 
        // Label
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        label.text = message;
        label.fontSize = 40;
        label.fontColor = [SKColor blackColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:label];
 
        // Action
        [self runAction:
            [SKAction sequence:@[
                [SKAction waitForDuration:3.0],
                [SKAction runBlock:^{
                    // transition style from one scene to another.
                    SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.1];
                    SKScene * myScene = [[GameScene alloc] initWithSize:self.size];
                    [self.view presentScene:myScene transition: reveal];
                }]
            ]]
        ];
 
    }
    return self;
}
 
@end
