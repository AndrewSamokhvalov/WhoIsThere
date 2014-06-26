//
//  ASPlayer.m
//  WhoIsThere
//
//  Created by Наталья Дидковская on 25.06.14.
//  Copyright (c) 2014 Andrey Samokhvalov. All rights reserved.
//

#import "ASPlayer.h"
#import "Constants.h"
#import <Parse/Parse.h>
#import "TCMacAddress.h"


@implementation ASPlayer

- (id)init {
    if ( self = [super init] ) {
        
         _mac = [TCMacAddress getMacAddress];
        
        _stateOnline = [[ASOnline alloc] init];
        self.stateOnline.player = self;
        
        _stateOffline = [[ASOffline alloc] init];
        self.stateOffline.player = self;
        
        self.state = self.stateOffline;
        
    }
    return self;
}

@end


@implementation ASOnline
@synthesize player = _player;

- (void) terminate {
    
    [_player.mobile deleteInBackground];

}

- (void) switchState {
    
    [_player.mobile deleteInBackground];
    _player.state = _player.stateOffline;
    
}

@end

@implementation ASOffline
@synthesize player = _player;

- (void) terminate {
    
}

- (void) switchState {
    
    _player.mobile = [PFObject objectWithClassName: GROUP_NAME];
    _player.mobile[COLONE_NAME] = _player.mac;
    
    [_player.mobile saveInBackground];
    _player.state = _player.stateOnline;

    
}

@end
