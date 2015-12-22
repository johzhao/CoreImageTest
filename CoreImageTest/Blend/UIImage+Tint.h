//
//  UIImage+Tint.h
//  CoreImageTest
//
//  Created by John Zhao on 12/22/15.
//  Copyright © 2015 John Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tint)

- (UIImage*)imageWithTintColor:(UIColor*)tintColor;

- (UIImage*)imageWithGradientTintColor:(UIColor*)tintColor;

@end
