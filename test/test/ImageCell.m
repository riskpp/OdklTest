//
//  ImageCell.m
//  test
//
//  Created by Ольга Королева on 08.07.14.
//  Copyright (c) 2014 Ольга Королева. All rights reserved.
//

#import "ImageCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ImageCell()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation ImageCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView = imageView;
    }
    return self;
}

- (void)setImageUrlString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"loading %@", url);
    if (!url) {
        NSLog(@"Bad url: %@", urlString);
        return;
    }
    [self.imageView setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (error) {
            NSLog(@"image %@ load error: %@", url, error);
        } else {
            NSLog(@"image loaded: %@", url);
        }
    }];
    
}

- (void)prepareForReuse {
    self.imageView.image = nil;
    [self.imageView cancelCurrentImageLoad];
}

@end
