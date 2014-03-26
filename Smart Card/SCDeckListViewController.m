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
#import "Deck+CRUD.h"

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
    //Getting all the decks,predicate = nil
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Deck"];
    request.predicate = nil;
    //Put the deck in alphabetical Order
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                              ascending:YES
                                                               selector:@selector(localizedStandardCompare:)]];
    
    
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:managedObjectContext
                                                                          sectionNameKeyPath:@"nameInitial"
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
//    if([segue.destinationViewController isKindOfClass:[SCDeckViewController class]] ) {
//        SCDeckViewController *dvc = (SCDeckViewController *) segue.destinationViewController;
//        
//        dvc.context = self.managedObjectContext;
//    }
    
}

- (IBAction)addDeckButtonPressed:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"New Deck" message:@"Enter a name for this Deck"
                                                  delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    if (buttonIndex == 1) {
            NSString *inputText = [[alertView textFieldAtIndex:0] text];
            [Deck addDeckWithName:inputText  withLat:[NSNumber numberWithFloat:30.30] withLon:[NSNumber numberWithFloat:30.30] withCards:cards  intoManagedObjectContext:self.managedObjectContext];
    }
}



@end
