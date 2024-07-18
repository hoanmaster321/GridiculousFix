#import <UIKit/UIKit.h>
#import <objc/runtime.h>

%hook UIStatusBar

- (void)setFrame:(CGRect)frame {
    frame.size.height = 40; // Điều chỉnh chiều cao status bar
    frame.origin.y = 50;    // Điều chỉnh vị trí y của status bar
    %orig(frame);
}

%end
