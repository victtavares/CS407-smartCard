//
//  SCShowCardCloudViewController.m
//  Smart Card
//
//  Created by Victor Tavares on 4/24/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCShowCardCloudViewController.h"
#import "SCConstants.h"
#import "Deck+CRUD.h"

@interface SCShowCardCloudViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *imageView;

@end

@implementation SCShowCardCloudViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialSetup];
    // Do any additional setup after loading the view.
}

-(void) initialSetup {
    [self updateCounter];
    self.title = self.deck[kDeckNameKey];
    //if the deck is not empty
    if ([self.cards count]) {
       PFObject *card = [self.cards objectAtIndex:0];
       [self loadContentAndPrepareSideAFromCard:card];
    }
}

-(void) clearCache {
    self.sideAImage = nil;
    self.sideBImage = nil;
    self.sideAtext = nil;
    self.sideBtext = nil;
}

-(void) loadContentAndPrepareSideAFromCard:(PFObject *) card {
    //Clean the data from previous views
    [self clearCache];
    //If have Image A
    if (card[kCardimageAKey]) {
        PFFile *imageAFile = (PFFile *) card[kCardimageAKey];
        [imageAFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            self.sideAImage = [UIImage imageWithData:data];
            //Also have Image B
            if (card[kCardimageBKey]) {
                PFFile *imageBFile = (PFFile *) card[kCardimageBKey];
                [imageBFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    self.sideBImage = [UIImage imageWithData:data];
                    [self prepareSideA];
                }];
            }
            //Doesn't have Image B
            else {
               self.sideBtext = card[kCardContentBKey];
                [self prepareSideA];
            }
        }];
     //Doesn't have imageA...
    } else {
        self.sideAtext = card[kCardContentAKey];
        //Have Image B....
        if (card[kCardimageBKey]) {
            PFFile *imageBFile = (PFFile *) card[kCardimageBKey];
            [imageBFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                self.sideBImage = [UIImage imageWithData:data];
                [self prepareSideA];
            }];
        } else {
           self.sideBtext = card[kCardContentBKey];
            [self prepareSideA];
        }
    }
}


- (IBAction)previousButtonPressed:(id)sender {
    self.currentCardIndex--;
    PFObject *card;
    
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
    PFObject *card;
    
	if (self.currentCardIndex < [self.cards count]) {
    	card = [self.cards objectAtIndex:self.currentCardIndex];
	} else {
    	self.currentCardIndex = 0;
    	card = [self.cards objectAtIndex:self.currentCardIndex];
	}
    [self updateCounter];
    [self loadContentAndPrepareSideAFromCard:card];
}





- (IBAction)downloadButtonPressed:(id)sender {
    NSString *tittle =  [NSString stringWithFormat:@"Downloading %@...",self.deck[kDeckNameKey]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:tittle message:nil delegate:nil cancelButtonTitle:@"dismiss" otherButtonTitles:nil, nil];
    [alert show];
    [Deck saveDeckFromCloud:self.deck withCards:self.cards];
}


-(void) updateCounter {
    self.counterLabel.text = [NSString stringWithFormat:@"%i / %@",self.currentCardIndex +1,self.deck[KDeckQuantityCardsKey]];
}

@end
