//
//  SIMBL_iTerm_TeraTermLikePaste.m
//  SIMBL_iTerm_TeraTermLikePaste
//
//  Created by minase on 09.08.11.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <objc/runtime.h>
#import "SIMBL_iTerm_TeraTermLikePaste.h"



@implementation PTYTextView (SIMBL_iTerm_TeraTermLikePaste)

-(NSMenu*) menuForEvent:(NSEvent*)theEvent
{
		return nil;
}

//
// paste a text from clipboard
//
-(void) rightMouseDownNew:(NSEvent*)theEvent
{
		// move a clicked window to front
		[[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
		[[theEvent window] makeKeyAndOrderFront:self];
		
		// call a original method
		[self rightMouseDownNew:theEvent];
		
		// paste
		[(id)self performSelector:@selector(paste:) withObject:nil];
}

@end



@implementation SIMBL_iTerm_TeraTermLikePaste

+(void) load
{
		Class ptview = objc_getClass("PTYTextView");
		
		// swap rightMouseDown method
		Method rightMouseDownOrg = class_getInstanceMethod(ptview, @selector(rightMouseDown:));
		Method rightMouseDownNew = class_getInstanceMethod(ptview, @selector(rightMouseDownNew:));
		method_exchangeImplementations(rightMouseDownOrg, rightMouseDownNew);
		
		NSLog(@"SIMBL::iTerm::TeraTermLikePaste was loaded.");
}

@end