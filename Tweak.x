#import <UIKit/UIKit.h>

%hook UIStatusBar_Modern

- (CGSize)_intrinsicSizeWithinBounds {
    CGSize originalSize = %orig;
    originalSize.height *= 3; // Thay đổi hệ số này để điều chỉnh chiều cao
    return originalSize;
}

%end
