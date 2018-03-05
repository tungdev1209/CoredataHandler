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
#import "LocalDataHandler.h"

@class UserModel;

@interface UserModel : ObservableObject

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t age;

-(instancetype _Nonnull )initWithUser:(User *_Nonnull)user;
+(void)get:(ListUsersBlock _Nullable )completion;
+(void)getUserWithName:(NSString * _Nonnull)name completion:(GetUserBlock _Nullable)completion;
-(void)saveInBackground:(SaveUserBlock _Nullable )completion;
-(NSError *_Nullable)save;

@end
