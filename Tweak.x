#import <Foundation/Foundation.h>

@interface SBIconListGridLayoutConfiguration : NSObject 
@property(nonatomic) NSUInteger numberOfPortraitRows;
@property(nonatomic) NSUInteger numberOfPortraitColumns;
@end

@interface SBIconListFlowExtendedLayout : NSObject
@property (nonatomic,copy,readonly) SBIconListGridLayoutConfiguration * layoutConfiguration;
@end

static NSUInteger SBIconListFlowExtendedLayout_maximumIconCount(__unsafe_unretained SBIconListFlowExtendedLayout* const self, SEL _cmd) {
    return self.layoutConfiguration.numberOfPortraitRows * self.layoutConfiguration.numberOfPortraitColumns;
}

#define KEY @"_GridiculousIconState"

%hook SBDefaultIconModelStore

-(NSMutableDictionary *)loadCurrentIconState:(__unsafe_unretained NSError **)error {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:KEY]) {
        return [defaults objectForKey:KEY];
    }

    NSMutableDictionary *orig = %orig;
    [defaults setObject:orig forKey:KEY];
    return orig;
}

-(BOOL)saveCurrentIconState:(NSMutableDictionary *)state error:(__unsafe_unretained NSError **)error {
    NSMutableArray* value = [state objectForKey:@"iconLists"];
    NSMutableArray* lastList = value[value.count-1];

    bool shouldRemove = true;

    for(NSString* newkey in lastList) {
        if ([newkey isKindOfClass:[NSString class]]) {
            if (![newkey containsString:@"com.cpdigitaldarkroom.gridiculous"]) {
                shouldRemove = false;
                break;
            }
        }
    }

    if (shouldRemove) {
        CFPropertyListRef icons = CFPreferencesCopyAppValue(CFSTR("icons"), CFSTR("com.cpdigitaldarkroom.gridiculous"));
        
        NSMutableArray *prefs = [NSMutableArray arrayWithArray:(__bridge NSArray*)icons];

        CFRelease(icons);

        [prefs removeObjectsInArray:lastList];
        [value removeLastObject];
       
        [state setObject:value forKey:@"iconLists"];

        CFPreferencesSetAppValue(CFSTR("icons"), (__bridge CFPropertyListRef) prefs, CFSTR("com.cpdigitaldarkroom.gridiculous"));
    }


    CFPreferencesSetAppValue(CFSTR("_GridiculousIconState"), (__bridge CFPropertyListRef) state, CFSTR("com.apple.springboard"));
    return %orig;
}

%end

%ctor {
    class_addMethod(objc_getClass("SBIconListFlowExtendedLayout"), @selector(maximumIconCount), (IMP)&SBIconListFlowExtendedLayout_maximumIconCount, "Q@:");
    %init;
}