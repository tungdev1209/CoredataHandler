//
//  UserDetailViewController.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/9/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DismissProtocols.h"
#import "UpdateProtocols.h"
#import "FetchUserProtocols.h"

@protocol UserControllerProtocolInput <DismissPresenterViewProtocol, UpdatePresenterViewProtocol, FetchUserPresenterViewProtocol>
@end

@interface UserDetailViewController : UIViewController <UserControllerProtocolInput>

@property (nonatomic, copy) NSString *username;

@end
