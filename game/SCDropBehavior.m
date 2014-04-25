//
//  SCDropBehavior.m
//  Smart Card
//
//  Created by Fan on 4/23/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCDropBehavior.h"

@interface SCDropBehavior()

@property (strong, nonatomic) UIGravityBehavior *gravity;
@property (strong, nonatomic) UICollisionBehavior *collider;
@property (strong, nonatomic) UIDynamicItemBehavior *itemBehavior;
@end

@implementation SCDropBehavior

-(instancetype) init
{
    self = [super init];
    [self addChildBehavior:self.gravity];
    [self addChildBehavior:self.collider];
    [self addChildBehavior:self.itemBehavior];
    return self;
}

-(void)addItem:(id<UIDynamicItem>)item{
    [self.gravity addItem:item];
    [self.collider addItem:item];
    [self.itemBehavior addItem:item];
}

-(void)removeItem:(id<UIDynamicItem>)item{
    [self.gravity removeItem:item];
    [self.collider removeItem:item];
    [self.itemBehavior removeItem:item];
}

-(UIDynamicItemBehavior *) itemBehavior {
    if (!_itemBehavior) {
        _itemBehavior = [[UIDynamicItemBehavior alloc]init];
        _itemBehavior.allowsRotation = NO;
        _itemBehavior.elasticity = 0.5;
    }
    return _itemBehavior;
}


-(UIGravityBehavior *) gravity {
    if (!_gravity) {
        _gravity = [[UIGravityBehavior alloc]init];
        _gravity.magnitude = 5;
    }
    return _gravity;
}

-(UICollisionBehavior *) collider {
    if (!_collider) {
        _collider = [[UICollisionBehavior alloc]init];
        _collider.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collider;
}



@end

