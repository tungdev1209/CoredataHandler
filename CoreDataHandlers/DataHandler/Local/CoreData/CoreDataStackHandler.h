//
//  CoreDataStackHandler.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 3/5/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void(^FetchResultsBlock)(NSArray *_Nullable);
typedef void(^SaveResultsBlock)(NSError *_Nullable);

@interface CoreDataStackHandler : NSObject

// Fetching
- (void)fetchEntries:(NSFetchRequest *_Nullable)fetchRequest
       withPredicate:(NSPredicate *_Nullable)predicate
     sortDescriptors:(NSArray *_Nullable)sortDescriptors
     completionBlock:(FetchResultsBlock _Nullable)completionBlock;
- (NSArray *_Nullable)fetchEntries:(NSFetchRequest *_Nullable)fetchRequest
            withPredicate:(NSPredicate *_Nullable)predicate
          sortDescriptors:(NSArray *_Nullable)sortDescriptors;

// Insert new entry
- (NSManagedObject *_Nonnull)newEntry:(Class _Nullable )entryClass;
- (NSManagedObject *_Nonnull)newBackgroundEntry:(Class _Nullable )entryClass;

// Saving
- (NSError *_Nullable)saveEntry:(NSManagedObject *_Nullable)object;
- (void)saveEntry:(NSManagedObject *_Nullable)object completion:(SaveResultsBlock _Nullable )result;

@end
