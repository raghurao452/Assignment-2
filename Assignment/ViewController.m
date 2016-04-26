//
//  ViewController.m
//  Assignment
//
//  Created by Raghavendher on 26/04/16.
//  Copyright © 2016 J. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "AbbreviationModel.h"
#import "LFModel.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface ViewController ()<UISearchResultsUpdating,UISearchBarDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic,strong) AbbreviationModel *abbModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    self.definesPresentationContext = YES;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.abbModel.longForms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [self.abbModel.longForms objectAtIndex:indexPath.row].longForm;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Frequency : %@",[self.abbModel.longForms objectAtIndex:indexPath.row].frequency.stringValue];
    return cell;
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self searchText:searchBar.text];
}

-(UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    }
    return _searchController;
}

- (void)searchText:(NSString *)text
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *serializer =[AFHTTPRequestSerializer serializer];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/JSON"];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    serializer.timeoutInterval = 120;
    [manager setRequestSerializer:serializer];
    [manager GET:@"http://www.nactem.ac.uk/software/acromine/dictionary.py" parameters:@{@"sf":text} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"success");

        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.abbModel = [[AbbreviationModel alloc] initWithArray:responseObject];
            [self.tableView reloadData];
            
        });
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSData *errorData = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (errorData) {
            NSError *jsonError;
            NSArray *parsedData = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingAllowFragments error:&jsonError];
            if (parsedData && jsonError == nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    self.abbModel = [[AbbreviationModel alloc] initWithArray:parsedData];
                    [self.tableView reloadData];
                });
            }
        }
    }];
}


@end
