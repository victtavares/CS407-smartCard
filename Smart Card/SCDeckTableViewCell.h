//
//  SCDeckTableViewCell.h
//  Smart Card
//
//  Created by Victor Tavares on 4/25/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import <Parse/Parse.h>

@interface SCDeckTableViewCell : PFTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameDeckLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityDeckLabel;

@end
