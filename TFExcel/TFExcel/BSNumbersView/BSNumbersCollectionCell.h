//
//  BSNumbersCollectionCell.h
//  BSNumbersSample
//
//  Created by    on 16/4/6.
//  Copyright © 2016年 blurryssky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSNumbersCollectionCell : UICollectionViewCell

@property (assign, nonatomic) CGFloat horizontalMargin;

@property (strong, nonatomic) UILabel *label;

@property (strong, nonatomic) UIView *customView;

@property (assign, nonatomic) BOOL separatorHidden;
@property (strong, nonatomic) UIColor *separatorColor;

@end
