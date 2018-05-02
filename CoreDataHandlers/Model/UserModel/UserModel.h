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

#define Admin @"Admin"
#define Member @"Member"

#define AdminUser [UserModel shareUser]

@class UserModel;

@interface UserModel : ObservableObject

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSString *role;

+(instancetype)shareUser;
-(instancetype _Nonnull )initWithUser:(User *_Nonnull)user;
-(User *)getCoreUser;

@end
