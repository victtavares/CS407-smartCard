//
//  SCDeckManager.h
//  Smart Card
//
//  Created by Victor Tavares on 3/25/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface SCDeckManager : NSObject

+ (void) addDeckWithName:(NSString *) name intoManagedObjectContext:(NSManagedObjectContext *) context;

@end
