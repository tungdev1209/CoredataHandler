//
//  AddUserWireframe.m
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "AddUserWireframe.h"
#import "AddUserPresenter.h"

@implementation AddUserWireframe

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.presenter = [[AddUserPresenter alloc] init];
    }
    return self;
}

@end
