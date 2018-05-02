//
//  LocalDataHandler.m
//  UIExtensionProject
//
//  Created by Tung Nguyen on 1/30/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "LocalDataHandler.h"
#import "CoreDataHandler.h"
#import "NSObject_Extension.h"
#import "UserModel.h"
#import "User+CoreDataProperties.h"

typedef enum : NSUInteger {
    LocalDataHandlerTypeCoredata,
    LocalDataHandlerTypeOther,
} LocalDataHandlerType;

#define LocalDataType LocalDataHandlerTypeCoredata

@interface LocalDataHandler()

@end

@implementation LocalDataHandler

+ (instancetype)getHandler
{
    if (LocalDataType == LocalDataHandlerTypeCoredata) {
        return [[CoreDataHandler alloc] init];
    }
    else {
        return nil;
    }
}

-(void)getListUsers:(ListUsersBlock)completion {
    
}

-(void)getUserWithPredicate:(NSPredicate *)predicate completion:(GetUserBlock)completion {
    
}

-(void)getListUsersWithPredicate:(NSPredicate *)predicate completion:(ListUsersBlock)completion {
    
}

-(void)addUser:(UserModel *)mUser completion:(SaveUserBlock)completion {
    
}

-(NSError *)addUser:(UserModel *)mUser {
    return nil;
}

-(void)updateUser:(UserModel *)mUser completion:(SaveUserBlock)completion {
    
}

@end
