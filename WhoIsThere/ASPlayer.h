//
//  ASPlayer.h
//  WhoIsThere
//
//  Created by Наталья Дидковская on 25.06.14.
//  Copyright (c) 2014 Andrey Samokhvalov. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ASPlayer;
@class PFObject;

@protocol ASPlayerState <NSObject>
@property ASPlayer *player;

- (void) terminate;
- (void) switchState;

@end


@interface ASOnline : NSObject <ASPlayerState>
@end

@interface ASOffline : NSObject <ASPlayerState>
@end

@interface ASPlayer : NSObject

@property  NSString *mac;
@property id<ASPlayerState> state;
@property PFObject *mobile;

@property ASOnline *stateOnline;
@property ASOffline *stateOffline;

- (id) init;

@end

