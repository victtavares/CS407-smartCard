//
//  SCAddCardViewController.m
//  Smart Card
//
//  Created by Victor Tavares on 4/30/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCAddCardViewController.h"
#import "SCShowCardDBViewController.h"
#import "Card+CRUD.h"


@interface SCAddCardViewController ()

@end

@implementation SCAddCardViewController

-(void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    //Making Palceholder
    NSString *message = @"Put a text or a image here";
    self.textViewA.text = message;
    self.textViewB.text = message;
    self.textViewA.textColor = [UIColor lightGrayColor];
    self.textViewB.textColor = [UIColor lightGrayColor];
}

- (void) saveCard {
    BOOL isAdded = [Card addCardWithContentA:self.textViewA.text inContentB:self.textViewB.text withImageA:self.imageA.image withImageB:self.imageB.image  ImageinDeck:self.selectedDeck intoManagedObjectContext:[self.selectedDeck managedObjectContext]];
    
    
    if (!isAdded) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Blank Field" message:@"The card could not be added,one of the fields are blank!"
                                                      delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];

        
        
    }else {
        NSString *message = [NSString stringWithFormat:@" Card added to deck %@!",self.selectedDeck.name];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:message message:nil                                                      delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }


}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //if the user clicks on the save Button
    if([segue.destinationViewController isKindOfClass:[SCShowCardDBViewController class]]  && [segue.identifier isEqualToString:@"saveUnwindSegue"]) {
        NSLog(@"went here");
        SCShowCardDBViewController *cvc = (SCShowCardDBViewController *) segue.destinationViewController;
        [self saveCard];
        cvc.deck = self.selectedDeck;
    }
}


@end
