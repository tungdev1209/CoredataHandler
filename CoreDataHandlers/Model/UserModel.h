//
//  UserModel.h
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObservableObject.h"

@interface UserModel : ObservableObject

@property (nonatomic, copy) NSString *name;


@end
