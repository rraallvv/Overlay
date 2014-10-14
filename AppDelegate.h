#import <Cocoa/Cocoa.h>
#import "Window.h"

@class BarController;

@interface OverlayAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) NSMutableArray *windows;
@property (nonatomic, assign) IBOutlet NSMenu *statusMenu;
@property (nonatomic, strong) NSStatusItem *statusBar;
@property (nonatomic, assign) BarController *barController;

- (IBAction)openNewOverlayWindow:(id)sender;
- (OverlayWindow *)createNewOverlayWindowWithLocation:(NSString *)fileName andAlpha:(CGFloat)defaultAlpha andAlwaysOnTop:(BOOL)alwaysOnTop;
- (OverlayWindow *)createNewOverlayWindowWithDefaults:(OverlayWindowDefaults *)defaults withoutNotification:(BOOL)silent;
- (void)saveSettings;

@end
