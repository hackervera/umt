//
//  AppDelegate.m
//  umt
//
//  Created by Tyler Gillies on 6/29/14.
//  Copyright (c) 2014 Tyler Gillies. All rights reserved.
//

#import "AppDelegate.h"

NSString * umt(){
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit|NSSecondCalendarUnit) fromDate:today];
    NSInteger minute = [weekdayComponents minute];
    NSInteger hour = [weekdayComponents hour];
    NSInteger second = [weekdayComponents second];
    float offset = [[NSTimeZone localTimeZone] secondsFromGMT] /60;
    NSInteger idl = ((60 * hour) + (abs(offset) - 720));
    if (idl < 0) idl = 1440 + idl;
        idl = idl / 60;
        NSInteger totsecs = idl*3600;
        totsecs += minute*60;
        totsecs += second;
        NSTimeInterval secondsSinceUnixEpoch = [[NSDate date]timeIntervalSince1970];
        totsecs += ((int)secondsSinceUnixEpoch % 1000) / 1000;
        float mtime = totsecs / .864;
        int umtcd = ((mtime - (fmod(mtime,1000))) / 1000);
        int umtqd = (mtime - (fmod(mtime,1)) - (umtcd * 1000));
        NSString *cd = (umtcd < 10) ? @"0" : @"";
        NSString * qd1 = (umtqd < 10) ? @"0" : @"";
        NSString * qd2 = (umtqd < 100) ? @"0" : @"";
        NSString * decimalValue =  [NSString stringWithFormat:@"%@%i.%@%@%i UMT", cd, umtcd, qd1, qd2, umtqd];
        return decimalValue;
}

void updateStatus(NSStatusItem *statusItem){
    [statusItem setTitle:umt()];
}



@implementation AppDelegate
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}


-(void)updater{
    [statusItem setTitle: umt()];
}

-(void)awakeFromNib{
      statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    //updateStatus(statusItem);
    [NSTimer scheduledTimerWithTimeInterval:2.0
target:self
selector:@selector(updater)
userInfo:nil
repeats:YES];
    //[self updater];
    [statusItem setHighlightMode:YES];
}
@end
