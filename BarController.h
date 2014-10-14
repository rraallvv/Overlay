#import <Cocoa/Cocoa.h>

@class ClockTimer;

@interface BarController : NSWindowController

@property (nonatomic, assign) IBOutlet NSTextField *textField;
@property (nonatomic, retain) IBOutlet NSWindow *barWindow;
@property (nonatomic, assign) IBOutlet NSView *barView;
@property (nonatomic, assign) ClockTimer *clockTimer;

- (IBAction)textFieldAction:(id)sender;
- (void) timerWriteText:(NSTimer*)theTimer;
- (void) writeText:(NSString *)message;

@end
