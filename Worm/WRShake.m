//
//  WRShake.m
//  Worm
//
//  Created by Jon Como on 4/6/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "WRShake.h"

@implementation WRShake
{
    float power;
}

+(WRShake *)manager
{
    static WRShake *manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

-(void)shakeWithIntensity:(float)intensity
{
    power += intensity;
}

-(void)update
{
    power *= 0.8;
    
    float offX = (float)(arc4random()%20) - 10.0f;
    float offY = (float)(arc4random()%20) - 10.0f;
    
    if (power > 0.1)
    {
        self.offset = CGPointMake(offX * power, offY * power);
    }else{
        self.offset = CGPointZero;
    }
}

@end
