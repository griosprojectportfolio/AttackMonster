//
//  GameObject.h
//  GoalingBall
//
//  Created by GrepRuby on 29/12/14.
//  Copyright (c) 2014 GrepRuby. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

static const uint32_t ArrowCategory     =  0x1 << 0;
static const uint32_t monsterCategory   =  0x1 << 1;

@interface GameObject : SKSpriteNode

- (instancetype)initWithPosition:(CGPoint)position;

@end
