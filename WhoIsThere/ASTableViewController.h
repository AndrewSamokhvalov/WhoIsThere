//
//  ASTableViewController.h
//  WhoIsThere
//
//  Created by Наталья Дидковская on 26.06.14.
//  Copyright (c) 2014 Andrey Samokhvalov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASTableViewController :  UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property NSArray *tableData;


@end
