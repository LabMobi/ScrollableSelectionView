ScrollableSelectionView
=======================

Description
-----------

ScrollSelectionView is UI element for iOS, that enables user to select one item from scroll view by scrolling left/right or tapping on item. 

You can give ScrollSelectionView an array of UIViews and it will place them into scroll view in same order. The item in the middle of scroll view is always counted as selected. User can change selected item by scrolling left and right or tapping on item. When user stops scrolling, scroll view will correct its position so, that selected item is in the middle.

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

To make your scroll view even cooler, you might want to modify selected UIView. For example, you can change UIView background color or text color if you added UILabels. 

Set ScrollSelectionViewDelegate with <i>- (void) setScrollViewDelegate:(NSObject<ScrollSelectionViewDelegate>*)delegate</i>

    [scrollView setScrollViewDelegate:self];

Implement <i>- (void)selectedViewChangedFrom: (UIView *) oldSelected To:(UIView *) newSelected</i>

    - (void)selectedViewChangedFrom: (UIView *) oldSelected To:(UIView *) newSelected {
      [((UILabel *) oldSelected) setTextColor:[UIColor grayColor]];
      [((UILabel *) newSelected) setTextColor:[UIColor greenColor]];
    }

