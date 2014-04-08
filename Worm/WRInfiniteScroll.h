//
//  WRInfiniteScroll.h
//  Worm
//
//  Created by Jon Como on 4/6/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface WRInfiniteScroll : SKSpriteNode

@property (nonatomic, assign) CGPoint offset;

-(id)initWithImage:(UIImage *)image size:(CGSize)size;

@end