#import "BarController.h"
#import "ClockTimer.h"

@implementation BarController

- (void) writeText:(NSString *)message {
	[self.textField setStringValue:message];
}

- (IBAction)textFieldAction:(id)sender {
}
// method for timer selector
- (void) timerWriteText:(NSTimer*)theTimer {
	NSDate *date = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MM/dd/YY HH:mm"];
	NSString *dateTime = [dateFormatter stringFromDate:date];
	[self.textField setStringValue:dateTime];
}

- (id)init
{
	self = [super initWithWindowNibName:@"Overlay"];
	if (self) {
	}
	return self;
}

- (void) activeSpaceDidChange:(NSNotification *)aNotification {
	
	NSLog(@"space changed");
}

- (void)windowDidLoad
{
	[super windowDidLoad];
	
	// Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
	// format window into bar
	
	// the proper level under main mac menu
	self.barWindow.level = NSMainMenuWindowLevel;
	// remove window header
	[self.barWindow setStyleMask:NSBorderlessWindowMask];
	// set bgcolor
	NSColor *barColor = [NSColor colorWithCalibratedRed:85 green:85 blue:85 alpha: 0];
	self.window.backgroundColor = barColor;
	// retrieve screen size, set bar size
	NSRect screenDims = [[NSScreen mainScreen] frame];
	//NSLog(@"%f x %f", screenDims.size.height, screenDims.size.width);
	NSRect barFrame = CGRectMake(0.0, screenDims.size.height-20, screenDims.size.width, 20);
	[self.barWindow setFrame:barFrame display:YES];
	
	self.textField.bezeled = NO;
	self.textField.editable = NO;
	self.textField.drawsBackground = NO;
	
	self.clockTimer = [[ClockTimer alloc] init];
	
	self.clockTimer.barObject = self;
	
	self.clockTimer.updateTextSelector = @selector(timerWriteText:);
	[self.clockTimer startRepeatingTimer];
	NSLog(@"barcontroller");
	[self.clockTimer testMethod];
	
	[[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(activeSpaceDidChange:) name:NSWorkspaceActiveSpaceDidChangeNotification object:nil];
}

@end
