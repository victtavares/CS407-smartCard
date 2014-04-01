//
//  SCDeckListViewController.h
//  Smart Card
//
//  Created by Victor Tavares on 3/13/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCCoreDataViewController.h"


@interface SCDeckListViewController : SCCoreDataViewController <UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end
