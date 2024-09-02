#import <UIKit/UIKit.h>

%hook SBLockScreenViewController

- (void)viewDidLoad {
    %orig;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapRecognizer];
}

%new
- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    [[%c(SBBacklightController) sharedInstance] turnOnScreenFullyWithBacklightSource:1];
}

%end
