//
//  CoreDataHandler.m
//  UIExtensionProject
//
//  Created by Tung Nguyen on 1/30/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "CoreDataHandler.h"
#import "CoreDataStack.h"

@interface CoreDataHandler()

@end

@implementation CoreDataHandler

+(instancetype)shared {
    static CoreDataHandler *obj = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        obj = [[CoreDataHandler alloc]init];
    });
    return obj;
}

- (void)saveContext {
    NSManagedObjectContext *context = _AppCoredataStack.managedObjectContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
