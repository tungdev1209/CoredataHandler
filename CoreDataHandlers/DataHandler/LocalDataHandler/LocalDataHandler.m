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

-(void)getListUsersLocal:(ListUsersBlock)completion {
    
}

-(void)getUserLocal:(GetUserBlock)completion withName:(NSString *)name {
    
}

-(void)addUserLocal:(UserModel *)mUser completion:(SaveUserBlock)completion {
    
}

-(NSError *)addUserLocal:(UserModel *)mUser {
    return nil;
}

@end
