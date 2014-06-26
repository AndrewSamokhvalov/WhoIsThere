//
//  ASViewController.m
//  WhoIsThere
//
//  Created by Наталья Дидковская on 25.06.14.
//  Copyright (c) 2014 Andrey Samokhvalov. All rights reserved.
//

#import "ASViewController.h"
#import "ASPlayer.h"

#import "ASTableViewController.h"
#import "Constants.h"
#import <Parse/Parse.h>

@interface ASViewController ()
@end

@implementation ASViewController 

- (void)viewDidLoad
{
    _player = [[ASPlayer alloc] init];
    
    _seconds = SECONDS_ONLINE;
    
    int min = _seconds / 60;
    int sec = _seconds % 60;
    NSString *time = [NSString stringWithFormat:@"%01d : %02d",min,sec];
    [_labelTime setText:time];
    
    _online = [[ASControllerOnline alloc] init];
    _online.controller = self;
    _offline = [[ASControllerOffline alloc] init];
    _offline.controller = self;
    
    _state = _offline;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)switchMethod:(id)sender {
    
    [_state switchState];
    
}

- (void) switch2offline:(NSTimer *)theTimer{
    
    [_state offline];
    _state = _offline;
    [_player.state switchState];
    
}

- (void)updateTimer:(NSTimer *)theTimer {
    
    _elapsedSeconds = (int)CFAbsoluteTimeGetCurrent() - (int)_startTime;
    if (_seconds - _elapsedSeconds > 0) {
        
        int min = (_seconds - _elapsedSeconds) / 60;
        int sec = (_seconds - _elapsedSeconds) % 60;
        
        [_labelTime setText:[NSString stringWithFormat:@"%01d : %02d",min,sec]];
        
    } else {
        
        _elapsedSeconds = 0;
        [_timer invalidate];
        
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"v2tv"]){
        
        ASTableViewController *tc = (ASTableViewController *)segue.destinationViewController;
        
        PFQuery *query = [PFQuery queryWithClassName: GROUP_NAME];
        
        NSArray *pfobjects = [query findObjects];
        NSMutableArray *mobileId = [NSMutableArray array];
        
        for (PFObject *object in pfobjects) {
            
            [mobileId addObject: object[COLONE_NAME]];
            
        }
        
        tc.tableData = mobileId;
        
    }
}

@end

#pragma mark -
#pragma mark ASStates

@implementation ASControllerOffline
@synthesize controller = _controller;

- (void) switchState {
    
    [self online];
    _controller.state = _controller.online;
    [_controller.player.state switchState];
    
}

- (void) offline {}
- (void) notification {}

- (void) online {
    
    [_controller.labelText setHidden:NO];
    [_controller.labelTime setHidden:NO];
    [_controller.buttonUserList setHidden:NO];
    [_controller.buttonSwitch setTitle:@"Offline"
                   forState:UIControlStateNormal];
    
    _controller.startTime = CFAbsoluteTimeGetCurrent();
    _controller.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                              target:_controller
                                            selector:@selector(updateTimer:)
                                            userInfo:nil
                                             repeats:YES];
    
    _controller.alert = [NSTimer scheduledTimerWithTimeInterval:_controller.seconds
                                              target:_controller
                                            selector:@selector(switch2offline:)
                                            userInfo:nil
                                             repeats:NO];
    
    
}

@end

#pragma mark -

@implementation ASControllerOnline
@synthesize controller = _controller;

- (void) notification {
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    NSDate *now = [NSDate date];
    int interval = _controller.seconds - ((int)CFAbsoluteTimeGetCurrent() - (int)_controller.startTime);
    NSDate *dateToFire = [now dateByAddingTimeInterval:interval];
    
    localNotification.fireDate = dateToFire;
    localNotification.alertBody = @"You are offline now!";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber++; // increment
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}
- (void) switchState {
    
    [self offline];
    
    [_controller.timer invalidate];
    [_controller.alert invalidate];
    
    _controller.state = _controller.offline;
    [_controller.player.state switchState];
    
}

- (void) offline {
    
    [_controller.labelText setHidden:YES];
    [_controller.labelTime setHidden:YES];
    [_controller.buttonUserList setHidden:YES];
    [_controller.buttonSwitch setTitle:@"Online"
                   forState:UIControlStateNormal];
    
    _controller.elapsedSeconds = 0;
    
    int min = _controller.seconds / 60;
    int sec = _controller.seconds % 60;
    NSString *time = [NSString stringWithFormat:@"%01d : %02d",min,sec];
    [_controller.labelTime setText:time];
    
    
}

- (void) online { }

@end

