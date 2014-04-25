//
//  SCGameViewController.h
//  Smart Card
//
//  Created by Fan on 4/23/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface SCGameViewController : UIViewController

@property(strong, nonatomic) Deck *selectedDeck;

@end
