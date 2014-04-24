//
//  SCAppDelegate.m
//  Smart Card
//
//  Created by Victor Tavares on 3/13/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCAppDelegate.h"
#import "SCAppDelegate+MCO.h"
#import <Parse/Parse.h>
#import "SCConstants.h"

@interface SCAppDelegate()
@end

@implementation SCAppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"klHYv8krLzm1qq5bMKl7Je4ul1uZa1vSlfoy2Cm2"
                  clientKey:@"ie8s9fmqsJ8GPDuPfYHCvvXj8BBe8zKgpdHwFbVC"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    self.cardDatabaseContext = [self createMainQueueManagedObjectContext];
    return YES;

}
							
- (void)setCardDatabaseContext:(NSManagedObjectContext *)cardDatabaseContext
{
    _cardDatabaseContext = cardDatabaseContext;
}


@end
