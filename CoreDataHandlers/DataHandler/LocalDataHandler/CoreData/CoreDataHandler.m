//
//  CoreDataHandler.m
//  UIExtensionProject
//
//  Created by Tung Nguyen on 1/30/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "CoreDataHandler.h"
#import "CoreDataStack.h"
#import "NSObject_Extension.h"

@interface CoreDataHandler()

@property (nonatomic, strong) CoreDataStack *stack;
@property (nonatomic, strong) NSMutableArray *currentBackgroundContexts;

@end

@implementation CoreDataHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.stack = [CoreDataStack getStack];
        self.currentBackgroundContexts = [NSMutableArray array];
    }
    return self;
}

#pragma mark - COREDATA funcs
- (NSError *)saveMainContext {
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

-(NSError *)saveEntry:(NSManagedObject *)object {
    return [self saveMainContext];
}

- (NSManagedObject *)newBackgroundEntry:(Class)entryClass {
    NSManagedObjectContext *backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    backgroundContext.parentContext = self.stack.managedObjectContext;
     
    [self.currentBackgroundContexts addObject:backgroundContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass(entryClass) inManagedObjectContext:backgroundContext];
    return [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:backgroundContext];
}

-(void)saveEntry:(NSManagedObject *)object completion:(SaveResultsBlock)result {
    NSManagedObjectContext *context = object.managedObjectContext;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mergeChanges:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:context];
    
    __weak typeof(self) weakSelf = self;
    
    [context performBlock:^{
        NSError *error = nil;
        [context save:&error];
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.stack.managedObjectContext performBlockAndWait:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            result([strongSelf saveMainContext]);
        }];
    }];
}

-(void)mergeChanges:(NSNotification *)notification {
    if ([notification.name isEqualToString:NSManagedObjectContextDidSaveNotification]) {
        [self.currentBackgroundContexts removeObject:notification.object];
    }
}

#pragma mark - APP funcs
-(void)getListUsersLocal:(ListUsersBlock)completion {
    [self fetchEntries:[User fetchRequest] withPredicate:nil sortDescriptors:nil completionBlock:^(NSArray *users) {
        NSMutableArray *mUsers = [NSMutableArray array];
        for (User *user in users) {
            [mUsers addObject:[[UserModel alloc] initWithUser:user]];
        }
        if (completion) {
            completion(mUsers);
        }
    }];
}

-(void)getUserLocal:(GetUserBlock)completion withName:(NSString *)name {
    [self fetchEntries:[User fetchRequest] withPredicate:[NSPredicate predicateWithFormat:@"name == %@", name] sortDescriptors:nil completionBlock:^(NSArray *users) {
        UserModel *mUser = nil;
        if (users.firstObject) {
            mUser = [[UserModel alloc] initWithUser:users.firstObject];
        }
        if (completion) {
            completion(mUser);
        }
    }];
}

-(void)addUserLocal:(UserModel *)mUser completion:(SaveUserBlock)completion {
    User *cdUser = (User *)[self newBackgroundEntry:[User class]];
    [mUser sendDataToObject:cdUser];
     
    [self saveEntry:cdUser completion:^(NSError *error) {
        if (error) {
            NSLog(@"save entry failed: %@", error);
        }
        if (completion) {
            completion(!error);
        }
    }];
}

-(NSError *)addUserLocal:(UserModel *)mUser {
    User *cdUser = (User *)[self newEntry:[User class]];
    [mUser sendDataToObject:cdUser];
     
    return [self saveEntry:cdUser];
}

@end
