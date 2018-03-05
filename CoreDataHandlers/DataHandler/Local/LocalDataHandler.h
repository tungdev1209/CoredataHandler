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

+(instancetype _Nullable )getHandler;

-(void)getListUsers:(ListUsersBlock _Nullable)completion;
-(void)getUserWithName:(NSString * _Nonnull)name completion:(GetUserBlock _Nullable )completion;
-(void)addUser:(UserModel *_Nonnull )mUser completion:(SaveUserBlock _Nullable )completion;
-(NSError * _Nullable)addUser:(UserModel * _Nonnull)mUser;

@end
