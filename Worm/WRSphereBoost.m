//
//  WRSphereBoost.m
//  Worm
//
//  Created by Jon Como on 4/7/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "WRSphereBoost.h"

@implementation WRSphereBoost

-(id)init
{
    SKTexture *texture = [SKTexture textureWithImageNamed:@"sphereBoost"];
    
    if (self = [super initWithTexture:texture]) {
        //init
        
    }
    
    return self;
}

-(void)attachParent:(WRSphere *)parent
{
    [super attachParent:parent];
    
    //Increase everythings power
    
    parent.power += 0.2;
    
    self.power = parent.power;
    
    WRSphere *child = self.childSphere;
    
    while (child) {
        
        child.power = parent.power;
        
        child = child.childSphere;
    }
}

@end