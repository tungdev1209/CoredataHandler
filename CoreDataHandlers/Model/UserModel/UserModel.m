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

@interface UserModel()

@property (nonatomic, strong) User *user;

@end

@implementation UserModel

- (instancetype)initWithUser:(User *)user {
    self = [super init];
    if (self) {
        self.user = user;
        [self syncDataWithObject:user];
    }
    return self;
}

-(void)didObserveKeypath:(NSString *)key {
    
}

@end
