//
//  CoreDataHandler.h
//  UIExtensionProject
//
//  Created by Tung Nguyen on 1/30/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void(^FetchResultsBlock)(NSArray *);
typedef void(^SaveResultsBlock)(NSError *);

@interface CoreDataHandler : NSObject

-(void)fetchEntries:(NSFetchRequest *)fetchRequest
      withPredicate:(NSPredicate *)predicate
    sortDescriptors:(NSArray *)sortDescriptors
    completionBlock:(FetchResultsBlock)completionBlock;

-(void)saveEntry:(SaveResultsBlock)result;
-(NSManagedObject *)newEntry:(Class)entryClass;

@end
