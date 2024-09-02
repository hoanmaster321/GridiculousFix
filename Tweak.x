#import <UIKit/UIKit.h>

@interface SBBacklightController : NSObject
+ (instancetype)sharedInstance;
- (void)turnOnScreenFullyWithBacklightSource:(NSInteger)source;
@end

@interface SBHomeHardwareButtonService : NSObject
+ (instancetype)sharedInstance;
- (void)simulateSinglePressOfHomeButton;
@end

%hook SpringBoard

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    %orig;
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    if (mainScreen.brightness == 0) {
        SBBacklightController *backlight = [%c(SBBacklightController) sharedInstance];
        if (backlight) {
            [backlight turnOnScreenFullyWithBacklightSource:1];
        }
        
        // Simulate a home button press to wake the device
        SBHomeHardwareButtonService *homeButtonService = [%c(SBHomeHardwareButtonService) sharedInstance];
        if (homeButtonService) {
            [homeButtonService simulateSinglePressOfHomeButton];
        }
    }
}

%end
