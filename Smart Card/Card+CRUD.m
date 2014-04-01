//
//  Card+CRUD.m
//  Smart Card
//
//  Created by Victor Tavares on 3/26/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "Card+CRUD.h"

@implementation Card (CRUD)

+ (void) saveChangesWithContext:(NSManagedObjectContext *) context {
    //wrapper method for any saves that occur
    NSError *error;
    
    if (![context save:&error])
        NSLog(@"SharedModel: ERROR saving deck: %@", [error localizedDescription]);
}


+ (BOOL) addCardWithContentA:(NSString *) contentA  inContentB:(NSString *) contentB inDeck:(Deck *) deck
intoManagedObjectContext:(NSManagedObjectContext *) context{
    
    //content != blank
    if ([contentA length] && [contentB length]) {
        Card *card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
        card.contentA = contentA;
        card.contentB = contentB;
        card.deckOwnsMe = deck;
            
        [self saveChangesWithContext:context];
        return YES;
        
    }
    return NO;
}


@end
