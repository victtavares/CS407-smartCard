//
//  Card.h
//  Smart Card
//
//  Created by Victor Tavares on 3/25/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Deck;

@interface Card : NSManagedObject

@property (nonatomic, retain) NSData * contentA;
@property (nonatomic, retain) NSString * contentB;
@property (nonatomic, retain) NSData * imageA;
@property (nonatomic, retain) NSString * imageB;
@property (nonatomic, retain) NSNumber * unique;
@property (nonatomic, retain) Deck *deckOwnsMe;

@end
