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
    if (self.isSideA) [self prepareSideB];
    else [self prepareSideA];
	
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
