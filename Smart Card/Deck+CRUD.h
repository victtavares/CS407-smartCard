//
//  Deck+CRUD.h
//  Smart Card
//
//  Created by Victor Tavares on 3/26/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "Deck.h"

@interface Deck (CRUD)
+ (void) addDeckWithName:(NSString *) name withLat:(NSNumber *) lat withLon:(NSNumber *) lon withCards:(NSMutableArray *) cards
    intoManagedObjectContext:(NSManagedObjectContext *) context;
@end
