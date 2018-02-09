//
//  AddUserDetail.m
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/9/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "AddUserDetail.h"

@implementation AddUserDetail

-(void)add:(SaveUserBlock)completion {
    UserModel *mUser = [[UserModel alloc] init];
    mUser.name = self.name;
    mUser.age = self.age;
    [mUser save:completion];
}

@end
