//
//  ShowUserProtocols.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/9/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowUserDetail.h"

@protocol ShowUserViewProtocol <NSObject>

-(void)showUserDetail:(NSString *)name;

@end

@protocol ShowUserInteractorProtocol <NSObject>

-(void)didGetUserDetail:(ShowUserDetail *)userDetail;

@end

@protocol ShowUserPresenterViewProtocol <NSObject>

@end

@protocol ShowUserPresenterWireframeProtocol <NSObject>

-(void)showUserDetailScreen:(ShowUserDetail *)userDetail;

@end

@protocol ShowUserPresenterInteractorProtocol <NSObject>

-(void)setup:(id<ShowUserInteractorProtocol>)presenter;
-(void)getUserDetailWithName:(NSString *)name;

@end

@protocol ShowUserWireframeProtocol <NSObject>

-(void)setup:(id<ShowUserPresenterViewProtocol>)view wireframe:(id<ShowUserPresenterWireframeProtocol>)wireframe;

@end
