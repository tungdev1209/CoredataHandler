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
    
    
}

-(NSMutableArray *)users {
    if (!_users) {
        _users = [[NSMutableArray alloc] init];
    }
    return _users;
}

- (IBAction)btnAddPressed:(id)sender {
    
}

#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
