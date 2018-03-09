//
//  CoreDataStack_iOS10.m
//  eLearning
//
//  Created by Tung Nguyen on 1/31/18.
//  Copyright © 2018 Joz. All rights reserved.
//

#import "CoreDataStack_iOS10.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"

@interface CoreDataStack_iOS10 ()

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic, strong) NSManagedObjectContext *backgroundContext;

@end

@implementation CoreDataStack_iOS10

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;
- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            
            NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", AppName]]; //[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
            
            NSPersistentStoreDescription *description = [[NSPersistentStoreDescription alloc] initWithURL:storeURL];
            description.shouldInferMappingModelAutomatically = YES;
            description.shouldMigrateStoreAutomatically = YES;
            
//            [description setOption:NSFileProtectionComplete forKey:NSPersistentStoreFileProtectionKey];
            
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:AppName];
            [_persistentContainer setPersistentStoreDescriptions:@[description]];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(NSManagedObjectContext *)managedObjectContext {
    return self.persistentContainer.viewContext;
}

-(NSManagedObjectContext *)backgroundManagedObjectContext {
    if (!_backgroundContext) {
        _backgroundContext = [self.persistentContainer newBackgroundContext];
    }
    return _backgroundContext;
}

-(NSManagedObjectModel *)managedObjectModel {
    return self.persistentContainer.managedObjectModel;
}

-(NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    return self.persistentContainer.persistentStoreCoordinator;
}

@end
#pragma clang diagnostic pop

