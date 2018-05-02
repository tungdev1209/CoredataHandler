//
//  Subcriber.m
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 4/29/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "Subcriber.h"
#import "ObservableObject+Private.h"

@implementation Subcriber

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.subcriberId = [CleanBag getRunTimeId];
    }
    return self;
}

-(void)cleanupBy:(CleanBag *)bag {
    if ([bag.bagId isEqualToString:self.bag.bagId]) {
        NSLog(@"same bag");
        return;
    }
    if (self.bag) {
        [self removeObservingBag];
    }
    self.bag = bag;
    [bag registerSubcriberObject:self];
    [self addObservingBag];
}

-(void)addObservingBag {
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(bag)) options:NSKeyValueObservingOptionNew context:nil];
}

-(void)removeObservingBag {
    @try {
        [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(bag)) context:nil];
    } @catch (NSException *exception) {
        NSLog(@"remove error: %@", exception);
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"Subcriber === observed keypath: %@ from object: %@", object, keyPath);
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(bag))] && self.bag == nil) {
        [self removeObservingBag];
        [self.observableObj removeSubcriberWithId:self.subcriberId];
    }
}

@end
