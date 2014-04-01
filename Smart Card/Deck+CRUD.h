//
//  Deck+CRUD.h
//  Smart Card
//
//  Created by Victor Tavares on 3/26/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "Deck.h"

@interface Deck (CRUD)
+ (BOOL) addDeckWithName:(NSString *) name withLat:(NSNumber *) lat withLon:(NSNumber *) lon 
    intoManagedObjectContext:(NSManagedObjectContext *) context;

+(BOOL) editDeck:(Deck *) deck withName:(NSString *) name  withLat:(NSNumber *) lat withLon:(NSNumber *) lon;
@end
