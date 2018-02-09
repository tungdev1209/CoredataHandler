//
//  ShowUserWireframe.m
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/9/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "ShowUserWireframe.h"
#import "ShowUserPresenter.h"
#import "RootWireframe.h"

@implementation ShowUserWireframe

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.presenter = [[ShowUserPresenter alloc] init];
    }
    return self;
}

-(void)showUserDetailScreen:(ShowUserDetail *)userDetail {
    [[RootWireframe shared] showUserDetailVCFromRoot:userDetail];
}

@end
