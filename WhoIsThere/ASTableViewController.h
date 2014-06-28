//
//  ASTableViewController.h
//  WhoIsThere
//
//  Created by Наталья Дидковская on 26.06.14.
//  Copyright (c) 2014 Andrey Samokhvalov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ASTableViewController :  UITableViewController <UITableViewDelegate, UITableViewDataSource> {
    
    NSTimer *_update;
}

@property NSArray *tableData;


@end
