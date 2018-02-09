//
//  AddUserDetail.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/9/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface AddUserDetail : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int16_t age;

-(void)add:(SaveUserBlock)completion;

@end
