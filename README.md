ScrollableSelectionView
=======================

Description
-----------

ScrollSelectionView is a UI element for iOS, that enables the user to select one item from the scroll view by scrolling left/right or tapping on item. 

ScrollSelectionView takes an array of UIViews and places them into the scroll view preserving the order. The selected item is always in the middle of the scroll view. User can change selected item by scrolling left and right or tapping on item. When user stops scrolling, scroll view will correct its position so, that the selected item is in the middle.

UI views in scroll view can have different height and width. Scroll view will adjust its height so, that it matches highest item.

Basic usage
-----------
Init ScrollSelectionView

    ScrollSelectionView *scrollView = [[ScrollSelectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
  
Setup ScrollSelectionView with array of UIViews. 

    NSMutableArray *subViews = [[NSMutableArray alloc] init];
      for (int i = 0; i < 100; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [label setText:[NSString stringWithFormat:@"%i", i]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [subViews addObject:label];
    }
    [scrollView setupWithSubviews:[NSArray arrayWithArray:subViews]];
    
Set selected view

    [scrollView setSelectedView:subViews.lastObject animated:NO];
    
Get selected view

    [scrollView selectedView];
    
Additional functionality
------------------------

To make your scroll view even cooler, you might want to modify selected UIView. For example, you can change UIView background colour or text colour if you added UILabels to scroll view. 

Set ScrollSelectionViewDelegate with <i>- (void) setScrollViewDelegate:(NSObject<ScrollSelectionViewDelegate>*)delegate</i>

    [scrollView setScrollViewDelegate:self];

Implement <i>- (void)selectedViewChangedFrom: (UIView *) oldSelected To:(UIView *) newSelected</i>

    - (void)selectedViewChangedFrom: (UIView *) oldSelected To:(UIView *) newSelected {
      [((UILabel *) oldSelected) setTextColor:[UIColor grayColor]];
      [((UILabel *) newSelected) setTextColor:[UIColor greenColor]];
    }

