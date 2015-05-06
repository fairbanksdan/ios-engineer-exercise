//
//  DangerViewController.m
//  Exercise
//
//  Created by Donald Hays on 2/24/15.
//  Copyright (c) 2015 Ender Labs. All rights reserved.
//

#import "DangerViewController.h"
#import "Alarm.h"
#import "AlarmSettings.h"

@interface DangerViewController()
@property (nonatomic, weak) IBOutlet UISlider *dangerSlider;
@end

@implementation DangerViewController
{
    BOOL _isAlarmEnabled;
    CGFloat _currentValue;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    _isAlarmEnabled = AlarmSettings.sharedInstance.isAlarmEnabled;
    AlarmSettings.sharedInstance.dangerLevelValue = self.dangerSlider.value;
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
    [super viewWillAppear:animated];
}

#pragma mark -
#pragma mark Actions
- (IBAction)dangerSliderValueChanged:(UISlider *)sender
{
    AlarmSettings.sharedInstance.dangerLevelValue = sender.value;

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

@end
