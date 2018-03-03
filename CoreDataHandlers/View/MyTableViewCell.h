//
//  MyTableViewCell.h
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchProtocols.h"

@interface MyTableViewCell : UITableViewCell

@property (nonatomic, strong) FetchUserDetail *userDetail;

@end
