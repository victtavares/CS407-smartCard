//
//  SCShowCardViewController.h
//  Smart Card
//
//  Created by Victor Tavares on 4/24/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface SCShowCardViewController : UIViewController
@property (strong,nonatomic) NSMutableArray *cards;

//Views
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UILabel *sideLabel;
@property (weak, nonatomic) IBOutlet PFImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property (weak, nonatomic) IBOutlet UILabel *textContent;

//Others variables
@property (nonatomic) BOOL isSideA;
@property (strong,nonatomic) NSString *sideAtext;
@property (strong,nonatomic) NSString *sideBtext;
@property (strong,nonatomic) UIImage *sideAImage;
@property (strong,nonatomic) UIImage *sideBImage;
@property (nonatomic) int currentCardIndex;

-(void) prepareSideA;
-(void) prepareSideB;
@end
