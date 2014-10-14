#import <Cocoa/Cocoa.h>
#import "OverlayWindow.h"

@interface OverlayAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) NSMutableArray *windows;

- (IBAction)openNewOverlayWindow:(id)sender;
- (OverlayWindow *)createNewOverlayWindowWithLocation:(NSString *)fileName andAlpha:(CGFloat)defaultAlpha andAlwaysOnTop:(BOOL)alwaysOnTop;
- (OverlayWindow *)createNewOverlayWindowWithDefaults:(OverlayWindowDefaults *)defaults withoutNotification:(BOOL)silent;
- (void)saveSettings;

@end
