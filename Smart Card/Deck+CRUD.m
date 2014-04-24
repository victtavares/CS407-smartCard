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
        NSLog(@"ERROR:%@", [error localizedDescription]);
}


+(NSArray *) searchDeckWithName:(NSString *) name withContext:(NSManagedObjectContext *) context{

        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Deck"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = [c] %@", name]; // not case sentitive query
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
    
        return matches;
    
}


+ (BOOL) addDeckWithName:(NSString *) name  withLat:(NSNumber *) lat withLon:(NSNumber *) lon 
    intoManagedObjectContext:(NSManagedObjectContext *) context{
    

    if ([name length]) {
        NSArray *matches = [self searchDeckWithName:name withContext:context];
        //if the name chosen is not already picked
        if (![matches count]) {
            Deck *deck = [NSEntityDescription insertNewObjectForEntityForName:@"Deck" inManagedObjectContext:context];
            deck.name = name;
            deck.lat = lat;
            deck.lon = lon;
            deck.nameInitial = [name substringWithRange:NSMakeRange(0, 1)].uppercaseString;
            //deck.cards = [[NSSet alloc] initWithArray:cards];
            
            [self saveChangesWithContext:context];
            return YES;
        }
}
    return NO;
}

+(BOOL) editDeck:(Deck *) deck withName:(NSString *) name  withLat:(NSNumber *) lat withLon:(NSNumber *) lon {
    
    if ([name length]) {
        NSArray *matches = [self searchDeckWithName:name withContext:[deck managedObjectContext]];
        //if the name chosen is not already picked or the name is not modified
        if (![matches count] || [deck.name isEqualToString:name]) {
            deck.name = name;
            deck.lat = lat;
            deck.lon = lon;
            deck.nameInitial = [name substringWithRange:NSMakeRange(0, 1)].uppercaseString;
            
            [self saveChangesWithContext:[deck managedObjectContext]];
            return YES;
        }
    }
    return NO;


}

+(void)deleteDeck:(Deck *)deckToDelete {
    NSManagedObjectContext *context = [deckToDelete managedObjectContext];
	[context deleteObject:deckToDelete];
    [self saveChangesWithContext:context];
    
}

+(NSString *) stringValueForID:(Deck *) deck {
    return [NSString stringWithFormat:@"%@",deck.objectID];;
}






@end
