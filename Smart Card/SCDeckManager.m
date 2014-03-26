//
//  SCDeckManager.m
//  Smart Card
//
//  Created by Victor Tavares on 3/25/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCDeckManager.h"
#import "Card.h"

@implementation SCDeckManager

//add validation later
+ (void) addDeckWithName:(NSString *) name intoManagedObjectContext:(NSManagedObjectContext *) context{
    
    Deck *deck = [NSEntityDescription insertNewObjectForEntityForName:@"Deck" inManagedObjectContext:context];
    deck.name = name;
    deck.isFavorite = [NSNumber numberWithBool:YES];
    deck.lat = [NSNumber numberWithFloat:30.30];
    deck.lon = [NSNumber numberWithFloat:40.50];
    deck.unique = [NSNumber numberWithInt:2];
    //deck.cards = [[NSSet alloc] initWithObjects:@"teste", nil];
    
    [SCDeckManager saveChangesWithContext:context];
    
    
    
}


+ (void) saveChangesWithContext:(NSManagedObjectContext *) context {
    //wrapper method for any saves that occur
    NSError *error;
    
    if (![context save:&error])
        NSLog(@"SharedModel: ERROR saving deck: %@", [error localizedDescription]);
}


@end
