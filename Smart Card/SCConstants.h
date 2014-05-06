//
//  SCConstants.h
//  Smart Card
//
//  Created by Victor Tavares on 4/23/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCConstants : NSObject


#pragma mark - PFObject Deck Class
// Field keys
extern NSString *const kDeckNameKey;
extern NSString *const kDeckLatKey;
extern NSString *const kDeckLonKey;
extern NSString *const kDeckNameInitialKey;
extern NSString *const KDeckQuantityCardsKey;
extern NSString *const kDeckClassName;
extern NSString *const kPhoneIdentifier;



#pragma mark - PFObject Card Class
// Field keys
extern NSString *const kCardContentAKey;
extern NSString *const kCardContentBKey;
extern NSString *const kCardimageAKey;
extern NSString *const kCardimageBKey;
extern NSString *const kCardDeckKey;
extern NSString *const kCardClassName;



@end
