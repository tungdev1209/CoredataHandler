//
//  FetchUserProtocols.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FetchUserDetail.h"

@protocol FetchUserViewProtocol <NSObject>

-(void)setup:(id)view;
-(void)updateListUsers;

@end

@protocol FetchUserPresenterInteractorProtocol <NSObject>

-(void)fetchUsers;

@end

@protocol FetchUserPresenterWireframeProtocol <NSObject>


@end

@protocol FetchUserPresenterViewProtocol <NSObject>

-(void)showUserDetails:(NSArray <FetchUserDetail *> *)userDetails;

@end

@protocol FetchUserWireframeProtocol <NSObject>

@end

@protocol FetchUserInteractorProtocol <NSObject>

-(void)receivedUserDetails:(NSArray *)userDetails;

@end
