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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [_userTbl registerClass:[MyTableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [self.fetchUserPresenter updateListUsers];
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
    
    __weak typeof(self) weakSelf = self;
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        name = [alert.textFields.firstObject text];
        age = [[alert.textFields[1] text] intValue];
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        AddUserDetail *userDetail = [[AddUserDetail alloc] init];
        userDetail.name = name;
        userDetail.age = age;
        [strongSelf.addUserPresenter addUserDetail:userDetail];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - AddUser Presenter protocol
-(void)showAlertAddingFail {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"CoreData app" message:@"Adding fail!" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)refreshList {
    [self.fetchUserPresenter updateListUsers];
}

#pragma mark - FetchUser Presenter protocol
-(void)showUserDetails:(FetchUserListUserDetail *)userDetails {
    [self.users removeAllObjects];
    [self.users addObjectsFromArray:userDetails.listUsers];
    [self.userTbl reloadData];
}

#pragma mark - Root
-(void)startup:(NSArray *)dependencies {
    for (id dependency in dependencies) {
        if ([dependency conformsToProtocol:@protocol(FetchUserViewProtocol)]) {
            self.fetchUserPresenter = dependency;
            [(id<FetchUserViewProtocol>)dependency setup:self];
        }
        else if ([dependency conformsToProtocol:@protocol(AddUserViewProtocol)]) {
            self.addUserPresenter = dependency;
            [(id<AddUserViewProtocol>)dependency setup:self];
        }
    }
}

#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell setUserDetail:[self.users objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
