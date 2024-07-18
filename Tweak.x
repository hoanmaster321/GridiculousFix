#import <UIKit/UIKit.h>

%hook _UIStatusBar

- (CGSize)_intrinsicContentSizeForOrientation:(UIInterfaceOrientation)orientation {
    // Thiết lập chiều cao và chiều rộng cụ thể
    CGSize originalSize = %orig(orientation);
    originalSize.height = 40.0; // Thay đổi giá trị này để điều chỉnh chiều cao
    originalSize.width = 375.0; // Thay đổi giá trị này để điều chỉnh chiều rộng (tùy theo kích thước màn hình)
    return originalSize;
}

%end
