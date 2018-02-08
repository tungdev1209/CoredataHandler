//
//  CoreDataStack.m
//  eLearning
//
//  Created by Tung Nguyen on 1/31/18.
//  Copyright © 2018 Joz. All rights reserved.
//

#import "CoreDataStack_iOS9.h"
#import "CoreDataStack_iOS10.h"

// https://stackoverflow.com/questions/24657437/core-data-background-context-best-practice
@implementation CoreDataStack

+(instancetype)getStack {
    CoreDataStack *obj;
    if (@available(iOS 9, *)) {
        obj = [[CoreDataStack_iOS9 alloc] init];
    }
    else {
        obj = [[CoreDataStack_iOS10 alloc] init];
    }
    return obj;
}

@end
