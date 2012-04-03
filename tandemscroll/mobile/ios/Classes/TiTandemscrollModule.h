/**
 * Titanium Tandem Scroll Module
 *
 * Appcelerator Titanium is Copyright (c) 2009-2012 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiModule.h"
#import "TiUIScrollViewProxy.h"
#import "TiUIScrollView.h"

@interface TiTandemscrollModule : TiModule <UIScrollViewDelegate>
{
    NSMutableArray* scrollViews;
    UIScrollView* controllingScrollView;
    TiUIScrollViewProxy* controllingScrollViewProxy;
}

@end
