//
//  ZWGoodsCollectionViewCell.h
//  设计典范
//
//  Created by Mac on 15/12/22.
//  Copyright © 2015年 zengwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWGoodsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;

@end
