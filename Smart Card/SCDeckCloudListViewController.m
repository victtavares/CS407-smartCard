//
//  SCDeckCloudListViewController.m
//  Smart Card
//
//  Created by Victor Tavares on 4/23/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCDeckCloudListViewController.h"
#import "SCShowCardCloudViewController.h"
#import "SCConstants.h"
#import "MBProgressHUD.h"

@interface SCDeckCloudListViewController ()
@property (strong,nonatomic) NSArray *selectedCardArray;
@property (strong,nonatomic) PFObject *selectedDeck;
@end

@implementation SCDeckCloudListViewController

-(id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
        // Customize the table
        
        // The className to query on
        self.parseClassName = kDeckClassName;
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 11;
    }
    return self;
}



- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object
{
    static NSString *cellIdentifier = @"Cell";
    
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell to show todo item with a priority at the bottom
    cell.textLabel.text = object[kDeckNameKey];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Cards: %@",object[KDeckQuantityCardsKey]];
    

    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    //If it's the load more cell...
        if ([indexPath row] > self.objects.count -1 ) {
            return;
        }
    
    //Retrieve the selected Deck
    PFObject *obj = [self.objects objectAtIndex:indexPath.row];
    
    PFQuery *postQuery = [PFQuery queryWithClassName:kCardClassName];
    
    // Follow relationship
    [postQuery whereKey:kCardDeckKey equalTo:obj];
    
    //Adding HUD
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            //removing hud
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            
            self.selectedCardArray = objects;
            self.selectedDeck = obj;
            [self performSegueWithIdentifier:@"goShowCardsCloud" sender:self];
        } else {
           [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }] ;
    
    //Call de second view with the selected Category on iniWithCategory:obj.objectId
    //iPFCollectionSubCategory *frmNewSubCategory = [[iPFCollectionSubCategory alloc] initWithCategory:obj.objectId];
    
    //Call view
    //[self.navigationController pushViewController:frmNewSubCategory animated:YES];
    //[frmNewSubCategory release];
    
    //
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[SCShowCardCloudViewController class]] ) {
        SCShowCardCloudViewController *cvc = (SCShowCardCloudViewController*) segue.destinationViewController;
        cvc.deck = self.selectedDeck;
        cvc.cards = self.selectedCardArray;
        
    }
    
}




@end
