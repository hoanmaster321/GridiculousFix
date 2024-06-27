#import <Foundation/Foundation.h>

@interface SBIconListGridLayoutConfiguration : NSObject 
@property(nonatomic) NSUInteger numberOfPortraitRows;
@property(nonatomic) NSUInteger numberOfPortraitColumns;
@end

@interface SBIconListFlowExtendedLayout : NSObject
@property (nonatomic,copy,readonly) SBIconListGridLayoutConfiguration * layoutConfiguration;
@end

@interface SBHHomeScreenManager : NSObject
+ (instancetype)sharedInstance;
- (NSArray *)iconListModel;
- (void)saveIconState;
@end

static NSUInteger SBIconListFlowExtendedLayout_maximumIconCount(__unsafe_unretained SBIconListFlowExtendedLayout* const self, SEL _cmd) {
    return self.layoutConfiguration.numberOfPortraitRows * self.layoutConfiguration.numberOfPortraitColumns;
}

#define KEY @"_GridiculousIconState"

%hook SBHHomeScreenManager

- (NSArray *)iconListModel {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *savedState = [defaults objectForKey:KEY];
    if (savedState) {
        return savedState;
    }
    NSArray *orig = %orig;
    [defaults setObject:orig forKey:KEY];
    return orig;
}

- (void)saveIconState {
    NSArray *currentState = [self iconListModel];
    NSMutableArray *value = [NSMutableArray arrayWithArray:currentState];
    NSMutableArray *lastList = value.lastObject;
    bool shouldRemove = true;
    for (NSString *newkey in lastList) {
        if ([newkey isKindOfClass:[NSString class]]) {
            if (![newkey containsString:@"com.cpdigitaldarkroom.gridiculous"]) {
                shouldRemove = false;
                break;
            }
        }
    }
    if (shouldRemove) {
        NSUserDefaults *gridiculousDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"com.cpdigitaldarkroom.gridiculous"];
        NSMutableArray *prefs = [[gridiculousDefaults objectForKey:@"icons"] mutableCopy];
        if (prefs) {
            [prefs removeObjectsInArray:lastList];
            [gridiculousDefaults setObject:prefs forKey:@"icons"];
        }
        [value removeLastObject];
    }
    
    NSUserDefaults *springBoardDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"com.apple.springboard"];
    [springBoardDefaults setObject:value forKey:@"_GridiculousIconState"];
    
    %orig;
}

%end

%ctor {
    class_addMethod(objc_getClass("SBIconListFlowExtendedLayout"), @selector(maximumIconCount), (IMP)&SBIconListFlowExtendedLayout_maximumIconCount, "Q@:");
    %init;
}
