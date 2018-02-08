//
//  CoreDataStack.m
//  eLearning
//
//  Created by Tung Nguyen on 1/31/18.
//  Copyright © 2018 Joz. All rights reserved.
//

#import "CoreDataStack_iOS9.h"
#import "CoreDataStack_iOS10.h"

@implementation CoreDataStack

+(instancetype)shared {
    static CoreDataStack *obj = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        if (@available(iOS 9, *)) {
            obj = [[CoreDataStack_iOS9 alloc] init];
        }
        else {
            obj = [[CoreDataStack_iOS10 alloc] init];
        }
    });
    return obj;
}

@end
