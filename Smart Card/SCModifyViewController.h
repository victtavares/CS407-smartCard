//
//  SCModifyViewController.h
//  Smart Card
//
//  Created by Victor Tavares on 5/2/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck+CRUD.h"

@interface SCModifyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *textViewB;
@property (weak, nonatomic) IBOutlet UITextView *textViewA;
@property (weak, nonatomic) IBOutlet UIView *cardAView;
@property (weak, nonatomic) IBOutlet UIView *cardBView;
@property (weak, nonatomic) IBOutlet UIImageView *imageA;
@property (weak, nonatomic) IBOutlet UIImageView *imageB;

@property (weak, nonatomic) IBOutlet UIButton *deleteImageA;
@property (weak, nonatomic) IBOutlet UIButton *deleteImageB;

@property (nonatomic) CGRect selectedTextViewCoordinates;
@property (nonatomic) CGRect textViewACoordinates;
@property (nonatomic) CGRect textViewBCoordinates;
@property (nonatomic) BOOL isCameraA;

@property(strong,nonatomic) Deck *selectedDeck;

@end
