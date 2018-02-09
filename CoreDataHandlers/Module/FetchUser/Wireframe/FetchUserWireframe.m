//
//  FetchUserWireframe.m
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "FetchUserWireframe.h"
#import "FetchUserPresenter.h"

@interface FetchUserWireframe() 

@end

@implementation FetchUserWireframe

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.presenter = [[FetchUserPresenter alloc] init];
    }
    return self;
}

@end
