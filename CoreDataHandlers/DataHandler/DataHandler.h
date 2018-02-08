//
//  DataHandler.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;

typedef void(^ListUsersBlock)(NSArray <UserModel *> *mUsers);
typedef void(^AddUserBlock)(BOOL);

@interface DataHandler : NSObject

+(instancetype)shared;

-(void)getListUsersLocal:(ListUsersBlock)completion;
-(void)addUserLocal:(UserModel *)mUser completion:(AddUserBlock)completion;

@end
