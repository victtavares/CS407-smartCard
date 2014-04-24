//
//  SCConstants.m
//  Smart Card
//
//  Created by Victor Tavares on 4/23/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCConstants.h"

@implementation SCConstants



#pragma mark - PFObject Deck Class
// Field keys
NSString *const kDeckNameKey = @"name";
NSString *const kDeckLatKey = @"lat";
NSString *const kDeckLonKey = @"lon";
NSString *const kDeckNameInitialKey = @"nameInitial";
NSString *const kDeckClassName = @"Deck";

#pragma mark - PFObject Card Class
// Field keys
NSString *const kCardContentAKey = @"contentA";
NSString *const kCardContentBKey = @"contentB";
NSString *const kCardimageAKey = @"imageA";
NSString *const kCardimageBKey = @"imageB";
NSString *const kCardDeckKey = @"Deck";
NSString *const kCardClassName = @"Card";



#pragma mark - UserDefaults
// Field keys
NSString *const kIsUploadingDeckKey = @"deckName";

@end
