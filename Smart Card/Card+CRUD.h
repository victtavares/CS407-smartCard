//
//  Card+CRUD.h
//  Smart Card
//
//  Created by Victor Tavares on 3/26/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "Card.h"

@interface Card (CRUD)
+ (BOOL) addCardWithContentA:(NSString *) contentA  inContentB:(NSString *) contentB inDeck:(Deck *) deck
    intoManagedObjectContext:(NSManagedObjectContext *) context;
@end
