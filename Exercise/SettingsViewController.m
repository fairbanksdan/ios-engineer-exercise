//
//  SettingsViewController.m
//  Exercise
//
//  Created by Donald Hays on 2/24/15.
//  Copyright (c) 2015 Ender Labs. All rights reserved.
//

#import "SettingsViewController.h"
#import "AlarmSettings.h"

@interface SettingsViewController()
@property (nonatomic, weak) IBOutlet UISlider *alarmThresholdSlider;
@property (nonatomic, weak) IBOutlet UISwitch *alarmEnabledSwitch;
@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    self.alarmThresholdSlider.value = AlarmSettings.sharedInstance.alarmThresholdValue;
    [self.alarmEnabledSwitch setOn:AlarmSettings.sharedInstance.isAlarmEnabled];
}

#pragma mark -
#pragma mark Actions
- (IBAction)done:(id)sender
{
    [AlarmSettings.sharedInstance saveSettings];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)alarmThresholdSliderValueChanged:(UISlider *)sender
{
    AlarmSettings.sharedInstance.alarmThresholdValue = sender.value;
}

- (IBAction)alarmEnabledSwitchValueChanged:(UISwitch *)sender
{
    if (sender.isOn) {
        AlarmSettings.sharedInstance.isAlarmEnabled = true;
    } else {
        AlarmSettings.sharedInstance.isAlarmEnabled = false;
    }
}

@end
