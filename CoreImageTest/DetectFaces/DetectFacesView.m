//
//  DetectFacesView.m
//  CoreImageTest
//
//  Created by John Zhao on 12/22/15.
//  Copyright © 2015 John Zhao. All rights reserved.
//

#import "DetectFacesView.h"

@interface DetectFacesView ()

@property (nonatomic, strong) UIImage                   *image;
@property (nonatomic, strong) NSArray                   *facesArray;

@end



@implementation DetectFacesView

- (void)awakeFromNib {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"df_01" withExtension:@"jpg"];
    CIImage *image = [CIImage imageWithContentsOfURL:url];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"df_01" ofType:@"jpg"];
    self.image = [UIImage imageWithContentsOfFile:path];

    CIContext *context = [CIContext contextWithOptions:nil];
    NSDictionary *opts = @{ CIDetectorAccuracy : CIDetectorAccuracyHigh };
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:context
                                              options:opts];

    self.facesArray = [detector featuresInImage:image];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0.0f, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0f, -1.0f);

    CGRect bound = CGRectMake(0.0f, 0.0f, self.image.size.width, self.image.size.height);
    CGContextDrawImage(context, bound, self.image.CGImage);

    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    for (CIFaceFeature *feature in self.facesArray) {
        CGContextStrokeRectWithWidth(context, feature.bounds, 2.0f);
    }
}

@end
