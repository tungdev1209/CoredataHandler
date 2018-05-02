//
//  DataHandler.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;

typedef void(^SaveUserBlock)(BOOL succeed, UserModel *user);
typedef void(^ListUsersBlock)(NSArray <UserModel *> * _Nonnull mUsers);
typedef void(^GetUserBlock)(UserModel * _Nullable mUser);

@interface DataHandler : NSObject

+(instancetype _Nonnull )shared;

-(void)local_getUserWithPredicate:(NSPredicate * _Nullable)predicate completion:(GetUserBlock _Nullable)completion;
-(void)local_getListUsersWithPredicate:(NSPredicate * _Nullable)predicate completion:(ListUsersBlock _Nullable)completion;
-(void)local_addUser:(UserModel * _Nonnull)mUser completion:(SaveUserBlock _Nullable)completion;
-(void)local_updateUser:(UserModel * _Nonnull)mUser completion:(SaveUserBlock _Nullable)completion;
-(NSError * _Nullable)local_addUser:(UserModel * _Nonnull)mUser;

@end
