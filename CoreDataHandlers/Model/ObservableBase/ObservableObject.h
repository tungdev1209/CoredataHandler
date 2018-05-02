//
//  ObservableObject.h
//  eLearning
//
//  Created by Tung Nguyen on 2/2/18.
//  Copyright © 2018 Joz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Subcriber;

typedef void(^SubcribeBlock)(NSString *_Nonnull keypath, id _Nullable value);

@interface ObservableObject : NSObject

-(ObservableObject *_Nonnull)syncupWithObject:(ObservableObject *_Nonnull)object;
-(ObservableObject *_Nonnull)removeSyncupObject;
-(Subcriber *_Nonnull)subcribe:(SubcribeBlock _Nonnull)subcriber;
-(Subcriber *_Nonnull)subcribeKeySelector:(SEL _Nonnull)propertySelector binding:(SubcribeBlock _Nonnull)subcriber;

@end
