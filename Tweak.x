#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SpringBoard : UIApplication
- (void)_simulateLockButtonPress;
@end

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapRecognizer.numberOfTapsRequired = 2;
    [[self keyWindow] addGestureRecognizer:tapRecognizer];
}

%new
- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    if ([[UIScreen mainScreen] brightness] == 0) {
        [self _simulateLockButtonPress];
    }
}

%end

%ctor {
    %init(SpringBoard);
}
