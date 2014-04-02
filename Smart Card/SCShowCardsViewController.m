//
//  SCShowCardsViewController.m
//  Smart Card
//
//  Created by Victor Tavares on 3/26/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCShowCardsViewController.h"
#import "Card+CRUD.h"
#import "SCDeckViewController.h"


@interface SCShowCardsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong,nonatomic) NSMutableArray *cards;
@property (nonatomic) int currentCardIndex;
@property (nonatomic) BOOL displaySideA;
@end

@implementation SCShowCardsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initialSetup];
    // Do any additional setup after loading the view.
}


-(void) initialSetup {
    self.title = self.deck.name;
    self.cards = [[[self.deck cards] allObjects]mutableCopy];
    Card *card = [self.cards objectAtIndex:0];
    self.contentTextView.text = card.contentA;
    self.displaySideA = TRUE;
    
}

#pragma mark - Actions
- (IBAction)nextButtonPressed:(id)sender {
	self.currentCardIndex++;
    Card *card;
    
	if (self.currentCardIndex < [self.cards count]) {
    	card = [self.cards objectAtIndex:self.currentCardIndex];
    	self.contentTextView.text = card.contentA;
	} else {
    	self.currentCardIndex = 0;
    	card = [self.cards objectAtIndex:self.currentCardIndex];
    	self.contentTextView.text = card.contentA;
	}
	self.displaySideA = YES;
}


- (IBAction)previousButtonPressed:(id)sender {
    self.currentCardIndex--;
    Card *card;
	if (self.currentCardIndex >= 0) {
    	card = [self.cards objectAtIndex:self.currentCardIndex];
    	self.contentTextView.text = card.contentA;
        
	} else {
    	self.currentCardIndex = [_deck.cards count]-1;
    	card = [self.cards objectAtIndex:self.currentCardIndex];
    	self.contentTextView.text = card.contentA;
	}
    
	self.displaySideA = YES;
}

- (IBAction)flipButtonPressed:(id)sender {
    Card *card = [self.cards objectAtIndex:self.currentCardIndex];
    
	if (self.displaySideA) {
    	self.contentTextView.text = card.contentB;
    	self.displaySideA = NO;
	} else {
    	self.contentTextView.text = card.contentA;
    	self.displaySideA = YES;
	}
}



- (IBAction)deleteButtonPressed:(id)sender {
	if ([self.cards count]!=0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Delete Card" message:@"Do you want to delete this card?"
                                                      delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        [alert show];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[SCDeckViewController class]] ) {
        SCDeckViewController *dvc = (SCDeckViewController *) segue.destinationViewController;
        dvc.selectedDeck = self.deck;
    }

}


#pragma mark - Modal actions

- (IBAction)saveManageDeck:(UIStoryboardSegue *)segue {
    [self initialSetup];

}

- (IBAction)cancelManageDeck:(UIStoryboardSegue *)segue {
    [self initialSetup];
   
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
        	self.contentTextView.text = @"The deck is empty.";
    	} else {
        	[self nextButtonPressed:nil];
    	}
	}
}


@end
