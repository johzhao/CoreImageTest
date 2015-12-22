//
//  UIImage+Tint.m
//  CoreImageTest
//
//  Created by John Zhao on 12/22/15.
//  Copyright © 2015 John Zhao. All rights reserved.
//

#import "UIImage+Tint.h"

@implementation UIImage (Tint)

- (UIImage*)imageWithTintColor:(UIColor*)tintColor {
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage*)imageWithGradientTintColor:(UIColor*)tintColor {
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage*)imageWithTintColor:(UIColor*)tintColor blendMode:(CGBlendMode)blendMode {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bound = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    UIRectFill(bound);

    [self drawInRect:bound blendMode:blendMode alpha:1.0f];

    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bound blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }

    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return tintedImage;
}

@end
