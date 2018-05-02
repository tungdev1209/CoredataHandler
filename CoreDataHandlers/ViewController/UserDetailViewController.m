//
//  UserDetailViewController.m
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/9/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "UserDetailViewController.h"

@interface UserDetailViewController ()

@property (nonatomic, strong) UserModel *userDetail;

@property (weak, nonatomic) IBOutlet UITextView *nameTxt;
@property (weak, nonatomic) IBOutlet UITextView *ageTxt;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *deallocBagButton;

@property (nonatomic, strong) CleanBag *myBag;

@end

@implementation UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.ageTxt.keyboardType = UIKeyboardTypeNumberPad;
    
    self.myBag = [[CleanBag alloc] init];
    weakify(self);
    [[AdminUser subcribeKeySelector:@selector(name) binding:^(NSString * _Nonnull keypath, id  _Nullable value) {
        dispatch_async(dispatch_get_main_queue(), ^{
            strongify(self);
            self.nameLabel.text = value;
        });
    }] cleanupBy:self.myBag];
    
    [self.presenterFetchUser getUserDetail:self.username];
}

- (IBAction)btnDeallocBagPressed:(id)sender {
    if (self.myBag) {
        self.myBag = nil;
    }
    else {
        self.myBag = [[CleanBag alloc] init];
    }
}

-(void)showUserDetail:(UserModel *)user {
    _userDetail = user;
    [self setUserInfor];
}

-(void)setUserInfor {
    self.nameTxt.text = _userDetail.name;
    self.ageTxt.text = [NSString stringWithFormat:@"%d", _userDetail.age];
}

-(void)showFailAlert:(NSString *)message {
    NSLog(@">>>>>>> update fail");
    [self.presenterDismiss shouldDimissVC];
}

-(void)showSuccessAlert {
    NSLog(@">>>>>>> update succeed");
    [self.presenterDismiss shouldDimissVC];
}

- (IBAction)updatePressed:(id)sender {
    self.userDetail.name = self.nameTxt.text;
    self.userDetail.age = self.ageTxt.text.intValue;
    [self.presenterUpdate updateUserDetail:self.userDetail];
}

- (IBAction)dismissPressed:(id)sender {
    [self.presenterDismiss shouldDimissVC];
}

@synthesize presenterDismiss;
@synthesize presenterUpdate;
@synthesize presenterFetchUser;

@end
