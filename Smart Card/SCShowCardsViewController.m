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
#import <MobileCoreServices/MobileCoreServices.h>


@interface SCShowCardsViewController () <UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *sideLabel;
//Testing the merge
@property (strong,nonatomic) NSMutableArray *cards;
@property (nonatomic) int currentCardIndex;

@property (strong,nonatomic) NSString *sideAText;
@property (strong,nonatomic) NSString *sideBText;
@property (strong,nonatomic) UIImage *sideAImage;
@property (strong,nonatomic) UIImage *sideBImage;

@property (nonatomic) BOOL isSideA;

@property (nonatomic) BOOL isEditing;
@property (nonatomic) BOOL isSavingNewCard;

@property (strong, nonatomic) UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *createCardButton;
@property (weak, nonatomic) IBOutlet UIButton *flipButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelImageButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@end

@implementation SCShowCardsViewController



-(void) viewWillAppear:(BOOL)animated {
    //putting the back Button
    [super viewWillAppear:YES];
    self.cancelButton = self.navigationItem.leftBarButtonItem;
    self.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initialSetup];
    // Do any additional setup after loading the view.
}


-(void) initialSetup {
    self.title = self.deck.name;
    self.cards = [[[self.deck cards] allObjects]mutableCopy];
    
    [self changeButtonStatus];
    
    //if the deck is not empty
    if ([self.cards count]) {
        Card *card = [self.cards objectAtIndex:0];
        self.contentTextView.text = card.contentA;
        self.sideAText = card.contentA;
        self.sideBText = card.contentB;
        self.sideAImage = [UIImage imageWithData:card.imageA];
        self.sideBImage = [UIImage imageWithData:card.imageB];
        [self setSideA];
    }
    
    self.isSideA = TRUE;
    self.contentTextView.delegate = self;

}



#pragma mark - Actions

- (IBAction)editButtonPressed:(id)sender {
    //Button = edit
    if (!self.isEditing) {
        self.isEditing = TRUE;
        
        
        //Hidding  or showing the Buttons
        self.deleteButton.hidden = YES;
        self.createCardButton.hidden = YES;
        self.previousButton.hidden = YES;
        self.nextButton.hidden = YES;
        self.flipButton.hidden = YES;
        self.cameraButton.hidden = NO;
        self.contentTextView.editable = YES;
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.leftBarButtonItem = self.cancelButton;
        
        [sender setTitle:@"Save Modifications" forState:UIControlStateNormal];
        
        //If there is no text and no image, doesn't allow the user to save the changes
        if ((![self.contentTextView.text length]) && (!self.contentImageView.image)) self.editButton.enabled = NO;
        else  self.editButton.enabled = YES;
        
        if (self.contentImageView.image) self.cancelImageButton.hidden = NO;

    //Button save modifications pressed
    } else {
        Card *cardToEdit = [self.cards objectAtIndex:self.currentCardIndex];
        [Card editCard:cardToEdit withContentA:self.sideAText withContentB:self.sideBText withImageA:self.sideAImage withImageB:self.sideBImage];
        
        self.contentTextView.editable = false;
        self.isEditing = false;

        //Hidding  or showing the Buttons
        self.deleteButton.hidden = NO;
        self.createCardButton.hidden = NO;
        self.previousButton.hidden = NO;
        self.nextButton.hidden = NO;
        self.flipButton.hidden = NO;
        self.cameraButton.hidden = YES;
        self.cancelImageButton.hidden = YES;
        
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        self.navigationItem.hidesBackButton = NO;
        self.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem;
        
        
    }
}

- (IBAction)newCardButtonPressed:(id)sender {
    //Button tittle = New Card
    if (!self.isSavingNewCard) {
        self.isSavingNewCard = TRUE;
        self.contentTextView.editable = YES;
        self.contentTextView.text = nil;
        self.contentImageView.image = nil;
        self.sideBText = nil;
        self.sideAText = nil;
        self.sideAImage = nil;
        self.sideBImage = nil;
        [self setSideA];
        
        //Hidding  or showing the Buttons
        self.deleteButton.hidden = YES;
        self.editButton.hidden = YES;
        self.previousButton.hidden = YES;
        self.nextButton.hidden = YES;
        self.cameraButton.hidden = NO;
        self.flipButton.enabled = TRUE;
        
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.leftBarButtonItem = self.cancelButton;
        
        [sender setTitle:@"Save Card" forState:UIControlStateNormal];
        
    } else {
      BOOL isAdded = [Card addCardWithContentA:self.sideAText inContentB:self.sideBText withImageA:self.sideAImage withImageB:self.sideBImage ImageinDeck:self.deck intoManagedObjectContext:[self.deck managedObjectContext]];

        
        if (isAdded) {
            self.deleteButton.hidden = NO;
            self.editButton.hidden = NO;
            self.previousButton.hidden = NO;
            self.nextButton.hidden = NO;
            self.cancelImageButton.hidden = YES;
            self.cameraButton.hidden = YES;
            self.contentTextView.editable = FALSE;
            self.isSavingNewCard = false;
            
            //Now the deck have at least 1 Card,so enable this buttons
            self.editButton.enabled = TRUE;
            self.deleteButton.enabled = TRUE;
            
            self.navigationItem.hidesBackButton = NO;
            self.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem;
            
            //Getting the deck with the recently added Card
            self.cards = [[[self.deck cards] allObjects]mutableCopy];
            [sender setTitle:@"New Card" forState:UIControlStateNormal];
            
            [self changeButtonStatus];
        
            
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
    
    if (card.imageA) self.contentImageView.image = [UIImage imageWithData:card.imageA];
    else self.contentTextView.text = card.contentA;
        
    self.sideAImage = [UIImage imageWithData:card.imageA];
    self.sideBImage = [UIImage imageWithData:card.imageB];
    self.sideAText = card.contentA;
    self.sideBText = card.contentB;
    [self setSideA];
    
    if (self.isEditing) {
        self.cancelImageButton.hidden = YES;
    }
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
    
    if (card.imageA) self.contentImageView.image = [UIImage imageWithData:card.imageA];
    else self.contentTextView.text = card.contentA;
    
    self.sideAImage = [UIImage imageWithData:card.imageA];
    self.sideBImage = [UIImage imageWithData:card.imageB];
    NSLog(@"Card Content A = %@ Card Content B = %@ card Image A = %i card Image B = %i card Index:%i",card.contentA,card.contentB,[card.imageA length],[card.imageB length],self.currentCardIndex);
    self.sideAText = card.contentA;
    self.sideBText = card.contentB;
    [self setSideA];
    
    if (self.isEditing) {
        self.cancelImageButton.hidden = YES;
    }

}

- (IBAction)flipButtonPressed:(id)sender {
    if (self.isSideA) {
        [self setSideB];
        //self.sideAText = self.contentTextView.text;
        //self.contentTextView.text = self.sideBText;
	} else {
        [self setSideA];
        //self.sideBText = self.contentTextView.text;
        self.contentTextView.text = self.sideAText;
        
	}
    if (self.isEditing) {
        self.cancelImageButton.hidden = YES;
    }
}

- (IBAction)deleteButtonPressed:(id)sender {
	if ([self.cards count]!=0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Delete Card" message:@"Do you want to delete this card?"
                                                      delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        [alert show];
    }
    
}



- (IBAction)cameraButtonPressed:(id)sender {
    UIImagePickerController *imagePicker =
    [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
    
    imagePicker.allowsEditing = YES;
    
    [self presentViewController:imagePicker
                       animated:YES completion:nil];
}


- (IBAction)cancelImageButtonPressed:(id)sender {
    self.contentImageView.image = nil;
    self.contentTextView.hidden = NO;
    self.cancelImageButton.hidden = YES;
    
    if (self.isSideA) self.sideAImage = nil;
    else self.sideBImage = nil;
    //If I remove a image,I cannot save the modifications in the card,unless I put a text on it
    if(self.isEditing) {
        self.editButton.enabled = NO;
    }
}

- (IBAction)cancelButtonPressed:(id)sender {    
    if (self.isEditing) {
        Card *card = [self.cards objectAtIndex:self.currentCardIndex];
        self.sideAImage = [UIImage imageWithData:card.imageA];
        self.sideBImage = [UIImage imageWithData:card.imageB];
        self.sideAText = card.contentA;
        self.sideBText = card.contentB;
        [self setSideA];
        
        self.contentTextView.editable = false;
        self.isEditing = false;
        
        //Hidding or showing the Buttons
        self.deleteButton.hidden = NO;
        self.createCardButton.hidden = NO;
        self.previousButton.hidden = NO;
        self.nextButton.hidden = NO;
        self.flipButton.hidden = NO;
        self.cameraButton.hidden = YES;
        
        
        self.navigationItem.hidesBackButton = NO;
        self.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem;
        
        if (!self.editButton.isEnabled) self.editButton.enabled = TRUE;
        [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
        
    }
    
    if (self.isSavingNewCard) {
        if ([self.cards count]) {
            Card *card = [self.cards objectAtIndex:self.currentCardIndex];
            self.sideAImage = [UIImage imageWithData:card.imageA];
            self.sideBImage = [UIImage imageWithData:card.imageB];
            self.sideAText = card.contentA;
            self.sideBText = card.contentB;
            [self setSideA];
        }
        else {
            self.flipButton.enabled = FALSE;
            self.contentTextView.text = @"Empty Deck!";
            
        }
    }
    self.deleteButton.hidden = NO;
    self.editButton.hidden = NO;
    self.previousButton.hidden = NO;
    self.nextButton.hidden = NO;
    self.cancelImageButton.hidden = YES;
    self.cameraButton.hidden = YES;
    self.isSavingNewCard = false;
    
    self.navigationItem.hidesBackButton = NO;
    self.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem;
    
    [self.createCardButton setTitle:@"New Card" forState:UIControlStateNormal];
    [self setSideA];
     self.contentTextView.editable = false;
}


#pragma mark - UIImagepickercontroller delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.contentTextView.text = nil;
    self.contentTextView.hidden = YES;
    self.cancelImageButton.hidden = NO;
    self.contentImageView.image = chosenImage;
    
    if (self.isSideA) {
       self.sideAImage = chosenImage;
        self.sideAText = nil;
    }
    else {
        self.sideBImage = chosenImage;
        self.sideBText = nil;
    }
    //If I pick a Image and I am editing a card,I can save the card
    if(self.isEditing) {
        self.editButton.enabled = YES;
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}




#pragma mark - Aux Functions
- (void) setSideA {
    self.sideLabel.text = @"Side A";
    self.isSideA = YES;
    //Setting the content,if there is a image the textView is null and vice versa
    self.contentTextView.text = self.sideAText;
    self.contentImageView.image = self.sideAImage;
    if (self.sideAImage) {
       self.contentTextView.hidden = YES;
        //If its is in the saving process, allows the user to delete the image
        if (self.isSavingNewCard) self.cancelImageButton.hidden = NO;
    }
    else {
        self.contentTextView.hidden = NO;
        self.contentImageView.image = nil;
        self.cancelImageButton.hidden = YES;
    }
}

- (void) setSideB {
    self.sideLabel.text = @"Side B";
    self.isSideA = NO;
    //Setting the content,if there is a image the textView is null and vice versa
    self.contentTextView.text = self.sideBText;
    self.contentImageView.image = self.sideBImage;
    
    if (self.sideBImage)  {
        self.contentTextView.hidden = YES;
        //If its is in the saving process, allows the user to delete the image
        if (self.isSavingNewCard) self.cancelImageButton.hidden = NO;
    }
    else {
        self.contentTextView.hidden = NO;
        self.contentImageView.image = nil;
        self.cancelImageButton.hidden = YES;
    }
}


- (void) changeButtonStatus {

    
    //Setting the Buttons in the case of a empty Deck
    if ([self.cards count]) {
        self.editButton.enabled = YES;
        self.deleteButton.enabled = YES;
        self.nextButton.enabled = YES;
        self.previousButton.enabled = YES;
        self.flipButton.enabled = YES;
    } else {
        self.editButton.enabled = FALSE;
        self.deleteButton.enabled = FALSE;
        self.nextButton.enabled = FALSE;
        self.previousButton.enabled = FALSE;
        self.flipButton.enabled = FALSE;
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
        	self.contentTextView.text = @"Empty Deck!";
            self.currentCardIndex = 0;
    	} else {
        	[self nextButtonPressed:nil];
    	}
        [self changeButtonStatus];
	}

    
}


#pragma mark - Text View Delegate
- (BOOL) textView: (UITextView*) textView
shouldChangeTextInRange: (NSRange) range
  replacementText: (NSString*) text
{
    
    if(self.isEditing) {
        //If there is no text and no image, doesn't allow the user to save the changes (Checking text in realtime)
        if ((![self.contentTextView.text length]) && (!self.contentImageView.image)) self.editButton.enabled = NO;
        else  self.editButton.enabled = YES;
    }
    
    if ([text isEqualToString:@"\n"]) {
        if (self.isSideA) self.sideAText = textView.text;
        else self.sideBText = textView.text;
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
