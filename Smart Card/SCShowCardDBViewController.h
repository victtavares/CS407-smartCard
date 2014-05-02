//
//  SCShowCardDBViewController.h
//  Smart Card
//
//  Created by Victor Tavares on 5/2/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCShowCardViewController.h"
#import "Deck+CRUD.h"

@interface SCShowCardDBViewController : SCShowCardViewController
@property (strong,nonatomic) Deck *deck;
@end
