//
//  LocalDataHandler.h
//  UIExtensionProject
//
//  Created by Tung Nguyen on 1/30/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataHandler.h"

@interface LocalDataHandler : NSObject

+(instancetype)getHandler;

-(void)getListUsersLocal:(ListUsersBlock)completion;
-(void)getUserLocal:(GetUserBlock)completion withName:(NSString *)name;
-(void)addUserLocal:(UserModel *)mUser completion:(SaveUserBlock)completion;
-(NSError *)addUserLocal:(UserModel *)mUser;

@end
