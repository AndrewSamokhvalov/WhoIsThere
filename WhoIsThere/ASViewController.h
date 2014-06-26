//
//  ASViewController.h
//  WhoIsThere
//
//  Created by Наталья Дидковская on 25.06.14.
//  Copyright (c) 2014 Andrey Samokhvalov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASPlayer;
@class ASViewController;


@protocol ASControllerState <NSObject>
@property ASViewController *controller;
- (void) notification;
- (void) offline;
- (void) online;
- (void) switchState;
@end

@interface ASControllerOffline : NSObject <ASControllerState>
@end

@interface ASControllerOnline : NSObject <ASControllerState>
@end

@interface ASViewController : UIViewController

@property NSTimer *timer;
@property NSTimer *alert;

@property NSInteger elapsedSeconds;

@property ASPlayer *player;
@property NSInteger seconds;
@property CFAbsoluteTime startTime;

@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UILabel *labelText;
@property (weak, nonatomic) IBOutlet UIButton *buttonSwitch;
@property (weak, nonatomic) IBOutlet UIButton *buttonUserList;

@property id<ASControllerState> state;
@property ASControllerOnline *online;
@property ASControllerOffline *offline;

//- (void) notification;

@end
