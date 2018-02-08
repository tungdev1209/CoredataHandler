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

#import "UserModel.h"

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
        self.localHandler = [[LocalDataHandler alloc] init];
        self.remoteHandler = [[RemoteDataHandler alloc] init];
    }
    return self;
}

-(void)getListUsersLocal:(ListUsersBlock)completion {
    [self.localHandler getListUsersLocal:completion];
    
}

@end
