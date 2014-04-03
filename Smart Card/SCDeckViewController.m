//
//  SCDeckViewController.m
//  Smart Card
//
//  Created by Victor Tavares on 3/13/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCDeckViewController.h"
#import "SCShowCardsViewController.h"


@interface SCDeckViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *deckNameTextField;
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
    self.deckNameTextField.delegate = self;
    self.deckNameTextField.text = self.selectedDeck.name;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //if the user clicks on the save Button
    if([segue.destinationViewController isKindOfClass:[SCShowCardsViewController class]]  && [segue.identifier isEqualToString:@"saveUnwindSegue"]) {
        SCShowCardsViewController *cvc = (SCShowCardsViewController *) segue.destinationViewController;
        [self saveModifications];
        cvc.deck = self.selectedDeck;
    }
}

-(void) saveModifications {
    BOOL isEdit = [Deck editDeck:self.selectedDeck withName:self.deckNameTextField.text withLat:self.selectedDeck.lat withLon:self.selectedDeck.lon];
    if (!isEdit) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Duplicate Decks" message:@"Unable to add this deck,a deck with this name already exists!"
                                                      delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sucess" message:@"Deck informations was updated!"
                                                      delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }
}




#pragma mark - Text View Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
@end
