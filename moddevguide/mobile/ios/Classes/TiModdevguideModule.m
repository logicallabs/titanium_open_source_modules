/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiModdevguideModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiBlob.h"

@implementation TiModdevguideModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"6fe96416-b375-4358-ab0e-65510cc1acbe";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.moddevguide";
}

// Constants can be made available to the JavaScript using the following notations
MAKE_SYSTEM_NUMBER(DEMO_INTEGER,NUMINT(50));
MAKE_SYSTEM_STR(DEMO_STRING,@"Hello World");
MAKE_SYSTEM_PROP(DEMO_BOOLEAN,YES);

#pragma mark Lifecycle

-(void)startup
{
	// This method is called when the module is first loaded
	// you *must* call the superclass
	
	[super startup];
	
	NSLog(@"[MODULE LIFECYCLE EVENT] startup");
}

-(void)shutdown:(id)sender
{
	// This method is called when the module is being unloaded.
	// Typically this is during application shutdown. Make sure you don't do too
	// much processing here or the app will be quit forceably
	
	NSLog(@"[MODULE LIFECYCLE EVENT] shutdown");
	
	// You *must* call the superclass
	[super shutdown:sender];
}

-(id)init
{
	// This is the designated initializer method and will always be called
	// when the proxy is created.
	
	NSLog(@"[MODULE LIFECYCLE EVENT] init");
	
	return [super init];
}

-(void)_destroy
{
	// This method is called from the dealloc method and is good place to
	// release any objects and memory that have been allocated for the module.
	
	NSLog(@"[MODULE LIFECYCLE EVENT] _destroy");
	
	[super _destroy];
}

-(void)dealloc
{
	// This method is called when the proxy is being deallocated. The superclass
	// method calls the _destroy method.
	
	NSLog(@"[MODULE LIFECYCLE EVENT] dealloc");
	
	[super dealloc];
}

-(void)suspend:(id)sender
{
	// This method is called when the application is being suspended
	
	NSLog(@"[MODULE LIFECYCLE EVENT] suspend");
	
	[super suspend:sender];
}

-(void)resume:(id)sender
{
	// This method is called when the application is being resumed
	
	NSLog(@"[MODULE LIFECYCLE EVENT] resume");
	
	[super resume:sender];
}

-(void)resumed:(id)sender
{
	// This method is called when the application has been resumed
	
	NSLog(@"[MODULE LIFECYCLE EVENT] resumed");
	
	[super resumed:sender];
}

-(id)_initWithPageContext:(id<TiEvaluator>)context
{
	// This method is one of the initializers for the proxy class. If the
	// proxy is created without arguments then this initializer will be called.
	// This method is also called from the other _initWithPageContext method.
	// The superclass method calls the init and _configure methods.
	
	NSLog(@"[MODULE LIFECYCLE EVENT] _initWithPageContext (no arguments)");
	
	return [super _initWithPageContext:context];
}

-(id)_initWithPageContext:(id<TiEvaluator>)context_ args:(NSArray*)args
{
	// This method is one of the initializers for the proxy class. If the
	// proxy is created with arguments then this initializer will be called.
	// The superclass method calls the _initWithPageContext method without
	// arguments.
	
	NSLog(@"[MODULE LIFECYCLE EVENT] _initWithPageContext (arguments)");
	
	return [super _initWithPageContext:context_ args:args];
}

-(void)_configure
{
	// This method is called from _initWithPageContext to allow for
	// custom configuration of the module before startup. The superclass
	// method calls the startup method.
	
	NSLog(@"[MODULE LIFECYCLE EVENT] _configure");
	
	[super _configure];
}

-(void)_initWithProperties:(NSDictionary*)properties
{
	// This method is called from _initWithPageContext if arguments have been
	// used to create the proxy. It is called after the initializers have completed
	// and is a good point to process arguments that have been passed to the
	// proxy create method since most of the initialization has been completed
	// at this point.
	
	NSLog(@"[MODULE LIFECYCLE EVENT] _initWithProperties");
	
	[super _initWithProperties:properties];
}


#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma Assets Demo Methods

-(NSString*)getPathToModuleAsset:(NSString*) fileName
{
	// The module assets are copied to the application bundle into the folder pattern
	// "module/<moduleid>". One way to access these assets is to build a path from the
	// mainBundle of the application.
	
	NSString *pathComponent = [NSString stringWithFormat:@"modules/%@/%@", [self moduleId], fileName];
	NSString *result = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:pathComponent];
	
	return result;
}

-(NSString*)getPathToApplicationAsset:(NSString*) fileName
{
	// The application assets can be accessed by building a path from the mainBundle of the application.
	
	NSString *result = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
	
	return result;
}

-(TiBlob*)loadImageFromModule:(id)args
{
	ENSURE_SINGLE_ARG(args,NSString);
	
	NSLog(@"[ASSETSDEMO] loadImageFromModule %@", args);
	
	// Load the image from the module assets
	NSString *imagePath = [self getPathToModuleAsset:args];
	UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
	if (image == nil) {
		return nil;
	}
	
	// The image must be converted to a TiBlob before returning
	TiBlob *result = [[[TiBlob alloc] initWithImage:image] autorelease];
	
	NSLog(@"[ASSETSDEMO] %@", result);
	
	return result;	
}

-(TiBlob*)loadImageFromApplication:(id)args
{
	ENSURE_SINGLE_ARG(args,NSString);
	
	NSLog(@"[ASSETSDEMO] loadImageFromApplication %@", args);
	
	// Load the image from the application assets
	NSString *imagePath = [self getPathToApplicationAsset:args];
	UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
	if (image == nil) {
		return nil;
	}
	
	// The image must be converted to a TiBlob before returning
	TiBlob *result = [[[TiBlob alloc] initWithImage:image] autorelease];
	
	NSLog(@"[ASSETSDEMO] %@", result);
	
	return result;	
}

@end
