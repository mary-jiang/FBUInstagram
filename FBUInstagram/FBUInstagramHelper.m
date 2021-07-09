//
//  FBUInstagramHelper.m
//  FBUInstagram
//
//  Created by Mary Jiang on 7/9/21.
//

#import "FBUInstagramHelper.h"
#import "NSDate+DateTools.h"


@implementation FBUInstagramHelper

+ (NSString *)getRelativeTimeStampString:(NSDate *)date {
    NSDate *today = [NSDate date]; //create a date to represent user's current time to compare to the date tweet was posted
    int minutes = (int)[today minutesFrom:date];
    if(minutes > 10080){ //tweet was tweeted more than a week ago
        //format MM/DD/YY for tweets tweeted that long ago
        //format the time stamp
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterShortStyle;
        return [formatter stringFromDate:date]; //convert date to string
    }else if(minutes > 1440){ //tweet was tweeted more than a day ago, but less than a week ago
        //format as days passed
        int days = (int)[today daysFrom:date];
        return [NSString stringWithFormat:@"%d days ago", days];
    }else if(minutes > 60){ //tweet was tweeted more than an hour ago, but less than a day ago
        //format as hours passed
        int hours = (int)[today hoursFrom:date];
        return [NSString stringWithFormat:@"%d hours ago", hours];
    }else if(minutes == 0){ //casting the double to int will truncate, so if minutes is 0 then it was tweeted seconds ago, but less than a minute ago
        //format as seconds passed
        int seconds = (int)[today secondsFrom:date];
        return [NSString stringWithFormat:@"%d seconds ago", seconds];
    }else{ //tweet was tweeted more than a minute ago, but less than an hour ago
        //format as minutes passed
        return [NSString stringWithFormat:@"%d minutes ago", minutes];
    }
}

@end
