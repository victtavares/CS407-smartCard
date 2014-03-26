//
//  SCCoreDataViewController.h
//  Smart Card
//
//  Created by Victor Tavares on 3/26/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCCoreDataViewController : UIViewController <NSFetchedResultsControllerDelegate>
// The controller (this class fetches nothing if this is not set).
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

// YOU MUST SET THE TABLEVIEW IN THE SUPERCLASS!!!!
@property (strong, nonatomic) UITableView *tableView;

// Causes the fetchedResultsController to refetch the data.
// You almost certainly never need to call this.
// The NSFetchedResultsController class observes the context
//  (so if the objects in the context change, you do not need to call performFetch
//   since the NSFetchedResultsController will notice and update the table automatically).
// This will also automatically be called if you change the fetchedResultsController @property.
- (void)performFetch;

// Set to YES to get some debugging output in the console.
@property BOOL debug;
@end
