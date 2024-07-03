#import <UIKit/UIKit.h>

%hook UIScreen

- (void)setWantsLowPowerMode:(BOOL)arg1 {
    // Không làm gì cả, giữ nguyên 120Hz
}

%end
