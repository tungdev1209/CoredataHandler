//
//  UserModel.h
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User+CoreDataProperties.h"
#import "ObservableObject.h"

@class UserModel;

typedef void(^SaveUserBlock)(BOOL succeed);
typedef void(^ListUsersBlock)(NSArray <UserModel *> * _Nonnull mUsers);
typedef void(^GetUserBlock)(UserModel * _Nullable mUser);

@interface UserModel : ObservableObject

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t age;

-(instancetype _Nonnull )initWithUser:(User *_Nonnull)user;
+(void)get:(ListUsersBlock _Nullable )completion;
+(void)getUserWithName:(NSString * _Nonnull)name completion:(GetUserBlock _Nullable)completion;
-(void)saveInBackground:(SaveUserBlock _Nullable )completion;
-(NSError *_Nullable)save;

@end
