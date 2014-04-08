//
//  WRInfiniteScroll.m
//  Worm
//
//  Created by Jon Como on 4/6/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "WRInfiniteScroll.h"

@implementation WRInfiniteScroll
{
    CGSize textureSize;
    CGSize sceneSize;
    
    CGPoint center;
}

-(id)initWithImage:(UIImage *)image size:(CGSize)size
{
    //Add sub sprites to fill the screen
    UIImage *largeImage = [self image:image tiledToFitSize:CGSizeMake(size.width * 2, size.height * 2)];
    SKTexture *largeTexture = [SKTexture textureWithImage:largeImage];
    
    if (self = [super initWithTexture:largeTexture]) {
        //init
        textureSize = image.size;
        sceneSize = size;
        
        center = CGPointMake(size.width/2, size.height/2);
        self.position = center;
    }
    
    return self;
}

-(void)setOffset:(CGPoint)offset
{
    _offset = offset;
    
    if (self.position.x < 0) {
        center = CGPointMake(center.x + textureSize.width, center.y);
    }else if (self.position.x > textureSize.width) {
        center = CGPointMake(center.x - textureSize.width, center.y);
    }
    
    if (self.position.y < 0) {
        center = CGPointMake(center.x, center.y + textureSize.height);
    }else if (self.position.y > textureSize.height) {
        center = CGPointMake(center.x, center.y - textureSize.height);
    }
        
    self.position = CGPointMake(center.x + offset.x, center.y + offset.y);
}

-(UIImage *)image:(UIImage *)image tiledToFitSize:(CGSize)size
{
    int numX = ceil(size.width/image.size.width);
    int numY = ceil(size.height/image.size.height);
    
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * numX, image.size.height * numY));
    
    for (int x = 0; x<numX; x++) {
        for (int y = 0; y<numY; y++) {
        CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(x * image.size.width, y * image.size.height, image.size.width, image.size.height), image.CGImage);
        }
    }
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    
    return output;
}

@end
