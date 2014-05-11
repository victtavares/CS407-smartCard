//
//  SCEditCardViewController.m
//  Smart Card
//
//  Created by Victor Tavares on 5/2/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCEditCardViewController.h"
#import "SCShowCardDBViewController.h"

@interface SCEditCardViewController ()

@end

@implementation SCEditCardViewController


-(void) viewDidLoad {
    [super viewDidLoad];
    
    if (self.cardToEdit.imageA) {
        
        self.imageA.image = [UIImage imageWithData:self.cardToEdit.imageA];
        self.deleteImageA.hidden = NO;
    } else {
        self.textViewA.text = self.cardToEdit.contentA;
    }
    
    if (self.cardToEdit.imageB) {
        self.imageB.image = [UIImage imageWithData:self.cardToEdit.imageB];
        self.deleteImageB.hidden = NO;
    } else self.textViewB.text = self.cardToEdit.contentB;
}


-(void) editCard {
    [Card editCard:self.cardToEdit withContentA:self.textViewA.text withContentB:self.textViewB.text withImageA:self.imageA.image withImageB:self.imageB.image];
}
#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //if the user clicks on the save Button
    if([segue.destinationViewController isKindOfClass:[SCShowCardDBViewController class]]  && [segue.identifier isEqualToString:@"editUnwindSegue"]) {
        SCShowCardDBViewController *cvc = (SCShowCardDBViewController *) segue.destinationViewController;
        [self editCard];
        cvc.deck = self.selectedDeck;
    }
}


@end
