//
//  AlarmSettings.m
//  Exercise
//
//  Created by Daniel Fairbanks on 5/4/15.
//  Copyright (c) 2015 Ender Labs. All rights reserved.
//

#import "AlarmSettings.h"

@implementation AlarmSettings

+ (AlarmSettings *)sharedInstance
{
    static AlarmSettings *sharedModel = nil;
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        sharedModel = [[self alloc] init];
    });
    return sharedModel;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self loadSettings];
    }
    return  self;
}

- (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return documentsDirectory;
}

- (NSString *)dataFilePath
{
    return [[self documentsDirectory]
            stringByAppendingPathComponent:@"Excercise.plist"];
}

- (void)saveSettings
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
                                 initForWritingWithMutableData:data];
    NSString *alarmThresholdValueString = [NSString stringWithFormat:@"%f", _alarmThresholdValue];
    [archiver encodeObject:alarmThresholdValueString forKey:@"alarmThresholdValue"];
    [archiver encodeBool:_isAlarmEnabled forKey:@"isAlarmEnabled"];
    
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

- (void)loadSettings
{
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
                                         initForReadingWithData:data];
        NSString *alarmThresholdValueString = [unarchiver decodeObjectForKey:@"alarmThresholdValue"];
        _alarmThresholdValue = (CGFloat)[alarmThresholdValueString floatValue];
        _isAlarmEnabled = [unarchiver decodeBoolForKey:@"isAlarmEnabled"];
        _dangerLevelValue = 0.5;
        [unarchiver finishDecoding];
    } else {
        _dangerLevelValue = 0.5;
        _alarmThresholdValue = 0.9;
        _isAlarmEnabled = true;
        _firstCheckOut = YES;
    }
}

@end
