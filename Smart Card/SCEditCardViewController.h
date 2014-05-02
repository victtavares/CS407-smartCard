//
//  SCEditCardViewController.h
//  Smart Card
//
//  Created by Victor Tavares on 5/2/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCModifyViewController.h"
#import "Card+CRUD.h"

@interface SCEditCardViewController : SCModifyViewController
@property (strong,nonatomic) Card *cardToEdit;

@end
