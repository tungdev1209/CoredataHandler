//
//  Subcriber.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 4/29/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObservableObject.h"
#import "CleanBag.h"

@interface Subcriber: NSObject

@property (nonatomic, strong) SubcribeBlock subBlock;

-(void)cleanupBy:(CleanBag * _Nonnull)bag;

@end
