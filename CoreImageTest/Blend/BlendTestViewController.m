//
//  BlendTestViewController.m
//  CoreImageTest
//
//  Created by John Zhao on 12/22/15.
//  Copyright © 2015 John Zhao. All rights reserved.
//

#import "BlendTestViewController.h"
#import "UIImage+Tint.h"

@interface BlendTestViewController ()

@property (nonatomic, weak) IBOutlet UIImageView                *imageView;

@end



@implementation BlendTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *image = [UIImage imageNamed:@"blend"];
    image = [image imageWithGradientTintColor:[UIColor orangeColor]];
    self.imageView.image = image;
}

@end
