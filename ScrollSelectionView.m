//
//  HorizontalScrollSelectionView.m
//  HorizontalScrollSelectionViewDemo
//
//  Created by Katrin on 10/02/14.
//  Copyright (c) 2014 mobilab. All rights reserved.
//

#import "ScrollSelectionView.h"

@interface ScrollSelectionView()
@property (nonatomic)  int selectedItemPosition;
@property float paddingBeginning;
@property float paddingEnd;
@end

@implementation ScrollSelectionView

@synthesize selectedItemPosition = _selectedItemPosition;

@synthesize paddingBeginning = _paddingBeginning;
@synthesize paddingEnd = _paddingEnd;

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {

  }
  return self;
}

- (void)setupWithSubviews: (NSArray *) subviews {
  if (self) {
    UIView *item = [subviews firstObject];
    int padding = self.frame.size.width / 2 - item.frame.size.width / 2;
    [self setPaddingBeginning:padding];

    UIView *lastItem = [subviews lastObject];
    padding = self.frame.size.width / 2 - lastItem.frame.size.width / 2;
    [self setPaddingEnd:padding];

    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = NO;
    int xCoord = self.paddingBeginning;
    int maxHeight = 0;

    for (UIView *item in subviews) {
      if (maxHeight < item.frame.size.height) {
        maxHeight = item.frame.size.height;
      }
      CGRect frame = item.frame;
      frame.origin.x = xCoord;
      xCoord += frame.size.width;
      item.frame = frame;
      [self addSubview:item];
    }

    xCoord += self.paddingEnd;
    self.contentSize = CGSizeMake(xCoord, maxHeight);
    CGRect frame = self.frame;
    frame.size.height = maxHeight;
    [self setFrame:frame];

    self.delegate = self;
    UITapGestureRecognizer *gestureRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnScrollViewItem:)];
    [self addGestureRecognizer:gestureRecogniser];
  }
}

- (void) handleTapOnScrollViewItem:(UIGestureRecognizer*) gestureRecognizer {
  // tapping on some items will select it!
  CGPoint location = [gestureRecognizer locationInView:self];
  int selected = [self itemPosAtX:location.x];
  [self setSelectedView:[[self subviews] objectAtIndex:selected] animated:YES];
}

- (void) setScrollViewDelegate:(NSObject <ScrollSelectionViewDelegate>*)delegate {
  scrollDelegate = delegate;
}

- (void) setSelectedView: (UIView *) view animated: (BOOL) animated {
  if(view) {
    CGPoint contentOffset = [self contentOffset];
    contentOffset.x = view.frame.origin.x + view.frame.size.width / 2 - self.frame.size.width / 2;
    [self setContentOffset:contentOffset animated:animated];

    _selectedItemPosition = [[self subviews] indexOfObject:view];
  }
}

- (UIView *) selectedView {
  int selected = [self selectedItemPosition];
  UIView *selectedItem = [[self subviews] objectAtIndex:selected];
  return selectedItem;
}

- (int) selectedItemPosition {
  int selected = [self itemPosAtX:([self contentOffset].x + self.frame.size.width / 2)];
  return selected;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  int newSelectedItemPosition = [self selectedItemPosition];
  if(newSelectedItemPosition != _selectedItemPosition)
  {
    UIView *oldselectedItem = [[self subviews] objectAtIndex:_selectedItemPosition];
    UIView *newSelectedItem = [[self subviews] objectAtIndex:newSelectedItemPosition];
    _selectedItemPosition = newSelectedItemPosition;
    [scrollDelegate selectedViewChangedFrom:oldselectedItem To:newSelectedItem];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  // snap selected to center
  UIView *selectedView = [self selectedView];
  [self setSelectedView:selectedView animated:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  if(!decelerate) {
    // snap selected to center
    UIView *selectedView = [self selectedView];
    [self setSelectedView:selectedView animated:YES];
  }
}

- (int) itemPosAtX: (float) x {

  // calculate approximate position of selected view
  NSArray *subviews = [self subviews];
  float totalContentWidth = [self contentSize].width;
  float viewWidth = (totalContentWidth - self.paddingBeginning - self.paddingEnd) / subviews.count;
  int selected = (x - self.paddingBeginning) / viewWidth;

  if(selected >= subviews.count) {
    selected = subviews.count - 1;
  }

  if(selected < 0) {
    selected = 0;
  }

  // check if this is indeed correct view and make corrections if needed
  UIView *view = [subviews objectAtIndex:selected];
  float border1 = view.frame.origin.x;
  float border2 = view.frame.origin.x + view.frame.size.width;

  while (selected > 0 && x < border1) {
    selected--;
    view = [subviews objectAtIndex:selected];
    border1 = view.frame.origin.x;
    border2 = view.frame.origin.x + view.frame.size.width;
  }

  while (selected < subviews.count - 1 && x > border2) {
    selected++;
    view = [subviews objectAtIndex:selected];
    border1 = view.frame.origin.x;
    border2 = view.frame.origin.x + view.frame.size.width;
  }

  return selected;
}

@end
