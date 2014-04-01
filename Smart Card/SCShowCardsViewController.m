//
//  SCShowCardsViewController.m
//  Smart Card
//
//  Created by Victor Tavares on 3/26/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCShowCardsViewController.h"
#import "Card.h"
#import "SCDeckViewController.h"

@interface SCShowCardsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong,nonatomic) NSArray *cards;
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
    self.cards = [[self.deck cards] allObjects];
    Card *card = [self.cards objectAtIndex:0];
    self.contentTextView.text = card.contentA;
    self.displaySideA = TRUE;
    
}

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





#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[SCDeckViewController class]] ) {
        SCDeckViewController *dvc = (SCDeckViewController *) segue.destinationViewController;
        dvc.selectedDeck = self.deck;
    }

}


@end
