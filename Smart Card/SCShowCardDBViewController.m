//
//  SCShowCardDBViewController.m
//  Smart Card
//
//  Created by Victor Tavares on 5/2/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCShowCardDBViewController.h"
#import "SCAddCardViewController.h"
#import "SCDeckViewController.h"
#import "SCGameViewController.h"
#import "SCEditCardViewController.h"
#import "Card+CRUD.h"

@interface SCShowCardDBViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *imageView;
@end

@implementation SCShowCardDBViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialSetup];
    // Do any additional setup after loading the view.
}

-(void) initialSetup {
    self.cards = [[[self.deck cards] allObjects]mutableCopy];
    self.title = self.deck.name;
    [self updateCounter];
    
    
    //if the deck is not empty
    if ([self.cards count]) {
        Card *card = [self.cards objectAtIndex:0];
        [self loadContentAndPrepareSideAFromCard:card];
    }
}

-(void) clearCache {
    self.sideAImage = nil;
    self.sideBImage = nil;
    self.sideAtext = nil;
    self.sideBtext = nil;
}

-(void) loadContentAndPrepareSideAFromCard:(Card *) card {
    
    [self clearCache];
    self.sideAtext = card.contentA;
    self.sideBtext = card.contentB;
    self.sideAImage = [UIImage imageWithData:card.imageA];
    self.sideBImage = [UIImage imageWithData:card.imageB];
    [self prepareSideA];


}

#pragma mark - Actions
- (IBAction)previousButtonPressed:(id)sender {
    self.currentCardIndex--;
    Card *card;
    
	if (self.currentCardIndex >= 0) {
    	card = [self.cards objectAtIndex:self.currentCardIndex];
	} else {
    	self.currentCardIndex = [self.cards count] -1;
    	card = [self.cards objectAtIndex:self.currentCardIndex];
	}
    [self updateCounter];
    [self loadContentAndPrepareSideAFromCard:card];
    
}

- (IBAction)nextButtonPressed:(id)sender {
    self.currentCardIndex++;
   Card *card;
    
	if (self.currentCardIndex < [self.cards count]) {
    	card = [self.cards objectAtIndex:self.currentCardIndex];
	} else {
    	self.currentCardIndex = 0;
    	card = [self.cards objectAtIndex:self.currentCardIndex];
	}
    [self updateCounter];
    [self loadContentAndPrepareSideAFromCard:card];
}


- (IBAction)deleteButtonPressed:(id)sender {
    if ([self.cards count]!=0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Delete Card" message:@"Do you want to delete this card?"
                                                      delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        [alert show];
    }
    
}

- (IBAction)editButtonPressed:(id)sender {
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[SCDeckViewController class]] ) {
        SCDeckViewController *dvc = (SCDeckViewController *) segue.destinationViewController;
        dvc.selectedDeck = self.deck;
    }
    
        if([segue.destinationViewController isKindOfClass:[SCGameViewController class]] ) {
            SCGameViewController *dvc = (SCGameViewController *) segue.destinationViewController;
            dvc.selectedDeck = self.deck;
        }
    
    if([segue.destinationViewController isKindOfClass:[SCAddCardViewController class]] ) {
        SCAddCardViewController *avc = (SCAddCardViewController *) segue.destinationViewController;
        avc.selectedDeck = self.deck;
    }
    
    if([segue.destinationViewController isKindOfClass:[SCEditCardViewController class]] ) {
        SCEditCardViewController *avc = (SCEditCardViewController *) segue.destinationViewController;
        avc.cardToEdit = [self.cards objectAtIndex:self.currentCardIndex];
        avc.selectedDeck = self.deck;
    }
    
}

#pragma mark - Alert View delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //If its the empty Deck Alert
    if ([alertView.title isEqualToString:@"Delete Card"] && buttonIndex == 1) {
        Card *cardToDelete = [self.cards objectAtIndex:self.currentCardIndex];
        [Card deleteCard:cardToDelete];
        
    	[self.cards removeObjectAtIndex:self.currentCardIndex];
        
    	//prepare for calling nextButtonPressed
        
    	self.currentCardIndex--;
    	if (self.currentCardIndex<0) {
        	self.currentCardIndex=[self.cards count]-1;
    	}
        
    	if ([self.cards count]==0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"You don't have more cards in this deck!" message:nil
                                                          delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alert show];
            
            [self.navigationController popViewControllerAnimated:YES];
    	} else {
        	[self nextButtonPressed:nil];
    	}
	}
    
    
}


#pragma mark - Modal actions

- (IBAction)saveManageDeck:(UIStoryboardSegue *)segue {
    [self initialSetup];
    
}

- (IBAction)cancelManageDeck:(UIStoryboardSegue *)segue {
    [self initialSetup];
    
}

-(IBAction) AddCard:(UIStoryboardSegue *) segue {
    [self initialSetup];
}

-(IBAction) EditCard:(UIStoryboardSegue *) segue {
    [self initialSetup];
}



-(void) updateCounter {
    self.counterLabel.text = [NSString stringWithFormat:@"%i / %i",self.currentCardIndex +1,self.cards.count];
}


@end
