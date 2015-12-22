//
//  FilterTestViewController.m
//  CoreImageTest
//
//  Created by John Zhao on 12/22/15.
//  Copyright © 2015 John Zhao. All rights reserved.
//

#import "FilterTestViewController.h"

@interface FilterTestViewController ()

@property (nonatomic, weak) IBOutlet UIImageView                *imageView;

@end

@implementation FilterTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CIContext *context = [CIContext contextWithOptions:nil];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"filter" withExtension:@"png"];
    CIImage *image = [CIImage imageWithContentsOfURL:url];
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"];
    [filter setValue:image forKey:kCIInputImageKey];
    [filter setValue:@0.8f forKey:kCIInputIntensityKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGRect extent = [result extent];
    CGImageRef cgImage = [context createCGImage:result fromRect:extent];

    self.imageView.image = [UIImage imageWithCGImage:cgImage];
}

@end
