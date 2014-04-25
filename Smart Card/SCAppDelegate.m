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
    
    #define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
    
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x067AB5)];
    return YES;
    
    

}
							
- (void)setCardDatabaseContext:(NSManagedObjectContext *)cardDatabaseContext
{
    _cardDatabaseContext = cardDatabaseContext;
}


@end
