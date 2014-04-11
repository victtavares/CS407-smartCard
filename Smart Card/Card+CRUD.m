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


+ (BOOL) addCardWithContentA:(NSString *) contentA  inContentB:(NSString *) contentB withImageA:(UIImage *) imageA
                  withImageB:(UIImage *) imageB ImageinDeck:(Deck *) deck intoManagedObjectContext:(NSManagedObjectContext *) context{
    
    //content != blank or have a image
    if (([contentA length] || imageA) && ([contentB length] || imageB)) {
        Card *card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
        card.contentA = contentA;
        card.contentB = contentB;
        card.deckOwnsMe = deck;
        card.imageA = UIImagePNGRepresentation(imageA);
        card.imageB = UIImagePNGRepresentation(imageB);
            
        [self saveChangesWithContext:context];
        return YES;
        
    }
    return NO;
}

+(void)deleteCard:(Card *)cardToDelete {
    NSManagedObjectContext *context = [cardToDelete managedObjectContext];
	[context deleteObject:cardToDelete];
    [self saveChangesWithContext:context];
}


+(BOOL) editCard:(Card *) card withContentA:(NSString *) contentA withContentB:(NSString *) contentB withImageA:(UIImage *) imageA withImageB:(UIImage *) imageB; {
    if (([contentA length] || imageA) && ([contentB length] || imageB)) {
        card.contentA = contentA;
        card.contentB = contentB;
        card.imageA = UIImagePNGRepresentation(imageA);
        card.imageB = UIImagePNGRepresentation(imageB);
        [self saveChangesWithContext:[card managedObjectContext]];
        return YES;
        
    }
    return NO;
}


@end
