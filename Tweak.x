#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SpringBoard : UIApplication
- (void)_simulateLockButtonPress;
@end

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    
    // Thêm gesture recognizer vào cửa sổ chính
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapRecognizer.numberOfTapsRequired = 2; // Chạm hai lần để bật màn hình
    [mainWindow addGestureRecognizer:tapRecognizer];
}

%new
- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    if ([[UIScreen mainScreen] brightness] == 0) {
        // Mô phỏng nhấn nút khóa để bật sáng màn hình
        [self _simulateLockButtonPress];
    }
}

%end
