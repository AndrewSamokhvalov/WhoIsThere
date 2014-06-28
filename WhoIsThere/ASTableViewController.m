//
//  ASTableViewController.m
//  WhoIsThere
//
//  Created by Наталья Дидковская on 26.06.14.
//  Copyright (c) 2014 Andrey Samokhvalov. All rights reserved.
//

#import "ASTableViewController.h"
#import "Constants.h"

@interface ASTableViewController ()

@end

@implementation ASTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    
    _update = [NSTimer scheduledTimerWithTimeInterval:5.0f
                                               target:self
                                             selector:@selector(updateTableView:)
                                             userInfo:nil
                                              repeats:YES];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) updateTableView:(NSTimer*) timer {
    
    PFQuery *query = [PFQuery queryWithClassName: GROUP_NAME];
    NSArray *pfobjects = [query findObjects];
    NSMutableArray *mobileId = [NSMutableArray array];
    
    for (PFObject *object in pfobjects) {
        
        [mobileId addObject: object[COLONE_NAME]];
        
    }
    
    _tableData = mobileId;
    [self.tableView reloadData];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [_tableData objectAtIndex:indexPath.row];
    
    return cell;
}

- (void) viewDidDisappear:(BOOL)animated {
    
    [_update invalidate];
    
}

@end
