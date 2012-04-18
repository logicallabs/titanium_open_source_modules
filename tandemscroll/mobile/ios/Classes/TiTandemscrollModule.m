/**
 * Titanium Tandem Scroll Module
 *
 * Appcelerator Titanium is Copyright (c) 2009-2012 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiTandemscrollModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation TiTandemscrollModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"f7f041db-989f-47c9-b009-7977a59497a2";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.tandemscroll";
}

#pragma mark Cleanup 

-(void)unbindScrollViews
{
    if (scrollViews) {
        for (TiUIScrollViewProxy* proxy in scrollViews) {
            [proxy forgetSelf];
        }
        RELEASE_TO_NIL(scrollViews);
    }
}

-(void)dealloc
{
	[self unbindScrollViews];
	[super dealloc];
}

#pragma Public APIs

-(void)lockTogether:(id)args
{
    ENSURE_SINGLE_ARG(args, NSArray);
    
    [self unbindScrollViews];
    scrollViews = [[NSMutableArray alloc] initWithCapacity:[args count]];
    
    for (TiUIScrollViewProxy* proxy in args) {
        [proxy rememberSelf];
        [(TiUIScrollView*)proxy.view scrollView].delegate = self;
        [scrollViews addObject:proxy];
    }
}

#pragma UIScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    controllingScrollView = scrollView;
    for (TiUIScrollViewProxy* proxy in scrollViews) {
        UIScrollView* scroll = [(TiUIScrollView*)proxy.view scrollView];
        if (scroll == controllingScrollView) {
            controllingScrollViewProxy = proxy;
            break;
        }
    }
    CGPoint offset = [scrollView contentOffset];    
    [controllingScrollViewProxy fireEvent:@"scrollViewWillBeginDragging" 
                               withObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                           NUMFLOAT(offset.x),@"x",
                                           NUMFLOAT(offset.y),@"y",
                                           NUMBOOL([scrollView isDecelerating]),@"decelerating",
                                           NUMBOOL([scrollView isDragging]),@"dragging", nil]];

}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (scrollView != controllingScrollView)
        return;
    CGPoint offset = [scrollView contentOffset];
    [controllingScrollViewProxy fireEvent:@"scrollViewWillEndDragging" 
                               withObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                           NUMFLOAT(offset.x),@"x",
                                           NUMFLOAT(offset.y),@"y",
                                           NUMFLOAT(velocity.x),@"velocity_X",
                                           NUMFLOAT(velocity.y),@"velocity_Y", 
                                           NUMFLOAT(targetContentOffset->x),@"target_X",
                                           NUMFLOAT(targetContentOffset->y),@"target_Y",                                           
                                           NUMBOOL([scrollView isDecelerating]),@"decelerating",
                                           NUMBOOL([scrollView isDragging]),@"dragging", nil]];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    if (scrollView != controllingScrollView)
        return;
    CGPoint offset = [scrollView contentOffset];
    [controllingScrollViewProxy fireEvent:@"scrollViewDidScrollToTop" 
                               withObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                           NUMFLOAT(offset.x),@"x",
                                           NUMFLOAT(offset.y),@"y",
                                           NUMBOOL([scrollView isDecelerating]),@"decelerating",
                                           NUMBOOL([scrollView isDragging]),@"dragging", nil]];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (scrollView != controllingScrollView)
        return;
    CGPoint offset = [scrollView contentOffset];
    [controllingScrollViewProxy fireEvent:@"scrollViewWillBeginDecelerating" 
                               withObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                           NUMFLOAT(offset.x),@"x",
                                           NUMFLOAT(offset.y),@"y",
                                           NUMBOOL([scrollView isDecelerating]),@"decelerating",
                                           NUMBOOL([scrollView isDragging]),@"dragging", nil]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView != controllingScrollView)
        return;
    CGPoint offset = [scrollView contentOffset];
    [controllingScrollViewProxy fireEvent:@"scrollViewDidEndDecelerating" 
                               withObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                           NUMFLOAT(offset.x),@"x",
                                           NUMFLOAT(offset.y),@"y",
                                           NUMBOOL([scrollView isDecelerating]),@"decelerating",
                                           NUMBOOL([scrollView isDragging]),@"dragging", nil]];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView != controllingScrollView)
        return;
    CGPoint offset = [scrollView contentOffset];
    [controllingScrollViewProxy fireEvent:@"dragEnd" 
                               withObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   NUMFLOAT(offset.x),@"x",
                                                   NUMFLOAT(offset.y),@"y",
                                                   NUMBOOL([scrollView isDecelerating]),@"decelerating",
                                                   NUMBOOL([scrollView isDragging]),@"dragging", nil]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // We only care about scroll events from the view that is actually being dragged by the user.
    if (scrollView != controllingScrollView)
        return;
    
    for (TiUIScrollViewProxy* proxy in scrollViews)
    {
        
        // Skip the view that is actually scrolling,
        UIScrollView* scroll = [(TiUIScrollView*)proxy.view scrollView];
        if (scroll == controllingScrollView)
        {
            CGPoint offset = [scrollView contentOffset];
            [proxy fireEvent:@"scroll" withObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   NUMFLOAT(offset.x),@"x",
                                                   NUMFLOAT(offset.y),@"y",
                                                   NUMBOOL([scrollView isDecelerating]),@"decelerating",
                                                   NUMBOOL([scrollView isDragging]),@"dragging", nil]];
            continue;
        }
        
        // Scroll proportionally.
        [scroll setContentOffset:CGPointMake(scrollView.contentOffset.x * scroll.contentSize.width / scrollView.contentSize.width,
                                             scrollView.contentOffset.y * scroll.contentSize.height / scrollView.contentSize.height) animated:NO];
    }
}

@end
