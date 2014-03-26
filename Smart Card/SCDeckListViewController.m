//
//  SCDeckListViewController.m
//  Smart Card
//
//  Created by Victor Tavares on 3/13/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCDeckListViewController.h"
#import "CardDatabaseAvaliability.h"
#import "SCDeckViewController.h"
#import "SCAppDelegate.h"

@interface SCDeckListViewController ()

@end

@implementation SCDeckListViewController

- (void)awakeFromNib {
    
    SCAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [appDelegate cardDatabaseContext];
    
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center addObserverForName:CardDatabaseAvailabilityNotification
//                        object:nil
//                         queue:nil
//                    usingBlock:^(NSNotification *note) {
//                        self.managedObjectContext = note.userInfo[CardDatabaseAvailabilityContext];
//                        NSLog(@"recebeu a notification:%@",note.userInfo);
//                    }];
//    
//    NSLog(@"ta no Awake: %@",self.managedObjectContext);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[SCDeckViewController class]] ) {
        SCDeckViewController *dvc = (SCDeckViewController *) segue.destinationViewController;
        
        dvc.context = self.managedObjectContext;
    }
    
}





@end
