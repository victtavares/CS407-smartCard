//
//  Deck+CRUD.m
//  Smart Card
//
//  Created by Victor Tavares on 3/26/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "Deck+CRUD.h"

@implementation Deck (CRUD)

+ (void) saveChangesWithContext:(NSManagedObjectContext *) context {
    //wrapper method for any saves that occur
    NSError *error;
    
    if (![context save:&error])
        NSLog(@"SharedModel: ERROR saving deck: %@", [error localizedDescription]);
}


+ (BOOL) addDeckWithName:(NSString *) name  withLat:(NSNumber *) lat withLon:(NSNumber *) lon withCards:(NSMutableArray *) cards
    intoManagedObjectContext:(NSManagedObjectContext *) context{
    

    if ([name length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Deck"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = [c] %@", name]; // not case sentitive query
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (![matches count]) {
            Deck *deck = [NSEntityDescription insertNewObjectForEntityForName:@"Deck" inManagedObjectContext:context];
            deck.name = name;
            deck.lat = lat;
            deck.lon = lon;
            deck.nameInitial = [name substringWithRange:NSMakeRange(0, 1)].uppercaseString;
            deck.cards = [[NSSet alloc] initWithArray:cards];
            
            [self saveChangesWithContext:context];
            return YES;
        }
}
    return NO;
}


    
    

@end
