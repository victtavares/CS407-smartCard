//
//  SCAppDelegate.m
//  Smart Card
//
//  Created by Victor Tavares on 3/13/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCAppDelegate.h"
#import "SCAppDelegate+MCO.h"

@interface SCAppDelegate()
@end

@implementation SCAppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.cardDatabaseContext = [self createMainQueueManagedObjectContext];
    return YES;
}
							
- (void)setCardDatabaseContext:(NSManagedObjectContext *)cardDatabaseContext
{
    _cardDatabaseContext = cardDatabaseContext;
//
//    NSDictionary *userInfo = self.cardDatabaseContext ? @{CardDatabaseAvailabilityContext : self.cardDatabaseContext } : nil;
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:CardDatabaseAvailabilityNotification
//                                                        object:self
//                                                      userInfo:userInfo];
//     NSLog(@"foi no set %@",userInfo);
}


@end
