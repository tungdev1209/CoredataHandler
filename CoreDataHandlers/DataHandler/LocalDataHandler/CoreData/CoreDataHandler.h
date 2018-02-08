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

@interface CoreDataHandler : NSObject

+(instancetype)shared;

-(void)fetchEntries:(NSFetchRequest *)fetchRequest
      withPredicate:(NSPredicate *)predicate
    sortDescriptors:(NSArray *)sortDescriptors
    completionBlock:(FetchResultsBlock)completionBlock;

@end
