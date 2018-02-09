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

-(void)getListUsersLocal:(ListUsersBlock)completion;
-(void)getUserLocalWith:(GetUserBlock)completion withName:(NSString *)name;
-(void)addUserLocal:(UserModel *)mUser completion:(SaveUserBlock)completion;

@end
