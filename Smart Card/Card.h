//
//  Card.h
//  Smart Card
//
//  Created by Victor Tavares on 4/23/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Deck;

@interface Card : NSManagedObject

@property (nonatomic, retain) NSString * contentA;
@property (nonatomic, retain) NSString * contentB;
@property (nonatomic, retain) NSData * imageA;
@property (nonatomic, retain) NSData * imageB;
@property (nonatomic, retain) Deck *deckOwnsMe;

@end
