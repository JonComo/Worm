//
//  WRSphere.h
//  Worm
//
//  Created by Jon Como on 4/4/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "WRObject.h"

@interface WRSphere : WRObject

@property CGPoint targetPoint;

@property float angle;
@property float power;

@property (nonatomic, assign) BOOL isImmune;

@property (nonatomic, weak) WRSphere *parentSphere;
@property (nonatomic, weak) WRSphere *childSphere;

-(void)attachParent:(WRSphere *)parent;

-(void)updatePosition;

@end