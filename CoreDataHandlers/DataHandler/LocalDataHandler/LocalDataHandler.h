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

-(void)getListUsersLocal:(ListUsersBlock)completion;
-(void)addUserLocal:(UserModel *)mUser completion:(AddUserBlock)completion;

@end
