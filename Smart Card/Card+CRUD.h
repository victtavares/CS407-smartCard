//
//  Card+CRUD.h
//  Smart Card
//
//  Created by Victor Tavares on 3/26/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "Card.h"

@interface Card (CRUD)
+ (BOOL) addCardWithContentA:(NSString *) contentA  inContentB:(NSString *) contentB withImageA:(UIImage *) imageA
                  withImageB:(UIImage *) imageB ImageinDeck:(Deck *) deck intoManagedObjectContext:(NSManagedObjectContext *) context;

+(void)deleteCard:(Card *)cardToDelete;

+(BOOL) editCard:(Card *) card withContentA:(NSString *) contentA withContentB:(NSString *) contentB withImageA:(UIImage *) imageA withImageB:(UIImage *) imageB;
@end
