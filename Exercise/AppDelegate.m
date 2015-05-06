//
//  AppDelegate.m
//  Exercise
//
//  Created by Donald Hays on 2/24/15.
//  Copyright (c) 2015 Ender Labs. All rights reserved.
//

#import "AppDelegate.h"
#import "AlarmSettings.h"
#import "Alarm.h"

@interface AppDelegate ()
@end

@implementation AppDelegate
{
    BOOL _isAlarmEnabled;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}

- (void)saveData
{
    [AlarmSettings.sharedInstance saveSettings];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [self saveData];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    if (isAlarmActive()) {
        deactivateAlarm();
    }
    [self saveData];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    _isAlarmEnabled = AlarmSettings.sharedInstance.isAlarmEnabled;
    if (_isAlarmEnabled == true) {
        if (AlarmSettings.sharedInstance.dangerLevelValue >= AlarmSettings.sharedInstance.alarmThresholdValue) {
            if (!isAlarmActive()) {
                activateAlarm();
            }
            
        } else {
            if (isAlarmActive()) {
                deactivateAlarm();
            }
        }
    } else {
        if (isAlarmActive()) {
            deactivateAlarm();
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveData];
}
@end
