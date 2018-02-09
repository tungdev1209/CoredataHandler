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

-(void)addUserDetail:(AddUserDetail *)userDetail;

@end

@protocol AddUserInteractorProtocol <NSObject>

-(void)addedUser:(BOOL)result;

@end



@protocol AddUserPresenterWireframeProtocol <NSObject>


@end

@protocol AddUserPresenterViewProtocol <NSObject>

-(void)showAlertAddingFail;
-(void)refreshList;

@end

@protocol AddUserPresenterInteractorProtocol <NSObject>

-(void)addUserDetail:(AddUserDetail *)userDetail;
-(void)setup:(id<AddUserInteractorProtocol>)presenter;

@end

@protocol AddUserWireframeProtocol <NSObject>

-(void)setup:(id<AddUserPresenterViewProtocol>)view wireframe:(id<AddUserPresenterWireframeProtocol>)wireframe;

@end
