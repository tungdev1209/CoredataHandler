//
//  UpdateInteractor.m
//  CoreDataHandlers
//
//  Created by apple on 04/30/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "UpdateInteractor.h"

@interface UpdateInteractor()

@end

@implementation UpdateInteractor
@synthesize presenter;

-(void)updateUserDetail:(UserModel *)user {
    weakify(self);
    [[DataHandler shared] local_updateUser:user completion:^(BOOL succeed, UserModel *user) {
        strongify(self);
        [self.presenter didUpdateUserDetail:succeed];
    }];
}

@end
