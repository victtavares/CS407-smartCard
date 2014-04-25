//
//  SCCardView.m
//  Smart Card
//
//  Created by Fan on 4/23/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCCardView.h"
#import "Card.h"
#import "Card+CRUD.h"

@interface SCCardView(){
    NSArray *gameCards;
}

@end

@implementation SCCardView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect subViewFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.textView = [[UITextView alloc]initWithFrame:subViewFrame];
        self.imageView = [[UIImageView alloc]initWithFrame:subViewFrame];
        self.textView.backgroundColor = [UIColor clearColor];
        self.textView.textAlignment = NSTextAlignmentCenter;
        self.textView.editable = NO;
        self.textView.selectable = NO;
        [self addSubview:self.imageView];
        [self addSubview:self.textView];  //card textView responds to tap gesture
    }
    return self;
}


-(void)setSideAfromDeck:(Deck *)deck {
    NSArray *cards = [deck.cards allObjects];
    if ([cards count]) {
        int i = arc4random()%[cards count];
        Card *card = cards[i];
        self.cardId = [card objectID];
        if (card.imageA) {
            [self.imageView setImage:[UIImage imageWithData:card.imageA]];
        } else {
            [self.imageView setImage:[UIImage imageNamed:@"gameBGImage.png"]];
        }
        if (card.contentA) {
            [self.textView setText:card.contentA];
        }
    }

}

-(void)setSideBfromDeck:(Deck *)deck {
    NSArray *cards = [deck.cards allObjects];
    if ([cards count]) {
        int i = arc4random()%[cards count];
        Card *card = cards[i];
        self.cardId = [card objectID];
        if (card.imageB) {
            [self.imageView setImage:[UIImage imageWithData:card.imageB]];
        } else {
            [self.imageView setImage:[UIImage imageNamed:@"gameBGImage.png"]];
        }
        if (card.contentB) {
            [self.textView setText:card.contentB];
        }
    }

}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
