//
//  WRWorldScene.h
//  Worm
//
//  Created by Jon Como on 4/4/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class WRSphere;
@class WRSpherePod;

@interface WRWorldScene : SKScene

@property (nonatomic, strong) SKSpriteNode *world;

@property (nonatomic, strong) WRSpherePod *player;
@property (nonatomic, weak) WRSphere *sphereControlling;

-(void)sparksAtPosition:(CGPoint)position;

-(void)gameOver;

@end