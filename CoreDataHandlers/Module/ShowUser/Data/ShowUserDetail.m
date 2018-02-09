//
//  ShowUserDetail.m
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/9/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "ShowUserDetail.h"
#import "NSObject_Extension.h"
#import "DataHandler.h"

@implementation ShowUserDetail

+(void)get:(void(^)(ShowUserDetail *))completion withName:(NSString *)name {
    [UserModel getUser:^(UserModel * _Nullable mUser) {
        ShowUserDetail *userDetail = [[ShowUserDetail alloc] init];
        [userDetail getDataFromObject:mUser];
        if (completion) {
            completion(userDetail);
        }
    } withName:name];
}

@end
