//
//  ViewController.m
//  test
//
//  Created by Ольга Королева on 08.07.14.
//  Copyright (c) 2014 Ольга Королева. All rights reserved.
//

#import "ViewController.h"
#import "Client.h"
#import "ImageCell.h"

#define cellIdentifier @"cell"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *urlStrings;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    self.urlStrings = @[];
    
    Client *client = [[Client alloc] init];
    
    [self.indicator startAnimating];
    
    [client getDataWithSuccess:^(NSArray *result) {
        [self.indicator stopAnimating];
        NSLog(@"result: %@", result);
        self.urlStrings = result;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        [self.indicator stopAnimating];
        NSLog(@"Error: %@", error);
        [[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }];
}

#pragma mark - UICollectionViewDataSource/Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.urlStrings.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell setImageUrlString:self.urlStrings[indexPath.row]];
    return cell;
}

@end
