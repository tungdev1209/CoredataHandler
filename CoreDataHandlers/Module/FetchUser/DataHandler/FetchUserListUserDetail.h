//
//  FetchUserListUserDetail.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/9/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FetchUserListUserDetail;

typedef void(^ListUserDetailBlock)(FetchUserListUserDetail *listUsers);

@interface FetchUserListUserDetail : NSObject

@property (nonatomic, strong) NSMutableArray *listUsers;

+(void)get:(ListUserDetailBlock)completion;

@end
