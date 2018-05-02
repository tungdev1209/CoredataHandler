//
//  CleanBag.m
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 4/29/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "CleanBag.h"
#import "ObservableObject+Private.h"

@implementation CleanBag

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bagId = [CleanBag getRunTimeId];
    }
    return self;
}

static dispatch_queue_t getUUIDQueue() {
    static dispatch_once_t onceToken;
    static dispatch_queue_t theQueue = nil;
    dispatch_once(&onceToken, ^{
        theQueue = dispatch_queue_create("com.elearning.observable.cleanbag", DISPATCH_QUEUE_SERIAL);
    });
    return theQueue;
}

//http://stackoverflow.com/questions/9015784/how-to-create-uuid-type-1-in-objective-c-ios/9015962#9015962
+(NSString *)getUUIDType1 {
    __block NSString *uuid1;
    dispatch_sync(getUUIDQueue(), ^{
        // Get UUID type 1
        
        uuid_t dateUUID;
        uuid_generate_time(dateUUID);
        
        // Convert it to string
        
        uuid_string_t unparsedUUID;
        uuid_unparse_lower(dateUUID, unparsedUUID);
        uuid1 = [[NSString alloc] initWithUTF8String:unparsedUUID];
    });
    return uuid1;
}

+(NSString *)getRunTimeId {
    return [CleanBag getUUIDType1];
}

-(NSHashTable *)subcribers {
    if (!_subcribers) {
        _subcribers = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsWeakMemory capacity:20];
    }
    return _subcribers;
}

-(void)removeAllSubcribers {
    [self.subcribers removeAllObjects];
}

-(void)registerSubcriberObject:(Subcriber *)sub {
    [self.subcribers addObject:sub];
}

-(void)dealloc {
    NSLog(@"CleanBag === DEALLOC");
    for (Subcriber *sub in self.subcribers.allObjects) {
        sub.bag = nil;
    }
}

@end
