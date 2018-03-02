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

@property (nonatomic, strong) CoreDataStack *stack;

@end

@implementation CoreDataHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.stack = [CoreDataStack getStack];
    }
    return self;
}

- (NSError *)saveContext {
    NSManagedObjectContext *context = _stack.managedObjectContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//        abort();
        return error;
    }
    return nil;
}

- (void)fetchEntries:(NSFetchRequest *)fetchRequest
       withPredicate:(NSPredicate *)predicate
     sortDescriptors:(NSArray *)sortDescriptors
     completionBlock:(FetchResultsBlock)completionBlock
{
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    [_stack.managedObjectContext performBlock:^{
        NSLog(@"excute on thread: %@", [NSThread currentThread]);
        NSError *error = nil;
        NSArray *results = [_stack.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        if (error) {
            NSLog(@"fetch coredata fail: %@", error);
        }
        if (completionBlock) {
            completionBlock(results);
        }
    }];
}

- (NSManagedObject *)newEntry:(Class)entryClass {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass(entryClass) inManagedObjectContext:_stack.managedObjectContext];
    return [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:_stack.managedObjectContext];
}

- (void)saveEntry:(SaveResultsBlock)result {
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mergeChanges:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:context];
    [context performBlock:^{
        //make changes
        NSError *error = nil;
        [context save:&error];
        //remember to remove observer after the save (in mergeChanges: and dealloc)
    }];
}

-(void)mergeChanges:(NSNotification *)notification {
    result([self saveContext]);
}

@end
