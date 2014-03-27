//
//  SCCardViewController.h
//  Smart Card
//
//  Created by Victor Tavares on 3/26/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
@interface SCCardViewController : UIViewController <UIAlertViewDelegate>
@property (strong,nonatomic) Deck *deck;
@end
