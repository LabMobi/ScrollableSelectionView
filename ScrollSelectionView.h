//
//  HorizontalScrollSelectionView.h
//  HorizontalScrollSelectionViewDemo
//
//  Created by Katrin on 10/02/14.
//  Copyright (c) 2014 mobilab. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollSelectionViewDelegate
- (void)selectedViewChangedFrom: (UIView *) oldSelected To:(UIView *) newSelected;
@end


@interface ScrollSelectionView : UIScrollView <UIScrollViewDelegate> {
  NSObject <ScrollSelectionViewDelegate> *scrollDelegate;
}

- (UIView *) selectedView;
- (void) setSelectedView: (UIView *) view animated: (BOOL) animated;
- (void) setupWithSubviews: (NSArray *) subviews;
- (void) setScrollViewDelegate:(NSObject<ScrollSelectionViewDelegate>*)delegate;

@end
