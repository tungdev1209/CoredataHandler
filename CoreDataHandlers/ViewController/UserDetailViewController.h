//
//  UserDetailViewController.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/9/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserModel;

@protocol UserControllerProtocolInput <NSObject>
@end

@interface UserDetailViewController : UIViewController <UserControllerProtocolInput>

@property (nonatomic, strong) UserModel *userDetail;

@end
