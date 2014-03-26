//
//  SCAppDelegate+MCO.h
//  Smart Card
//
//  Created by Victor Tavares on 3/25/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCAppDelegate.h"

@interface SCAppDelegate (MCO)
- (NSManagedObjectContext *)createMainQueueManagedObjectContext;



@end
