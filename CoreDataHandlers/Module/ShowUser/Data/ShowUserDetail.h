//
//  ShowUserDetail.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/9/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataHandler.h"

@interface ShowUserDetail : NSObject

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t age;

+(void)get:(void(^)(ShowUserDetail *))completion withName:(NSString *)name;

@end
