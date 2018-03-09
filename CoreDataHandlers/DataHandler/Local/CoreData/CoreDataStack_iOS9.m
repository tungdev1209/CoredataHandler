//
//  CoreDataStack_iOS9.m
//  eLearning
//
//  Created by Tung Nguyen on 1/31/18.
//  Copyright © 2018 Joz. All rights reserved.
//

#import "CoreDataStack_iOS9.h"

@interface CoreDataStack_iOS9 ()

@property (nonatomic, strong) NSManagedObjectContext *localManagedObjectContext;
@property (nonatomic, strong) NSManagedObjectContext *localBackgroundManagedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *localManagedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *localPersistentStoreCoordinator;

@end

@implementation CoreDataStack_iOS9

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainContextChanged:) name:NSManagedObjectContextDidSaveNotification object:self.managedObjectContext];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backgroundContextChanged:) name:NSManagedObjectContextDidSaveNotification object:self.managedObjectContext];
    }
    return self;
}

-(void)mainContextChanged:(NSNotification *)notification {
    weakify(self);
    [self.backgroundManagedObjectContext performBlock:^{
        strongify(self);
        [self.backgroundManagedObjectContext mergeChangesFromContextDidSaveNotification:notification];
    }];
}

-(void)backgroundContextChanged:(NSNotification *)notification {
    weakify(self);
    [self.managedObjectContext performBlock:^{
        strongify(self);
        [self.managedObjectContext mergeChangesFromContextDidSaveNotification:notification];
    }];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - CoreData Model
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_localManagedObjectContext != nil) {
        return _localManagedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _localManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_localManagedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _localManagedObjectContext;
}

-(NSManagedObjectContext *)backgroundManagedObjectContext {
    if (!_localBackgroundManagedObjectContext) {
        _localBackgroundManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_localBackgroundManagedObjectContext setPersistentStoreCoordinator:self.managedObjectContext.persistentStoreCoordinator];
    }
    return _localBackgroundManagedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_localManagedObjectModel != nil) {
        return _localManagedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:AppName withExtension:@"momd"];
    _localManagedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _localManagedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_localPersistentStoreCoordinator != nil) {
        return _localPersistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", AppName]];
    
    NSError *error = nil;
    _localPersistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@YES,
                              NSInferMappingModelAutomaticallyOption:@YES};
    if (![_localPersistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
    }
    
    return _localPersistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
