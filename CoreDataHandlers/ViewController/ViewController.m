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
@property (nonatomic, strong) NSMutableArray *users;

@end

@implementation ViewController

@synthesize presenterFetch;
@synthesize presenterAdd;
@synthesize presenterShow;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([MyTableViewCell class]) bundle:[NSBundle mainBundle]];
    [_userTbl registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    [self.presenterFetch updateListUsers];
}

-(NSMutableArray *)users {
    if (!_users) {
        _users = [[NSMutableArray alloc] init];
    }
    return _users;
}

- (IBAction)btnAddPressed:(id)sender {
    __block NSString *name;
    __block int16_t age;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"CoreData app" message:@"Add new user" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"name";
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"age";
    }];
    
    weakify(self);
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        name = [alert.textFields.firstObject text];
        age = [[alert.textFields[1] text] intValue];
        
        strongify(self);
        AddUserDetail *userDetail = [[AddUserDetail alloc] init];
        userDetail.name = name;
        userDetail.age = age;
        [self.presenterAdd addUserDetail:userDetail];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - ShowUser Presenter protocol

#pragma mark - AddUser Presenter protocol
-(void)showAlertAddingFail {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"CoreData app" message:@"Adding fail!" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)refreshList {
    [self.presenterFetch updateListUsers];
}

#pragma mark - FetchUser Presenter protocol
-(void)showUserDetails:(FetchUserListUserDetail *)userDetails {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.users removeAllObjects];
        [self.users addObjectsFromArray:userDetails.listUsers];
        [self.userTbl reloadData];
    });
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
    FetchUserDetail *mUser = [self.users objectAtIndex:indexPath.row];
    [self.presenterShow showUserDetail:mUser.name];
}

@end
