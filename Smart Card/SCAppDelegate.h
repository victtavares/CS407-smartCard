//
//  SCAppDelegate.h
//  Smart Card
//
//  Created by Victor Tavares on 3/13/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSManagedObjectContext *cardDatabaseContext;

@end
