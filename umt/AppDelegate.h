//
//  AppDelegate.h
//  umt
//
//  Created by Tyler Gillies on 6/29/14.
//  Copyright (c) 2014 Tyler Gillies. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject {
    NSWindow *window;
    IBOutlet NSMenu *statusMenu;
    NSStatusItem * statusItem;
}

@property (assign) IBOutlet NSWindow *window;

@end
