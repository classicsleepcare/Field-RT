//
//  FSVerticalTabBar.m
//  iOS-Platform
//
//  Created by Błażej Biesiada on 4/6/12.
//  Copyright (c) 2012 Future Simple. All rights reserved.
//

#import "FSVerticalTabBar.h"
#import "FSVerticalTabBarButton.h"
#import <QuartzCore/QuartzCore.h>


#define DEFAULT_ITEM_HEIGHT 60.0


@implementation FSVerticalTabBar


@synthesize items = _items;
@synthesize backgroundImage = _backgroundImage;
@synthesize selectedImageTintColor = _selectedImageTintColor;
@synthesize selectionIndicatorImage = _selectionIndicatorImage;
@synthesize backgroundGradientColors = _backgroundGradientColors;

- (void)setItems:(NSArray *)items
{
    _items = [items copy];
    [self reloadData];
}


- (void)setSelectionIndicatorImage:(UIImage *)selectionIndicatorImage
{
    
    _selectionIndicatorImage = selectionIndicatorImage;
    // apply changes
    [self reloadData];
    
}


- (void)setSelectedImageTintColor:(UIColor *)selectedImageTintColor
{
    _selectedImageTintColor = selectedImageTintColor;
    // apply changes
    [self reloadData];
}

- (void)setBackgroundGradientColors:(NSArray *)colors
{
    if (![colors isEqualToArray:_backgroundGradientColors]) {
        _backgroundGradientColors = colors;
        
        if (!self.backgroundView) {
            self.backgroundView = [UIView new];
            self.backgroundColor = [UIColor clearColor];
            
        }
        
        NSArray *backgroundSublayers = [self.backgroundView.layer sublayers];
        
        for (id layer in backgroundSublayers) {
            if ([layer isKindOfClass:[CAGradientLayer class]]) {
                CAGradientLayer *gradientLayer = (CAGradientLayer *)layer;
                [gradientLayer removeFromSuperlayer]; // if gradient layer is already added, remove it
            }
        }
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = self.bounds;
        gradientLayer.colors = colors;
        gradientLayer.startPoint = CGPointMake(0.0, 0.5); // start point of gradient drawing (left side)
        gradientLayer.endPoint = CGPointMake(1.0, 0.5);  // end point of gradient drawing (right side)
        
        [self.backgroundView.layer addSublayer:gradientLayer];
        
    }
    
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    
    // apply changes
    if (UIEdgeInsetsEqualToEdgeInsets(backgroundImage.capInsets,UIEdgeInsetsZero)) // aka non resizable image
    {
        self.backgroundView = [UIView new];
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView.backgroundColor = [UIColor colorWithPatternImage:backgroundImage]; // tile background with the image
    }
    else
    {
        self.backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
    }
}


- (void)setSelectedItem:(UITabBarItem *)selectedItem
{
    NSUInteger selectedItemIndex = [self.items indexOfObject:selectedItem];
    if (selectedItemIndex != NSNotFound)
    {
        [self selectRowAtIndexPath:[NSIndexPath indexPathForRow:selectedItemIndex
                                                      inSection:0]
                          animated:YES
                    scrollPosition:UITableViewScrollPositionTop];
    }
}


- (UITabBarItem *)selectedItem
{
    NSIndexPath *selectedRowIndexPath = self.indexPathForSelectedRow;
    if (selectedRowIndexPath != nil)
    {
        return [self.items objectAtIndex:selectedRowIndexPath.row];
    }
    else
    {
        return nil;
    }
}


#pragma mark -
#pragma mark FSVerticalTabBar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self)
    {
        self.dataSource = self;
        self.rowHeight = DEFAULT_ITEM_HEIGHT;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        // set default selection image
        UIImage *defaultSelectionIndicatorImage = [UIImage imageNamed:@"selectionIndicatorImage"];
        defaultSelectionIndicatorImage = [defaultSelectionIndicatorImage resizableImageWithCapInsets:UIEdgeInsetsMake(2, 6, 2, 6)];
        _selectionIndicatorImage = defaultSelectionIndicatorImage;
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
//    UIImage *v = [UIImage imageNamed:@"left_nav_pati"]; // leftslide_rect.png
//    UIImageView *imgView = [[UIImageView alloc]  initWithFrame:self.bounds]; //self.bounds
//    NSLog(@"bounds: %f, %f", self.frame.size.width, self.frame.size.height);
//    imgView.image = v;
//    
//    self.backgroundView = (UIView *) imgView;
    
   

    
    self.backgroundColor = [UIColor grayColor];
    self.scrollEnabled = (self.rowHeight * [self.items count]) > self.bounds.size.height;
}


#pragma mark -
#pragma mark <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *vtbci = @"vtbci";
    FSVerticalTabBarButton *cell = [tableView dequeueReusableCellWithIdentifier:vtbci];
    if (cell == nil)
    {
        cell = [[FSVerticalTabBarButton alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:vtbci];
    }
    
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:self.selectionIndicatorImage];
    
    UITabBarItem *item = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    cell.iconImage = item.image;
    cell.selectedImage=item.selectedImage;
    
    return cell;
}


@end