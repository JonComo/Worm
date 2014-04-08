//
//  WRWorldScene.m
//  Worm
//
//  Created by Jon Como on 4/4/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "WRWorldScene.h"

#import "JCMath.h"

#import "WRObject.h"

#import "WRSphere.h"
#import "WRSpherePod.h"
#import "WRSphereBoost.h"

#import "WRControlPad.h"

#import "WRInfiniteScroll.h"

#import "WRShake.h"

#import "Notifications.h"

@implementation WRWorldScene
{
    BOOL isGameOver;
    
    WRInfiniteScroll *stars;
    WRInfiniteScroll *dust;
    
    WRControlPad *padMovement;
    
    SKEmitterNode *particles;
}

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        //init
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.backgroundColor = [UIColor blackColor];
        
        /*
        stars = [[WRInfiniteScroll alloc] initWithImage:[UIImage imageNamed:@"stars"] size:size];
        [self addChild:stars];
        
        dust = [[WRInfiniteScroll alloc] initWithImage:[UIImage imageNamed:@"stars2"] size:size];
        [self addChild:dust]; */
        
        _world = [[SKSpriteNode alloc] init];
        [self addChild:_world];
        
        particles = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"sparks" ofType:@"sks"]];
        
        [self addChild:particles];
        
        particles.particlePosition = CGPointMake(self.size.width/2, self.size.height/2);
        particles.targetNode = _world;
        
        particles.particleBirthRate = 0;
        
        particles.particleZPosition = 1000;
        particles.particleZPositionRange = 100;
        
        _player = [WRSpherePod new];
        [_world addChild:_player];
        
        _sphereControlling = _player;
        
        for (int i = 0; i<50; i++)
        {
            WRSphere *randomSphere = [WRSphereBoost new];
            
            randomSphere.position = CGPointMake((float)(arc4random()%1000) - 500, (float)(arc4random()%1000) - 500);
            [_world addChild:randomSphere];
        }
        
        __weak WRWorldScene *weakSelf = self;
        padMovement = [WRControlPad padWithTexture:[SKTexture textureWithImageNamed:@"padMovement"] action:^(float angle, float intensity, BOOL touchDown, BOOL touchUp) {
            [weakSelf rotateToAngle:angle];
        }];
        
        padMovement.zPosition = 2000;
        //padMovement.position = CGPointMake(size.width/2, size.height/2);
        padMovement.position = CGPointMake(padMovement.size.width/2 + 40, padMovement.size.height/2 + 40);
        //padMovement.xScale = padMovement.yScale = 20;
        //padMovement.alpha = 0;
        [self addChild:padMovement];
    }
    
    return self;
}

-(void)rotateToAngle:(float)angle
{
    if (ABS(self.sphereControlling.angle - angle) > 0.1)
        self.sphereControlling.angle += (float)[JCMath turnAngle:self.sphereControlling.angle*180.0f/M_PI towardsDesiredAngle:angle*180.0f/M_PI]*(M_PI/24);
}

-(void)update:(NSTimeInterval)currentTime
{
    if (isGameOver) return;
    
    [[WRShake manager] update];
    
    [padMovement update];
    
    [self.sphereControlling update];
    
    for (WRObject *object in self.world.children){
        if (object == self.sphereControlling) continue;
        [object update];
    }
}

-(void)sparksAtPosition:(CGPoint)position
{
    particles.particleBirthRate = 100;
    particles.numParticlesToEmit += 65;
    
    [[WRShake manager] shakeWithIntensity:2];
}

-(void)didSimulatePhysics
{
    //Center around worm
    CGPoint shakeOffset = [WRShake manager].offset;
    
    CGPoint center = CGPointMake(self.size.width/2, self.size.height/2);
    self.world.position = CGPointMake(-self.sphereControlling.position.x + center.x + shakeOffset.x, -self.sphereControlling.position.y + center.y + shakeOffset.y);
    
    stars.offset = CGPointMake(self.world.position.x/2, self.world.position.y/2);
    dust.offset = CGPointMake(self.world.position.x/6, self.world.position.y/6);
}

@end
