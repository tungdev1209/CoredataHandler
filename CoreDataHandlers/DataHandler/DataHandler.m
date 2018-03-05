//
//  DataHandler.m
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "DataHandler.h"
#import "LocalDataHandler.h"
#import "RemoteDataHandler.h"

@interface DataHandler ()

@property (nonatomic, strong) RemoteDataHandler *remoteHandler;
@property (nonatomic, strong) LocalDataHandler *localHandler;

@end

@implementation DataHandler

+(instancetype)shared {
    static dispatch_once_t onceToken;
    static DataHandler *h = nil;
    dispatch_once(&onceToken, ^{
        h = [[DataHandler alloc] init];
    });
    return h;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.localHandler = [LocalDataHandler getHandler];
        self.remoteHandler = [RemoteDataHandler getHandler];
    }
    return self;
}

#pragma mark - Local funcs
-(void)local_getUserWithName:(NSString *)name completion:(GetUserBlock)completion {
    [self.localHandler getUserWithName:name completion:completion];
}

-(void)local_getListUsers:(ListUsersBlock)completion {
    [self.localHandler getListUsers:completion];
}

-(NSError *)local_addUser:(UserModel *)mUser {
    return [self.localHandler addUser:mUser];
}

-(void)local_addUser:(UserModel *)mUser completion:(SaveUserBlock)completion {
    [self.localHandler addUser:mUser completion:completion];
}

@end
