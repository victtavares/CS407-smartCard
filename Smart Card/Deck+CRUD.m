//
//  Deck+CRUD.m
//  Smart Card
//
//  Created by Victor Tavares on 3/26/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "Deck+CRUD.h"
#import "Card+CRUD.h"
#import "SCConstants.h"
#import "SCAppDelegate+MCO.h"

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


+(void) updateDeckOnWhenUploaded:(Deck *) deck {
    [self saveChangesWithContext:[deck managedObjectContext]];
}

+(NSString *) stringValueForID:(Deck *) deck  {
    return [NSString stringWithFormat:@"%@",deck.objectID];;
}


+ (void) saveDeckFromCloud:(PFObject *) deck withCards: (NSArray *) cards {
    NSLog(@"------- Debugging Download! --------------");
    SCAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate cardDatabaseContext];
    
    
    
    NSString *name = deck[kDeckNameKey];
    NSArray *matches;
    
    //Prevent same Names when upload
    do {
        matches = [self searchDeckWithName:name withContext:context];
        if ([matches count]) {
            name = [name stringByAppendingFormat:@"%i",[matches count]];
        }
    } while ([matches count]);
    
    Deck *decktoAdd = [NSEntityDescription insertNewObjectForEntityForName:@"Deck" inManagedObjectContext:context];
    decktoAdd.name = name;
    decktoAdd.lat = deck[kDeckLatKey];
    decktoAdd.lon = deck[kDeckLonKey];
    decktoAdd.nameInitial = deck[kDeckNameInitialKey];
    
    [self saveChangesWithContext:context];

    for (PFObject *card in cards) {
        NSLog(@"Quantidade:%i",cards.count);
        __block UIImage *imageA = nil;
        __block UIImage *imageB = nil;
        
        //If card has imageA..
        if (card[kCardimageAKey]) {
            
            PFFile *imageAFile = (PFFile *) card[kCardimageAKey];
            [imageAFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                imageA = [UIImage imageWithData:data];
                //Also Image B..
                if (card[kCardimageBKey]) {
                    PFFile *imageBFile = (PFFile *) card[kCardimageBKey];
                    [imageBFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        imageB = [UIImage imageWithData:data];
                        NSLog(@"ImageA: %@ | imageB: %@",imageA,imageB);
                        [Card addCardWithContentA:card[kCardContentAKey] inContentB:card[kCardContentBKey] withImageA:imageA withImageB:imageB ImageinDeck:decktoAdd intoManagedObjectContext:context];
                        
                    }];
                    // But no image B
                } else {
                    NSLog(@"ImageA: %@ | imageB: %@",imageA,imageB);
                    [Card addCardWithContentA:card[kCardContentAKey] inContentB:card[kCardContentBKey] withImageA:imageA withImageB:imageB ImageinDeck:decktoAdd intoManagedObjectContext:context];
                }
            }];
            //If card doesn't has Image A
        } else {
            //but has image B..
            if (card[kCardimageBKey]) {
                PFFile *imageBFile = (PFFile *) card[kCardimageBKey];
                [imageBFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    imageB = [UIImage imageWithData:data];
                    NSLog(@"ImageA: %@ | imageB: %@",imageA,imageB);
                    [Card addCardWithContentA:card[kCardContentAKey] inContentB:card[kCardContentBKey] withImageA:imageA withImageB:imageB ImageinDeck:decktoAdd intoManagedObjectContext:context];
                }];
                //And doesn't have image B
            } else {
                NSLog(@"ImageA: %@ | imageB: %@",imageA,imageB);
                [Card addCardWithContentA:card[kCardContentAKey] inContentB:card[kCardContentBKey] withImageA:imageA withImageB:imageB ImageinDeck:decktoAdd intoManagedObjectContext:context];
            }
        }
        
    }
}







@end
