#import <UIKit/UIKit.h>
#import <objc/runtime.h>

%hook UIStatusBar
- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize = %orig;
    newSize.height *= 3; // Thay đổi hệ số này để điều chỉnh chiều cao
    return newSize;
}
%end
