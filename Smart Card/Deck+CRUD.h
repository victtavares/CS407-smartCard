//
//  Deck+CRUD.h
//  Smart Card
//
//  Created by Victor Tavares on 3/26/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "Deck.h"
#import <Parse/Parse.h>

@interface Deck (CRUD)
+ (BOOL) addDeckWithName:(NSString *) name withLat:(NSNumber *) lat withLon:(NSNumber *) lon 
    intoManagedObjectContext:(NSManagedObjectContext *) context;

+(BOOL) editDeck:(Deck *) deck withName:(NSString *) name  withLat:(NSNumber *) lat withLon:(NSNumber *) lon;

+ (void) deleteDeck:(Deck *)deckToDelete;

+(NSString *) stringValueForID:(Deck *) deck;

+ (void) saveDeckFromCloud:(PFObject *) deck withCards: (NSArray *) cards;

+(void) updateDeckOnWhenUploaded:(Deck *) deck;
@end
