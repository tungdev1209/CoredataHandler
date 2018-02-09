//
//  UserDetailViewController.m
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/9/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "UserDetailViewController.h"
#import "ShowUserDetail.h"

@interface UserDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *ageLbl;

@end

@implementation UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUserInfor];
}

-(void)setUserInfor {
    self.nameLbl.text = _userDetail.name;
    self.ageLbl.text = [NSString stringWithFormat:@"%d", _userDetail.age];
}

- (IBAction)btnPressed:(id)sender {
    
}

@end
