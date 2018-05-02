//
//  ViewController.m
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *userTbl;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (nonatomic, strong) NSMutableArray *users;

@property (nonatomic, strong) CleanBag *myBag;

@end

@implementation ViewController

@synthesize presenterAdd;
@synthesize presenterShow;
@synthesize presenterFetchUser;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([MyTableViewCell class]) bundle:[NSBundle mainBundle]];
    [_userTbl registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed:)];
    tap.numberOfTapsRequired = 1;
    [_userLabel setUserInteractionEnabled:YES];
    [_userLabel addGestureRecognizer:tap];
    
    self.myBag = [[CleanBag alloc] init];
    weakify(self);
    [[AdminUser subcribeKeySelector:@selector(name) binding:^(NSString * _Nonnull keypath, id  _Nullable value) {
        dispatch_async(dispatch_get_main_queue(), ^{
            strongify(self);
            self.userLabel.text = value;
        });
    }] cleanupBy:self.myBag];
    
    [self getAdminAccount];
}

-(void)getAdminAccount {
    [self.presenterFetchUser getUserDetailWithRole:Admin];
}

- (void)registerAdmin {
    weakify(self);
    [self showAlertAddUser:^(AddUserDetail *userDetail){
        strongify(self);
        userDetail.role = Admin;
        [self.presenterAdd addUserDetail:userDetail];
    } message:@"Register Admin" cancel:NO];
}

- (void)showAdminDetail:(UserModel *)user {
    [self.presenterFetchUser getListUsersDetailWithRole:Member];
}

-(NSMutableArray *)users {
    if (!_users) {
        _users = [[NSMutableArray alloc] init];
    }
    return _users;
}

-(void)tapPressed:(UITapGestureRecognizer *)tapGesture {
    [self.presenterShow showUserDetail:_userLabel.text];
}

- (IBAction)btnAddPressed:(id)sender {
    weakify(self);
    [self showAlertAddUser:^(AddUserDetail *userDetail){
        strongify(self);
        userDetail.role = Member;
        [self.presenterAdd addUserDetail:userDetail];
    } message:@"Add new user" cancel:YES];
}

-(void)showAlertAddUser:(void(^)(AddUserDetail *))actionBlock message:(NSString *)alertMessage cancel:(BOOL)cancel {
    __block NSString *name;
    __block int16_t age;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"CoreData app" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"name";
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"age";
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        name = [alert.textFields.firstObject text];
        age = [[alert.textFields[1] text] intValue];
        
        AddUserDetail *userDetail = [[AddUserDetail alloc] init];
        userDetail.name = name;
        userDetail.age = age;
        
        actionBlock(userDetail);
    }]];
    
    if (cancel) {
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - ShowUser Presenter protocol

#pragma mark - AddUser Presenter protocol
-(void)showAlertAddingFailWithUser:(UserModel *)userDetail {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"CoreData app" message:@"Adding fail!" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)didAddUser:(UserModel *)user {
    
}

-(void)refreshListMembers {
    [self.presenterFetchUser getListUsersDetailWithRole:Member];
}

-(void)getListMembers {
    [self.presenterFetchUser getListUsersDetailWithRole:Member];
}

#pragma mark - FetchUser Presenter protocol
-(void)showListUsersDetail:(NSArray<UserModel *> *)users role:(NSString *)role {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.users removeAllObjects];
        [self.users addObjectsFromArray:users];
        [self.userTbl reloadData];
    });
}

- (void)showUserDetail:(UserModel *)user {
    
}

#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell setUserDetail:[self.users objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserModel *mUser = [self.users objectAtIndex:indexPath.row];
    [self.presenterShow showUserDetail:mUser.name];
}

@end
