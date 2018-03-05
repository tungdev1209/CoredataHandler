//
//  UserModel.m
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "UserModel.h"
#import "NSObject_Extension.h"
#import "ObservableObject+Private.h"
#import "DataHandler.h"

@interface UserModel()

@property (nonatomic, strong) User *user;

@end

@implementation UserModel

- (instancetype)initWithUser:(User *)user {
    self = [super init];
    if (self) {
        self.user = user;
        [self getDataFromObject:user];
    }
    return self;
}

-(void)didObserveKeypath:(NSString *)key {
    
}

+(void)get:(ListUsersBlock)completion {
    [[DataHandler shared] local_getListUsers:completion];
}

+(void)getUserWithName:(NSString *)name completion:(GetUserBlock)completion {
    [[DataHandler shared] local_getUserWithName:name completion:completion];
}

-(void)saveInBackground:(SaveUserBlock)completion {
    [[DataHandler shared] local_addUser:self completion:completion];
}

-(NSError *)save {
    return [[DataHandler shared] local_addUser:self];
}

@end
