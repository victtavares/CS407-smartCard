//
//  SCShowCardViewController.m
//  Smart Card
//
//  Created by Victor Tavares on 4/24/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCShowCardViewController.h"
#import <QuartzCore/QuartzCore.h>

//ABSTRACT CLASS - NEED TO SET VARIABLES IN PARENT CLASS
@interface SCShowCardViewController ()
@property (assign, nonatomic) CATransform3D flipTransformation;

@end

@implementation SCShowCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.cardView.layer.cornerRadius = 10;
    self.cardView.layer.masksToBounds = YES;
}


- (IBAction)flipButtonPressed:(id)sender {
    [self flipAnimation];
    if (self.isSideA) [self prepareSideB];
    else [self prepareSideA];
	
}


- (void) flipAnimation {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.60];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.cardView cache:YES];
    [UIView commitAnimations];
}


- (void) animationNext {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.8];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.cardView cache:YES];
    [UIView commitAnimations];
}


-(void) animationPrevious {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.8];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.cardView cache:YES];
    [UIView commitAnimations];
    
}
#pragma mark - Aux Functions
-(void) prepareSideA {
    self.sideLabel.text = @"Side A";
    self.isSideA = YES;
    //Setting the content,if there is a image the textView is null and vice versa
    self.textContent.text = self.sideAtext;
    self.imageView.image = self.sideAImage;
    
    if (self.sideAImage) self.textContent.hidden = YES;
    
    else {
        self.textContent.hidden = NO;
        self.imageView.image = nil;
    }
}



-(void) prepareSideB {
    self.sideLabel.text = @"Side B";
    self.isSideA = NO;
    //Setting the content,if there is a image the textView is null and vice versa
    self.textContent.text = self.sideBtext;
    self.imageView.image = self.sideBImage;
    
    if (self.sideBImage) self.textContent.hidden = YES;
    else {
        self.textContent.hidden = NO;
        self.imageView.image = nil;
    }
}


@end
