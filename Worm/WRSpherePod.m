//
//  WRSpherePod.m
//  Worm
//
//  Created by Jon Como on 4/7/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "WRSpherePod.h"

#import "WRWorldScene.h"

#import "JCMath.h"

@implementation WRSpherePod

-(id)init
{
    SKTexture *texture = [SKTexture textureWithImageNamed:@"spherePod"];
    
    if (self = [super initWithTexture:texture]) {
        //init
        self.power = 1;
    }
    
    return self;
}

@end