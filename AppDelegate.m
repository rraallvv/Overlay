#import "AppDelegate.h"
#import "WindowDefaults.h"
#import "Window.h"
#import "BarController.h"

@implementation OverlayAppDelegate {
	NSMutableArray *defaultWindowPreferences;
	NSMutableArray *windows;
	NSOpenPanel *openDialog;
	BOOL applicationIsActive;
	BOOL willTerminate;
}

@synthesize windows;

- (void)awakeFromNib {
	windows = [[[NSMutableArray alloc] init] retain];
	defaultWindowPreferences = [[[NSMutableArray alloc] init] retain];
	//get any previous windows that were overlayed and load them.
	NSData *preferencesAtLoad = [[NSUserDefaults standardUserDefaults] objectForKey:OVERLAY_DEFAULTSKEY_WINDOWS];
	if (preferencesAtLoad != nil)
	{
		NSArray *windowsFromPreferences = [NSKeyedUnarchiver unarchiveObjectWithData:preferencesAtLoad];
		if (windowsFromPreferences != nil && [windowsFromPreferences isKindOfClass:[NSArray class]] && windowsFromPreferences.count) {
			[self createNewOverlayWindowWithDefaults:[windowsFromPreferences lastObject] withoutNotification:NO];
		}
	}
	
	self.statusBar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	self.statusBar.title = @"Overlay";
	
	// TODO: set icon
	//self.statusBar.image =
	
	self.statusBar.menu = self.statusMenu;
	self.statusBar.highlightMode = YES;
}

- (void)dealloc {
	[windows release];
	[defaultWindowPreferences release];
	[super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
}

- (void)applicationWillTerminate:(NSNotification *)notification {
	//if the application is closing, we don't want to save the closing windows
	willTerminate = YES;
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
	applicationIsActive = YES;
	//NSLog(@"%i", [windows count]);
	for (OverlayWindow *window in windows) {
		if (window != nil)
			[window setIgnoresMouseEvents:YES];//NO
	}
}

- (void)applicationDidResignActive:(NSNotification *)notification {
	applicationIsActive = NO;
	for (OverlayWindow *window in windows) {
		if (window != nil)
			[window setIgnoresMouseEvents:YES];
	}
}

- (void)openNewOverlayWindow:(id)sender {
	//open a new file dialog looking for only images
	openDialog = [NSOpenPanel openPanel];
	NSArray *fileTypes = [NSArray arrayWithObjects:@"jpg", @"png", @"tiff", nil];
	[openDialog setCanChooseFiles:YES];
	[openDialog setCanChooseDirectories:NO];
	[openDialog setAllowedFileTypes:fileTypes];
	[openDialog setAllowsOtherFileTypes:NO];
	[openDialog setAllowsMultipleSelection:NO];
	
	if ( [openDialog runModal] == NSOKButton )
	{
		//we'll create an OverlayWindow for each of the files selected
		NSString* fileName = [[[NSString alloc] initWithString:[[[openDialog URLs] firstObject] path]] retain];
		[self createNewOverlayWindowWithLocation:fileName andAlpha:0.8 andAlwaysOnTop:YES];
	}
	[self saveSettings];
}

- (OverlayWindow *) createNewOverlayWindowWithLocation:(NSString *)imageLocation andAlpha:(CGFloat)defaultAlpha andAlwaysOnTop:(BOOL)alwaysOnTop {
	//retain them; Window should release on dealloc
	OverlayWindowDefaults *defaults = [[[OverlayWindowDefaults alloc] init] retain];
	[defaults setImageLocation:imageLocation];
	[defaults setDefaultAlpha:defaultAlpha];
	[defaults setAlwaysOnTop:alwaysOnTop];
	
	OverlayWindow *window = [self createNewOverlayWindowWithDefaults:defaults withoutNotification:NO];
	return window;
}

- (OverlayWindow *) createNewOverlayWindowWithDefaults:(OverlayWindowDefaults *)defaults withoutNotification:(BOOL)silent {
	OverlayWindow *window = [OverlayWindow initWithDefaults: defaults quietly:silent];
	
	[window display];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(overlayWindowWillClose:) name:OVERLAY_NOTIFICATION_KEY_WILLCLOSE object:window];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(overlayWindowDefaultsChanged:) name:OVERLAY_NOTIFICATION_KEY_DEFAULTSCHANGED object:window];
	[window makeKeyAndOrderFront:self];
	[windows addObject:window];
	[defaultWindowPreferences addObject:defaults];
	return window;
}

- (void)overlayWindowWillClose:(id)sender {
	NSNotification *senderNote = sender;
	OverlayWindow *closingWindow = senderNote.object;
	if (closingWindow != nil) {
		[defaultWindowPreferences removeObject:closingWindow.defaultSettings];
		if (!willTerminate)
			[self saveSettings];
	}
	[windows removeObject:senderNote.object];
}

- (void)overlayWindowDefaultsChanged:(id)sender {
	[self saveSettings];
}

- (void)saveSettings {
	NSArray *unmutableArray = defaultWindowPreferences;
	//NSLog(@"Saving these: %@", unmutableArray);
	[[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:unmutableArray] forKey:OVERLAY_DEFAULTSKEY_WINDOWS];
}

@end
