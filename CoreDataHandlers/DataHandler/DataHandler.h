//
//  DataHandler.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface DataHandler : NSObject

+(instancetype)shared;

-(void)local_getListUsers:(ListUsersBlock)completion;
-(void)local_getUserWithName:(NSString *)name completion:(GetUserBlock)completion;
-(void)local_addUser:(UserModel *)mUser completion:(SaveUserBlock)completion;
-(NSError *)local_addUser:(UserModel *)mUser;

@end
