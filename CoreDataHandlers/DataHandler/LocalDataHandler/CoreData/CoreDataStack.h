//
//  CoreDataStack.h
//  eLearning
//
//  Created by Tung Nguyen on 1/31/18.
//  Copyright © 2018 Joz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define _AppCoredataStack [CoreDataStack shared]

@interface CoreDataStack : NSObject

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(instancetype)shared;

@end
