//
//  WRControlPad.m
//  Worm
//
//  Created by Jon Como on 4/4/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "WRControlPad.h"

#import "JCMath.h"

@implementation WRControlPad
{
    BOOL isTouched;
}

+(WRControlPad *)padWithTexture:(SKTexture *)texture action:(WRActionHandler)actionHandler
{
    WRControlPad *pad = [[self alloc] initWithTexture:texture];
    pad.action = actionHandler;
    return pad;
}

-(id)initWithTexture:(SKTexture *)texture
{
    if (self = [super initWithTexture:texture]) {
        //init
        self.userInteractionEnabled = YES;
        
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [[touches anyObject] locationInNode:self];
    
    CGPoint center = CGPointZero;
    
    self.angle = [JCMath angleFromPoint:center toPoint:location];
    float distance = [JCMath distanceBetweenPoint:center andPoint:location sorting:NO];
    
    self.intensity = distance / (self.size.width/2);
    if (self.intensity > 1) self.intensity = 1;
    
    self.isPressed = YES;
    
    if (self.action) self.action(self.angle, self.intensity, YES, NO);
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [[touches anyObject] locationInNode:self];
    
    CGPoint center = CGPointZero;
    
    self.angle = [JCMath angleFromPoint:center toPoint:location];
    float distance = [JCMath distanceBetweenPoint:center andPoint:location sorting:NO];
    
    self.intensity = distance / (self.size.width/2);
    if (self.intensity > 1) self.intensity = 1;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{    
    self.isPressed = NO;
    
    if (self.action) self.action(self.angle, self.intensity, NO, YES);
}

-(void)update
{
    if (self.isPressed){
        //Update the action while pressed
        if (self.action) self.action(self.angle, self.intensity, NO, NO);
    }
}

@end
