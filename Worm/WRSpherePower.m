//
//  WRSpherePower.m
//  Worm
//
//  Created by Jon Como on 4/8/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "WRSpherePower.h"

@implementation WRSpherePower

-(id)init
{
    SKTexture *texture = [SKTexture textureWithImageNamed:@"spherePower"];
    
    if (self = [super initWithTexture:texture]) {
        //init
        
    }
    
    return self;
}

@end