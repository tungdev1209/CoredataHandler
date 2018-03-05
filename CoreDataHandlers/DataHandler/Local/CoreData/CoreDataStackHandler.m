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
    NSManagedObjectContext *context = self.stack.managedObjectContext;
    __block NSError *error = nil;
    [context performBlockAndWait:^{
        if ([context hasChanges] && ![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        }
    }];
    return error;
}

-(void)saveEntry:(NSManagedObject *)object completion:(SaveResultsBlock)result {
    NSManagedObjectContext *context = object.managedObjectContext;
    [context performBlock:^{
        NSError *error = nil;
        if ([context hasChanges] && ![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        }
        result(error);
    }];
}

@end
