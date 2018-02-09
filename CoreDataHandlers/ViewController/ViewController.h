//
//  ViewController.h
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootProtocols.h"
#import "FetchUserProtocols.h"
#import "AddUserProtocols.h"
#import "ShowUserProtocols.h"

@interface ViewController : UIViewController <RootViewProtocol, FetchUserPresenterViewProtocol, AddUserPresenterViewProtocol, ShowUserPresenterViewProtocol>

@property (nonatomic, strong) id<FetchUserViewProtocol> fetchUserPresenter;
@property (nonatomic, strong) id<AddUserViewProtocol> addUserPresenter;
@property (nonatomic, strong) id<ShowUserViewProtocol> showUserPresenter;

@end

