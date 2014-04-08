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
    
//    float ratio;
//    CGPoint startPoint;
//    float targetAngle;
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
    
    //[self calculateTarget];
}

//-(void)calculateTarget
//{
//    ratio = 0.1;
//    
//    startPoint = self.position;
//    
//    self.targetPoint = self.parentSphere.position;
//    
//    targetAngle = [JCMath angleFromPoint:self.position toPoint:self.targetPoint];
//    
//    self.angle = [JCMath angleFromPoint:startPoint toPoint:self.targetPoint];
//    self.zRotation = self.angle;
//}

-(void)updatePosition
{
    
    float angle = [JCMath angleFromPoint:self.parentSphere.position toPoint:self.position];
    self.position = [JCMath pointFromPoint:self.parentSphere.position pushedBy:46 inDirection:angle];
    
    self.angle = angle + M_PI;
    self.zRotation = self.angle;
}

-(void)update
{
    WRWorldScene *worldScene = (WRWorldScene *)self.scene;
    
    //log parent's position then follow iterate through em
    if (immuneTime > 0){
        immuneTime--;
        self.alpha = (immuneTime/2)%2 + 0.5;
    }else{
        self.isImmune = NO;
    }
    
    //Keep angle within range
    if (self.angle < -M_PI){
        self.angle += 2*M_PI;
    }else if(self.angle > M_PI){
        self.angle -= 2*M_PI;
    }
    
    if (!self.parentSphere){
        //No parent, keep moving forward always
        self.position = [JCMath pointFromPoint:self.position pushedBy:self.power inDirection:self.angle];
        self.zRotation = self.angle;
    }
    
    //Head of a chain
    if (self.childSphere && !self.parentSphere){
        WRSphere *child = self.childSphere;
        
        while (child){
            [child updatePosition];
            
            child = child.childSphere;
        }
    }
    
    //Separation behavior
    if ([self isOnScreen])
    {
        for (WRObject *sphere in worldScene.world.children){
            
            if (ABS(self.position.x - sphere.position.x) > 60 || ABS(self.position.y - sphere.position.y) > 60) continue;
            
            float dist = [JCMath distanceBetweenPoint:self.position andPoint:sphere.position sorting:NO];
            
            if (sphere != self && dist<42)
            {
                float offset = (42 - dist)/1;
                float angle = [JCMath angleFromPoint:self.position toPoint:sphere.position];
                self.position = [JCMath pointFromPoint:self.position pushedBy:offset inDirection:angle + M_PI];
                sphere.position = [JCMath pointFromPoint:sphere.position pushedBy:offset inDirection:angle];
                
                if (sphere == (WRSphere *)worldScene.player && !self.parentSphere && self.childSphere)
                {
                    //game over
                    [worldScene gameOver];
                }
            }
        }
    
        //Attachment behaviour
        if (!self.parentSphere && [self isAttachedToPlayer]){
            
            for (WRObject *object in worldScene.world.children)
            {
                if (object == self) continue;
                
                WRSphere *sphere = (WRSphere *)object;
                if (!sphere.parentSphere && !sphere.isImmune)
                {
                    if (ABS(self.position.x - sphere.position.x) < 50 && ABS(self.position.y - sphere.position.y) < 50)
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