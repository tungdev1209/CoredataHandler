//
//  MyTableViewCell.m
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "MyTableViewCell.h"

@interface MyTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *ageLbl;


@end

@implementation MyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUserDetail:(FetchUserDetail *)userDetail {
    self.nameLbl.text = userDetail.name;
    self.ageLbl.text = [NSString stringWithFormat:@"%d", userDetail.age];
}

@end
