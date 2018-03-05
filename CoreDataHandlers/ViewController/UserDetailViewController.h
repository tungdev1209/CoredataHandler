//
//  UserDetailViewController.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/9/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DimissProtocols.h"
@class UserModel;

@protocol UserControllerProtocolInput <DimissPresenterViewProtocol>
@end

@interface UserDetailViewController : UIViewController <UserControllerProtocolInput>

@property (nonatomic, strong) UserModel *userDetail;

@end
