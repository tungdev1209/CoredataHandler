//
//  AddInteractor.m
//  CoreDataHandlers
//
//  Created by apple on 03/03/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "AddInteractor.h"

@interface AddInteractor()

@end

@implementation AddInteractor
@synthesize presenter;

- (void)addUserDetail:(AddUserDetail *)userDetail {
    [self.presenter didAddUser:![userDetail add]];
    
//    __weak typeof(self) weakSelf = self;
//    [userDetail add:^(BOOL succeed) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        [strongSelf.presenter didAddUser:succeed];
//    }];
}

@end
