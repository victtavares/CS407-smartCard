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
       [self loadImagesAndPrepareSideAFromCard:card];
    }
}

-(void) clearCache {
    self.sideAImage = nil;
    self.sideBImage = nil;
    self.sideAtext = nil;
    self.sideBtext = nil;
}

-(void) loadImagesAndPrepareSideAFromCard:(PFObject *) card {
    //Clean the data from previous views
    [self clearCache];
    if (card[kCardimageAKey]) {
        PFFile *imageAFile = (PFFile *) card[kCardimageAKey];
        [imageAFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            self.sideAImage = [UIImage imageWithData:data];
            if (card[kCardimageBKey]) {
                PFFile *imageBFile = (PFFile *) card[kCardimageBKey];
                [imageBFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    self.sideBImage = [UIImage imageWithData:data];
                    //NSLog(@"SIDE A:%@ SIDE B:%@",self.sideAImage,self.sideBImage);
                    [self prepareSideA];
                }];
            } else self.sideBtext = card[kCardContentBKey];
        }];
    } else {
        self.sideAtext = card[kCardContentAKey];
        if (card[kCardimageBKey]) {
            PFFile *imageBFile = (PFFile *) card[kCardimageBKey];
            [imageBFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                self.sideBImage = [UIImage imageWithData:data];
                [self prepareSideA];
            }];
        } else self.sideBtext = card[kCardContentBKey];
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
    [self loadImagesAndPrepareSideAFromCard:card];
    
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
    [self loadImagesAndPrepareSideAFromCard:card];
}


- (IBAction)downloadButtonPressed:(id)sender {
    NSString *tittle =  [NSString stringWithFormat:@"Downloading %@, It may take some minutes!",self.deck[kDeckNameKey]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:tittle message:nil delegate:nil cancelButtonTitle:@"dismiss" otherButtonTitles:nil, nil];
    [alert show];
    [Deck saveDeckFromCloud:self.deck withCards:self.cards];
}


-(void) updateCounter {
    self.counterLabel.text = [NSString stringWithFormat:@"%i / %@",self.currentCardIndex +1,self.deck[KDeckQuantityCardsKey]];
}

@end
