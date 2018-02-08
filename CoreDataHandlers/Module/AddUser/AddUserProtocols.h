//
//  AddUserProtocols.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/9/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddUserDetail.h"

@protocol AddUserViewProtocol <NSObject>

-(void)setup:(id)view;
-(void)addUserDetail:(AddUserDetail *)userDetail;

@end

@protocol AddUserWireframeProtocol <NSObject>

@end

@protocol AddUserInteractorProtocol <NSObject>

-(void)addedUser:(BOOL)result;

@end

@protocol AddUserPresenterInteractorProtocol <NSObject>

-(void)addUserDetail:(AddUserDetail *)userDetail;

@end

@protocol AddUserPresenterWireframeProtocol <NSObject>


@end

@protocol AddUserPresenterViewProtocol <NSObject>

-(void)showAlertAddingFail;
-(void)refreshList;

@end
