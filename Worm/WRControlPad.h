//
//  WRControlPad.h
//  Worm
//
//  Created by Jon Como on 4/4/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "WRObject.h"

typedef void (^WRActionHandler)(float angle, float intensity, BOOL touchDown, BOOL touchUp);

@interface WRControlPad : WRObject

@property (nonatomic, strong) WRActionHandler action;

@property float angle;
@property float intensity;
@property BOOL isPressed;

+(WRControlPad *)padWithTexture:(SKTexture *)texture action:(WRActionHandler)actionHandler;

@end