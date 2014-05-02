//
//  SCDeckViewController.m
//  Smart Card
//
//  Created by Victor Tavares on 3/13/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCDeckViewController.h"
#import "SCShowCardDBViewController.h"
#import "SCConstants.h"
#import <Parse/Parse.h>
#import "Card+CRUD.h"
#import "Deck+CRUD.h"


@interface SCDeckViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *deckNameTextField;
@property (nonatomic) NSInteger count;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;

@property (weak, nonatomic) IBOutlet UILabel *uploadDeckLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;



@end


@implementation SCDeckViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialSetup];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initialSetup {
    [self.deckNameTextField becomeFirstResponder];
    
    if (self.selectedDeck.isUploaded.boolValue) self.uploadButton.enabled = NO;
    
    self.deckNameTextField.delegate = self;
    self.deckNameTextField.text = self.selectedDeck.name;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //if the user clicks on the save Button
    if([segue.destinationViewController isKindOfClass:[SCShowCardDBViewController class]]  && [segue.identifier isEqualToString:@"saveUnwindSegue"]) {
        SCShowCardDBViewController *cvc = (SCShowCardDBViewController *) segue.destinationViewController;
        [self saveModifications];
        cvc.deck = self.selectedDeck;
    }
}

-(void) saveModifications {
    BOOL isEdit = [Deck editDeck:self.selectedDeck withName:self.deckNameTextField.text withLat:self.selectedDeck.lat withLon:self.selectedDeck.lon];
    if (!isEdit) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ERROR" message:@"Unable to modify this deck!"
                                                      delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sucess" message:@"Deck informations was updated!"
                                                      delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        
    }
}


-(void) UIStartUploadDeck {
    NSLog(@"---------------- Debugging Upload ---------------- ");
    [self.activityIndicator startAnimating];
    self.uploadDeckLabel.hidden = NO;
}

-(void) UIFinishUploadDeck {
    NSLog(@"Saving the deck!");
    [self.activityIndicator stopAnimating];
    self.uploadDeckLabel.hidden = YES;
}

- (void) auxSaveSideBInBackground:(Card *)card withCardCloud:(PFObject *) cardCloud withDeckCloud:(PFObject *) deckCloud{
    //there is a imageB
    if (card.imageB) {
        PFFile *imageB = [PFFile fileWithName:@"ImageB.jpg" data:card.imageB];
        [imageB saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            cardCloud[kCardimageBKey] = imageB;
            cardCloud[kCardDeckKey] = deckCloud;
            [cardCloud saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                NSLog(@"Finish Downloading card number %i...",self.count);
                self.count--;
                //if its the last card
                if (self.count == 0) {
                    [self UIFinishUploadDeck];
                    
                    //saving deck on background
                    [deckCloud saveInBackground];
                }
            }];
        }];
    }
    //There's no image B
    else {
        cardCloud[kCardContentBKey] = card.contentB;
        cardCloud[kCardDeckKey] = deckCloud;
        [cardCloud saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            NSLog(@"Finish Downloading card number %i...",self.count);
            self.count--;
            //if its the last card
            if (self.count == 0) {
                [self UIFinishUploadDeck];
                //saving deck on background
                [deckCloud saveInBackground];
            }
        }];
    }
}


- (IBAction)uploadDeckButtonPressed:(id)sender {
    //Update UI
    self.selectedDeck.isUploaded = [NSNumber numberWithBool:YES];
    [Deck updateDeckOnWhenUploaded:self.selectedDeck];
    self.uploadButton.enabled = NO;

    [self UIStartUploadDeck];
    //Setting deck object
    PFObject *deckCloud = [PFObject objectWithClassName:kDeckClassName];
    deckCloud[kDeckNameKey] = self.selectedDeck.name;
    deckCloud[kDeckLonKey] =  self.selectedDeck.lon;
    deckCloud[kDeckLatKey] =  self.selectedDeck.lat;
    deckCloud[kDeckNameInitialKey] = self.selectedDeck.nameInitial;
    deckCloud[KDeckQuantityCardsKey] = [NSNumber numberWithInt:[self.selectedDeck.cards count]];
    
    

    self.count = self.selectedDeck.cards.count;
    for (Card *card in self.selectedDeck.cards) {
        PFObject *cardCloud = [PFObject objectWithClassName:kCardClassName];
        
        //If there's imageA
        if (card.imageA) {
            PFFile *imageA = [PFFile fileWithName:@"ImageA.jpg" data:card.imageA];
            [imageA saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                cardCloud[kCardimageAKey] = imageA;
                [self auxSaveSideBInBackground:card withCardCloud:cardCloud withDeckCloud:deckCloud];
            }];
        }
        //If there's no imageA
         else {
            cardCloud[kCardContentAKey] = card.contentA;
            [self auxSaveSideBInBackground:card withCardCloud:cardCloud withDeckCloud:deckCloud];
        }
    }
}
             


#pragma mark - Text View Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}




@end
