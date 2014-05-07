//
//  SCCardView.h
//  Smart Card
//
//  Created by Fan on 4/23/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface SCCardView : UIView

@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSManagedObjectID *cardId;


@property int index;//used when cancel two matched cards

-(void) setSideAfromDeck:(Deck *)deck withImage:(UIImage *)image;

-(void) setSideBfromDeck:(Deck *)deck withImage:(UIImage *)image;

@end
