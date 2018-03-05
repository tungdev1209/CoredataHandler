//
//  CoreDataStackHandler.m
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 3/5/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "CoreDataStackHandler.h"
#import "CoreDataStack.h"

@interface CoreDataStackHandler ()

@property (nonatomic, strong) CoreDataStack *stack;
@property (nonatomic, strong) NSManagedObjectContext *backgroundContext;

@end

@implementation CoreDataStackHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.stack = [CoreDataStack getStack];
    }
    return self;
}

#pragma mark - COREDATA funcs
- (NSError *)saveMainContext {
    NSManagedObjectContext *context = _stack.managedObjectContext;
    __block NSError *error = nil;
    [context performBlockAndWait:^{
        if ([context hasChanges] && ![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            //        abort();
        }
    }];
    return error;
}

- (void)fetchEntries:(NSFetchRequest *)fetchRequest
       withPredicate:(NSPredicate *)predicate
     sortDescriptors:(NSArray *)sortDescriptors
     completionBlock:(FetchResultsBlock)completionBlock
{
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSManagedObjectContext *context = self.stack.managedObjectContext;
    
    NSAsynchronousFetchRequest *asyncFetch = [[NSAsynchronousFetchRequest alloc] initWithFetchRequest:fetchRequest completionBlock:^(NSAsynchronousFetchResult * _Nonnull result) {
        if (completionBlock) {
            completionBlock(result.finalResult);
        }
    }];
    
    [context performBlock:^{
        NSLog(@"excute on thread: %@", [NSThread currentThread]);
        NSError *error = nil;
        [context executeRequest:asyncFetch error:&error];
        
        if (error) {
            NSLog(@"fetch coredata fail: %@", error);
        }
    }];
}

- (NSArray *)fetchEntries:(NSFetchRequest *)fetchRequest
            withPredicate:(NSPredicate *)predicate
          sortDescriptors:(NSArray *)sortDescriptors
{
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSManagedObjectContext *context = self.stack.managedObjectContext;
    
    __block NSArray *result = nil;
    [context performBlockAndWait:^{
        NSLog(@"excute on thread: %@", [NSThread currentThread]);
        NSError *error = nil;
        result = [context executeFetchRequest:fetchRequest error:&error];
        if (error) {
            NSLog(@"fetch coredata fail: %@", error);
        }
    }];
    return result;
}

- (NSManagedObject *)newEntry:(Class)entryClass {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass(entryClass) inManagedObjectContext:self.stack.managedObjectContext];
    return [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.stack.managedObjectContext];
}

- (NSManagedObject *)newBackgroundEntry:(Class)entryClass {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass(entryClass) inManagedObjectContext:self.stack.backgroundManagedObjectContext];
    return [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.stack.backgroundManagedObjectContext];
}

-(NSError *)saveEntry:(NSManagedObject *)object {
    return [self saveMainContext];
}

-(void)saveEntry:(NSManagedObject *)object completion:(SaveResultsBlock)result {
    NSManagedObjectContext *context = object.managedObjectContext;
    [context performBlock:^{
        NSError *error = nil;
        [context save:&error];
        result(error);
    }];
}

@end
