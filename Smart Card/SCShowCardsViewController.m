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


@interface SCShowCardsViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *sideLabel;

@property (strong,nonatomic) NSMutableArray *cards;
@property (nonatomic) int currentCardIndex;

@property (strong,nonatomic) NSString *sideAText;
@property (strong,nonatomic) NSString *sideBText;
@property (nonatomic) BOOL isSideA;

@property (nonatomic) BOOL isEditing;
@property (nonatomic) BOOL isSavingNewCard;


@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
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
    
    //if the deck is not empty
    if ([self.cards count]) {
        Card *card = [self.cards objectAtIndex:0];
        self.contentTextView.text = card.contentA;
        self.sideAText = card.contentA;
        self.sideBText = card.contentB;
    }
    
    self.isSideA = TRUE;
    self.contentTextView.delegate = self;
}



#pragma mark - Actions

- (IBAction)editButtonPressed:(id)sender {
    
    self.contentTextView.editable = YES;
    self.isEditing = TRUE;
    [self.contentTextView becomeFirstResponder];
}

- (IBAction)newCardButtonPressed:(id)sender {
    //Button tittle = New Card
    if (!self.isSavingNewCard) {
        self.contentTextView.editable = YES;
        self.contentTextView.text = nil;
        self.sideBText = nil;
        self.sideAText = nil;
        [self setSideA];
        
        //Hidding the Buttons
        self.deleteButton.hidden = YES;
        self.editButton.hidden = YES;
        self.previousButton.hidden = YES;
        self.nextButton.hidden = YES;
        
        [sender setTitle:@"Save Card" forState:UIControlStateNormal];
        self.isSavingNewCard = TRUE;
        
    //Button tittle = save Card
    } else {
        
        BOOL isAdd = [Card addCardWithContentA:self.sideAText inContentB:self.sideBText inDeck:self.deck intoManagedObjectContext:[self.deck managedObjectContext]];
        if (isAdd) {
            self.deleteButton.hidden = NO;
            self.editButton.hidden = NO;
            self.previousButton.hidden = NO;
            self.nextButton.hidden = NO;
            
            self.isSavingNewCard = false;
            
            //Getting the deck with the recently added Card
            self.cards = [[[self.deck cards] allObjects]mutableCopy];
            [sender setTitle:@"New Card" forState:UIControlStateNormal];
            
        }else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Blank Field" message:@"The card could not be added,one of the fields are blank!"
                                                          delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
        }
    }

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
    
    self.contentTextView.text = card.contentA;
    self.sideAText = card.contentA;
    self.sideBText = card.contentB;
	[self setSideA];
}

- (IBAction)previousButtonPressed:(id)sender {
    self.currentCardIndex--;
    Card *card;
	if (self.currentCardIndex >= 0) {
    	card = [self.cards objectAtIndex:self.currentCardIndex];
	} else {
    	self.currentCardIndex = [_deck.cards count]-1;
    	card = [self.cards objectAtIndex:self.currentCardIndex];
	}
    
    self.contentTextView.text = card.contentA;
    self.sideAText = card.contentA;
    self.sideBText = card.contentB;
    [self setSideA];
}

- (IBAction)flipButtonPressed:(id)sender {
    if (self.isSideA) {
    	self.sideAText = self.contentTextView.text;
    	self.contentTextView.text = self.sideBText;
    	[self setSideB];
	} else {
    	self.sideBText = self.contentTextView.text;
    	self.contentTextView.text = self.sideAText;
    	[self setSideA];
	}

}

- (IBAction)deleteButtonPressed:(id)sender {
	if ([self.cards count]!=0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Delete Card" message:@"Do you want to delete this card?"
                                                      delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        [alert show];
    }
}

#pragma Mark - Aux Functions
- (void) setSideA {
    self.sideLabel.text = @"Side A";
    self.isSideA = YES;
}

- (void) setSideB {
    self.sideLabel.text = @"Side B";
    self.isSideA = NO;
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


#pragma mark - Text View Delegate
- (BOOL) textView: (UITextView*) textView
shouldChangeTextInRange: (NSRange) range
  replacementText: (NSString*) text
{
    if (self.isSideA) self.sideAText = textView.text;
    else self.sideBText = textView.text;
    
    if ([text isEqualToString:@"\n"]) {
        if (self.isEditing) {
            Card *cardToEdit = [self.cards objectAtIndex:self.currentCardIndex];
            [Card editCard:cardToEdit withContentA:self.sideAText withContentB:self.sideBText];
            textView.editable = false;
            self.isEditing = false;
        }
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
