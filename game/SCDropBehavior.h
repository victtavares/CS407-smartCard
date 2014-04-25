//
//  SCDropBehavior.h
//  Smart Card
//
//  Created by Fan on 4/23/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCDropBehavior : UIDynamicBehavior

-(void)addItem:(id <UIDynamicItem>)item;
-(void)removeItem:(id <UIDynamicItem>)item;

@end
