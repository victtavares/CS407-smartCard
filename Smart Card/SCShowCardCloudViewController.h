//
//  SCShowCardCloudViewController.h
//  Smart Card
//
//  Created by Victor Tavares on 4/24/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCShowCardViewController.h"
#import <Parse/Parse.h>
@interface SCShowCardCloudViewController : SCShowCardViewController
@property (strong,nonatomic) PFObject *deck;
@end
