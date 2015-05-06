//
//  AlarmSettings.h
//  Exercise
//
//  Created by Daniel Fairbanks on 5/4/15.
//  Copyright (c) 2015 Ender Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlarmSettings : NSObject

@property (nonatomic, assign) CGFloat alarmThresholdValue;
@property (nonatomic, assign) CGFloat dangerLevelValue;
@property (nonatomic, assign) BOOL isAlarmEnabled;

+ (AlarmSettings *)sharedInstance;

- (void)saveSettings;

@end
