#import <UIKit/UIKit.h>

@interface SBBacklightController : NSObject
+ (instancetype)sharedInstance;
- (void)setBacklightFactor:(float)factor source:(NSInteger)source;
@end

%hook SBLockScreenViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    %orig;
    
    SBBacklightController *backlightController = [%c(SBBacklightController) sharedInstance];
    if (backlightController) {
        [backlightController setBacklightFactor:1.0 source:1];
    }
}

%end
