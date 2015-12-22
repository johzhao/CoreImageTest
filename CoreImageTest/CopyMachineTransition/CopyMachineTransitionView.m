//
//  CopyMachineTransitionView.m
//  CoreImageTest
//
//  Created by John Zhao on 12/22/15.
//  Copyright © 2015 John Zhao. All rights reserved.
//

#import "CopyMachineTransitionView.h"

@interface CopyMachineTransitionView ()

@property (nonatomic, strong) CIImage                           *sourceImage;
@property (nonatomic, strong) CIImage                           *targetImage;
@property (nonatomic, assign) NSTimeInterval                    base;
@property (nonatomic, assign) CGFloat                           width;
@property (nonatomic, assign) CGFloat                           height;
@property (nonatomic, strong) CIContext                         *context;
@property (nonatomic, strong) CIFilter                          *transition;

@end



@implementation CopyMachineTransitionView

- (void)awakeFromNib {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"CMT_01" withExtension:@"jpg"];
    self.sourceImage = [CIImage imageWithContentsOfURL:url];

    url = [[NSBundle mainBundle] URLForResource:@"CMT_02" withExtension:@"jpg"];
    self.targetImage = [CIImage imageWithContentsOfURL:url];

    self.width = 460.0f;
    self.height = 340.0f;
    self.base = [NSDate timeIntervalSinceReferenceDate];

    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0/30.0
                                                      target:self
                                                    selector:@selector(timerFired:)
                                                    userInfo:nil
                                                     repeats:YES];

    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)setupTransition {
    CIVector *extent = [CIVector vectorWithX:0.0f Y:0.0f Z:self.width W:self.height];
    self.transition = [CIFilter filterWithName:@"CICopyMachineTransition"];
    [self.transition setValue:extent forKey:kCIInputExtentKey];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // FIXME: The result image was upside down.
    if (self.context == nil) {
        CGContextRef context = UIGraphicsGetCurrentContext();
//        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
//        CGContextTranslateCTM(context, 0.0f, self.bounds.size.height);
//        CGContextScaleCTM(context, 1.0f, -1.0f);
        self.context = [CIContext contextWithCGContext:context options:nil];
    }

    if (self.transition == nil) {
        [self setupTransition];
    }

    CGRect cg = CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), CGRectGetHeight(rect));
    CGFloat t = 0.4f * ([NSDate timeIntervalSinceReferenceDate] - self.base);
    [self.context drawImage:[self imageForTransition:t+0.1f] inRect:cg fromRect:cg];
}

- (void)timerFired:(NSTimer*)timer {
    [self setNeedsDisplay];
}

- (CIImage*)imageForTransition:(CGFloat)t {
    if (fmod(t, 2.0) < 1.0f) {
        [self.transition setValue:self.sourceImage forKey:kCIInputImageKey];
        [self.transition setValue:self.targetImage forKey:kCIInputTargetImageKey];
    }
    else {
        [self.transition setValue:self.targetImage forKey:kCIInputImageKey];
        [self.transition setValue:self.sourceImage forKey:kCIInputTargetImageKey];
    }

    [self.transition setValue:@(0.5 * (1 - cos(fmodf(t, 1.0f) * M_PI))) forKey:kCIInputTimeKey];

    CIFilter *crop = [CIFilter filterWithName:@"CICrop"
                                keysAndValues:kCIInputImageKey, [self.transition valueForKey:kCIOutputImageKey], @"inputRectangle", [CIVector vectorWithX:0.0f Y:0.0f Z:self.width W:self.height], nil];

    return [crop valueForKey:kCIOutputImageKey];
}

@end
