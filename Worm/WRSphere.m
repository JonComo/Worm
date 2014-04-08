//
//  WRSphere.m
//  Worm
//
//  Created by Jon Como on 4/4/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "WRSphere.h"

#import "JCMath.h"

#import "WRWorldScene.h"

@implementation WRSphere
{
    NSMutableArray *parentPositions;
    
    int immuneTime;
    
    float ratio;
    CGPoint startPoint;
    float targetAngle;
}

-(id)initWithTexture:(SKTexture *)texture
{
    if (self = [super initWithTexture:texture]) {
        //init
        _angle = 0;
        _power = 0;
        
        parentPositions = [NSMutableArray array];
    }
    
    return self;
}

-(void)setIsImmune:(BOOL)isImmune
{
    _isImmune = isImmune;
    
    self.alpha = isImmune ? 0.5 : 1;
    
    //Set to yes
    if (isImmune){
        immuneTime += 30;
    }
}

-(void)attachParent:(WRSphere *)parent
{
    self.parentSphere = parent;
    
    parent.power = self.power;
    parent.angle = self.angle;
    
    parent.position = [JCMath pointFromPoint:self.position pushedBy:46 inDirection:self.angle];
    
    parent.childSphere = self;
    
    [self calculateTarget];
}

-(void)calculateTarget
{
    startPoint = self.position;
    
    self.targetPoint = self.parentSphere.position;
    
    targetAngle = [JCMath angleFromPoint:startPoint toPoint:self.targetPoint];
}

-(void)updatePosition
{
    ratio += self.power/46;
    
    if (ratio >= 1)
    {
        ratio = 0;
        
        self.position = self.targetPoint;
        
        [self calculateTarget];
    }
    
    self.position = [JCMath pointFromPoint:startPoint pushedBy:46 * ratio inDirection:targetAngle];
    
    self.angle = [JCMath angleFromPoint:startPoint toPoint:self.targetPoint];
    self.zRotation = self.angle;
}

-(void)update
{
    //log parent's position then follow iterate through em
    if (immuneTime > 0){
        immuneTime--;
        self.alpha = (immuneTime/2)%2 + 0.5;
    }else{
        self.isImmune = NO;
    }
    
    if (!self.parentSphere)
    {
        //No parent, keep moving forward always
        self.position = [JCMath pointFromPoint:self.position pushedBy:self.power inDirection:self.angle];
        self.zRotation = self.angle;
    }
    
    if (self.childSphere && !self.parentSphere)
    {
        NSLog(@"Speed: %f", self.power);
        
        WRSphere *child = self.childSphere;
        
        while (child)
        {
            [child updatePosition];
            
            child = child.childSphere;
        }
    }
    
    //Attachment behaviour
    
    if (!self.parentSphere && [self isAttachedToPlayer])
    {
        WRWorldScene *worldScene = (WRWorldScene *)self.scene;
        
        for (WRObject *object in worldScene.world.children)
        {
            if (![object isKindOfClass:[WRSphere class]]) continue;
            WRSphere *sphere = (WRSphere *)object;
            
            if (sphere != self && !sphere.parentSphere && !sphere.isImmune)
            {
                float distance = [JCMath distanceBetweenPoint:self.position andPoint:sphere.position sorting:NO];
                
                if (distance < 46)
                {
                    //Attach
                    [self attachParent:sphere];
                    
                    if ([self isAttachedToPlayer]){
                        worldScene.sphereControlling = sphere;
                        [worldScene sparksAtPosition:self.position];
                        [self runAction:[SKAction playSoundFileNamed:@"attach.wav" waitForCompletion:NO]];
                    }
                    
                    return;
                }
            }
        }
    }
    
    //Keep angle within range
    
    if (self.angle < -M_PI) {
        self.angle += 2*M_PI;
    }else if(self.angle > M_PI){
        self.angle -= 2*M_PI;
    }
}

-(BOOL)isAttachedToPlayer
{
    WRWorldScene *worldScene = (WRWorldScene *)self.scene;
    
    WRSphere *sphere = self;
    
    while (sphere && sphere.childSphere) {
        sphere = sphere.childSphere;
    }
    
    return sphere == (WRSphere *)worldScene.player;
}

@end