//
//  SCDeckListViewController.m
//  Smart Card
//
//  Created by Victor Tavares on 3/13/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCDeckListViewController.h"
#import "SCDeckViewController.h"
#import "SCAppDelegate.h"
#import "Deck.h"

@interface SCDeckListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *originalTableView;


@end

@implementation SCDeckListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = self.originalTableView;
    // Do any additional setup after loading the view.
}


- (void)awakeFromNib {
    
    SCAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [appDelegate cardDatabaseContext];
    
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Deck"];
    request.predicate = nil;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                              ascending:YES
                                                               selector:@selector(localizedStandardCompare:)]];
    
    
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

#pragma mark - Table view data source


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Deck Cell"];
    
    Deck *deck = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = deck.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%i",[[deck cards]count]];
    
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
