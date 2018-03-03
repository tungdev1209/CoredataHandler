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

-(void)getListUsersLocal:(ListUsersBlock)completion {
    [self.localHandler getListUsersLocal:completion];
}

-(void)getUserLocalWith:(GetUserBlock)completion withName:(NSString *)name {
    [self.localHandler getUserLocal:completion withName:name];
}

-(void)addUserLocal:(UserModel *)mUser completion:(SaveUserBlock)completion {
    [self.localHandler addUserLocal:mUser completion:completion];
}

-(NSError *)addUserLocal:(UserModel *)mUser {
    return [self.localHandler addUserLocal:mUser];
}

@end
