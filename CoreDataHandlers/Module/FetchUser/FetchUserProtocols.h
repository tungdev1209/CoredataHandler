//
//  FetchUserProtocols.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FetchUserDetail.h"
#import "FetchUserListUserDetail.h"

@protocol FetchUserViewProtocol <NSObject>

-(void)updateListUsers;

@end

@protocol FetchUserPresenterWireframeProtocol <NSObject>


@end

@protocol FetchUserPresenterViewProtocol <NSObject>

-(void)showUserDetails:(FetchUserListUserDetail *)userDetails;

@end


@protocol FetchUserInteractorProtocol <NSObject>

-(void)receivedUserDetails:(FetchUserListUserDetail *)userDetails;

@end

@protocol FetchUserPresenterInteractorProtocol <NSObject>

-(void)setup:(id<FetchUserInteractorProtocol>)presenter;
-(void)fetchUsers;

@end

@protocol FetchUserWireframeProtocol <NSObject>

-(void)setup:(id<FetchUserPresenterViewProtocol>)view wireframe:(id<FetchUserPresenterWireframeProtocol>)wireframe;

@end
