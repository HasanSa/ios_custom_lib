//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import "HWSSearchBar.h"

@interface HWSSearchBar () <UITextFieldDelegate, UIGestureRecognizerDelegate>

/**
 *  The borderedframe of the search bar. Visible only when search mode is active.
 */

@property (nonatomic, strong) UIView *searchFrame;

@property (nonatomic, strong) UITextField *searchField;

/**
 *  The image view containing the search magnifying glass icon in white. Visible when search is not active.
 */

@property (nonatomic, strong) UIImageView *searchImageViewOff;

/**
 *  The image view containing the search magnifying glass icon in blue. Visible when search is active.
 */

@property (nonatomic, strong) UIImageView *searchImageViewOn;

/**
 *  The image view containing the circle part of the magnifying glass icon in blue.
 */

@property (nonatomic, strong) UIImageView *searchImageCircle;

/**
 *  The image view containing the left cross part of the magnifying glass icon in blue.
 */

@property (nonatomic, strong) UIImageView *searchImageCrossLeft;

/**
 *  The image view containing the right cross part of the magnifying glass icon in blue.
 */

@property (nonatomic, strong) UIImageView *searchImageCrossRight;

/**
 *  The frame of the search bar before a transition started. Only set if delegate is not nil.
 */

@property (nonatomic, assign) CGRect	originalFrame;

/**
 *  A gesture recognizer responsible for closing the keyboard once tapped on. 
 *
 *	Added to the window's root view controller view and set to allow touches to propagate to that view.
 */

@property (nonatomic, strong) UITapGestureRecognizer *keyboardDismissGestureRecognizer;

@property (nonatomic, assign) HWSSearchBarState state;

@end

static CGFloat const kHWSSearchBarInset = 11.0;
static CGFloat const kHWSSearchBarImageSize = 22.0;
static NSTimeInterval const kHWSSearchBarAnimationStepDuration = 0.25;

@implementation HWSSearchBar

#pragma mark - initialization

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), 34.0)]))
	{
        // Initialization code
		self.opaque = NO;
//        44 144 212
		self.backgroundColor = [UIColor clearColor];
		
		self.searchFrame = [[UIView alloc] initWithFrame:self.bounds];
        self.searchFrame.backgroundColor = [UIColor colorWithRed:44/255.0 green:144/255.0 blue:212/255.0 alpha:1.0];//[UIColor clearColor];
		self.searchFrame.opaque = NO;
		self.searchFrame.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.searchFrame.layer.masksToBounds = YES;
		self.searchFrame.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
		self.searchFrame.layer.borderWidth = 0.5;
		self.searchFrame.layer.borderColor = [UIColor clearColor].CGColor;
		self.searchFrame.contentMode = UIViewContentModeRedraw;
		
		[self addSubview:self.searchFrame];
		
		self.searchField = [[UITextField alloc] initWithFrame:CGRectMake(kHWSSearchBarInset, 3.0, CGRectGetWidth(self.bounds) - (2 * kHWSSearchBarInset) - kHWSSearchBarImageSize, CGRectGetHeight(self.bounds) - 6.0)];
		self.searchField.borderStyle = UITextBorderStyleNone;
		self.searchField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.searchField.font = [UIFont fontWithName:@"AvenirNext-Regular" size:20.0];
		self.searchField.textColor = [UIColor whiteColor];
		self.searchField.alpha = 0.0;
		self.searchField.delegate = self;
		
		[self.searchFrame addSubview:self.searchField];
		
		UIView *searchImageViewOnContainerView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) - kHWSSearchBarInset - kHWSSearchBarImageSize, (CGRectGetHeight(self.bounds) - kHWSSearchBarImageSize) / 2, kHWSSearchBarImageSize, kHWSSearchBarImageSize)];
		searchImageViewOnContainerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
		
		[self.searchFrame addSubview:searchImageViewOnContainerView];
		
		self.searchImageViewOn = [[UIImageView alloc] initWithFrame:searchImageViewOnContainerView.bounds];
		self.searchImageViewOn.alpha = 0.0;
		self.searchImageViewOn.image = [UIImage imageNamed:@"NavBarIconSearch_blue"];
		
		[searchImageViewOnContainerView addSubview:self.searchImageViewOn];
		
		self.searchImageCircle = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 18.0, 18.0)];
		self.searchImageCircle.alpha = 0.0;
		self.searchImageCircle.image = [UIImage imageNamed:@"NavBarIconSearchCircle_blue"];
		
		[searchImageViewOnContainerView addSubview:self.searchImageCircle];
		
		self.searchImageCrossLeft = [[UIImageView alloc] initWithFrame:CGRectMake(14.0, 14.0, 8.0, 8.0)];
		self.searchImageCrossLeft.alpha = 0.0;
		self.searchImageCrossLeft.image = [UIImage imageNamed:@"NavBarIconSearchBar_blue"];
		
		[searchImageViewOnContainerView addSubview:self.searchImageCrossLeft];

		self.searchImageCrossRight = [[UIImageView alloc] initWithFrame:CGRectMake(7.0, 7.0, 8.0, 8.0)];
		self.searchImageCrossRight.alpha = 0.0;
		self.searchImageCrossRight.image = [UIImage imageNamed:@"NavBarIconSearchBar2_blue"];
		
		[searchImageViewOnContainerView addSubview:self.searchImageCrossRight];

		self.searchImageViewOff = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) - kHWSSearchBarInset - kHWSSearchBarImageSize, (CGRectGetHeight(self.bounds) - kHWSSearchBarImageSize) / 2, kHWSSearchBarImageSize, kHWSSearchBarImageSize)];
		self.searchImageViewOff.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
		self.searchImageViewOff.alpha = 1.0;
		self.searchImageViewOff.image = [UIImage imageNamed:@"NavBarIconSearch_white"];
		
		[self.searchFrame addSubview:self.searchImageViewOff];

		UIView *tapableView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) - (2 * kHWSSearchBarInset) - kHWSSearchBarImageSize, 0.0, (2 * kHWSSearchBarInset) + kHWSSearchBarImageSize, CGRectGetHeight(self.bounds))];
		tapableView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
		[tapableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeStateIfPossible:)]];
		
		[self.searchFrame addSubview:tapableView];
		
		self.keyboardDismissGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
		self.keyboardDismissGestureRecognizer.cancelsTouchesInView = NO;
		self.keyboardDismissGestureRecognizer.delegate = self;
				
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:self.searchField];
    }
	
    return self;
}

#pragma mark - state change

- (void)changeStateIfPossible:(UITapGestureRecognizer *)gestureRecognizer
{
	switch (self.state)
	{
		case HWSSearchBarStateNormal:
		{
			[self showSearchBar:gestureRecognizer];
		}
			break;
			
		case HWSSearchBarStateSearchBarVisible:
		{
			[self hideSearchBar:gestureRecognizer];
		}
			break;
			
		case HWSSearchBarStateSearchBarHasContent:
		{
			self.searchField.text = nil;
			[self textDidChange:nil];
		}
			break;
			
		case HWSSearchBarStateTransitioning:
		{
			// Do nothing.
		}
			break;
	}
}

- (void)showSearchBar
{
    [self showSearchBar:self];
}

- (void)showSearchBar:(id)sender
{
	if (self.state == HWSSearchBarStateNormal)
	{
		if ([self.delegate respondsToSelector:@selector(searchBar:willStartTransitioningToState:)])
		{
			[self.delegate searchBar:self willStartTransitioningToState:HWSSearchBarStateSearchBarVisible];
		}
		
		self.state = HWSSearchBarStateTransitioning;
		
		self.searchField.text = nil;
		
		[UIView animateWithDuration:kHWSSearchBarAnimationStepDuration animations:^{
			
			self.searchFrame.layer.borderColor = [UIColor colorWithRed:44/255.0 green:144/255.0 blue:212/255.0 alpha:0.5].CGColor;
			
			if ([self.delegate respondsToSelector:@selector(destinationFrameForSearchBar:)])
			{
				self.originalFrame = self.frame;
				
				self.frame = [self.delegate destinationFrameForSearchBar:self];
			}
			
		} completion:^(BOOL finished) {
			
			[self.searchField becomeFirstResponder];

			[UIView animateWithDuration:kHWSSearchBarAnimationStepDuration * 2 animations:^{
				
				self.searchFrame.layer.backgroundColor = [UIColor colorWithRed:44/255.0 green:144/255.0 blue:212/255.0 alpha:0.7].CGColor;
				self.searchImageViewOff.alpha = 0.0;
				self.searchImageViewOn.alpha = 1.0;
				self.searchField.alpha = 1.0;
				
			} completion:^(BOOL finished) {
								
				self.state = HWSSearchBarStateSearchBarVisible;
				
				if ([self.delegate respondsToSelector:@selector(searchBar:didEndTransitioningFromState:)])
				{
					[self.delegate searchBar:self didEndTransitioningFromState:HWSSearchBarStateNormal];
				}
			}];
		}];
	}
}
- (void)hideSearchBar
{
    [self hideSearchBar:self];
}

- (void)hideSearchBar:(id)sender
{
	if (self.state == HWSSearchBarStateSearchBarVisible
        || self.state == HWSSearchBarStateSearchBarHasContent
        || self.state == HWSSearchBarStateTransitioning)
	{
		[self.window endEditing:YES];
		
		if ([self.delegate respondsToSelector:@selector(searchBar:willStartTransitioningToState:)])
		{
			[self.delegate searchBar:self willStartTransitioningToState:HWSSearchBarStateNormal];
		}

		self.searchField.text = nil;
		
		self.state = HWSSearchBarStateTransitioning;
		
		[UIView animateWithDuration:kHWSSearchBarAnimationStepDuration animations:^{
			
			if ([self.delegate respondsToSelector:@selector(destinationFrameForSearchBar:)])
			{
				self.frame = self.originalFrame;
			}
			
			self.searchFrame.layer.backgroundColor = [UIColor colorWithRed:44/255.0 green:144/255.0 blue:212/255.0 alpha:1.0].CGColor;
			self.searchImageViewOff.alpha = 1.0;
			self.searchImageViewOn.alpha = 0.0;
			self.searchField.alpha = 0.0;
			
		} completion:^(BOOL finished) {
			
			[UIView animateWithDuration:kHWSSearchBarAnimationStepDuration animations:^{
				
				self.searchFrame.layer.borderColor = [UIColor colorWithRed:44/255.0 green:144/255.0 blue:212/255.0 alpha:1.0].CGColor;
				
			} completion:^(BOOL finished) {
				
				self.searchImageCircle.frame = CGRectMake(0.0, 0.0, 18.0, 18.0);
				self.searchImageCrossLeft.frame = CGRectMake(14.0, 14.0, 8.0, 8.0);
				self.searchImageCircle.alpha = 0.0;
				self.searchImageCrossLeft.alpha = 0.0;
				self.searchImageCrossRight.alpha = 0.0;
				
				self.state = HWSSearchBarStateNormal;
				
				if ([self.delegate respondsToSelector:@selector(searchBar:didEndTransitioningFromState:)])
				{
					[self.delegate searchBar:self didEndTransitioningFromState:HWSSearchBarStateSearchBarVisible];
				}
			}];
		}];
	}
}

#pragma mark - keyboard handling

- (void)keyboardWillShow:(NSNotification *)notification
{
	if ([self.searchField isFirstResponder])
	{
        if ([self.delegate respondsToSelector:@selector(searchBar:willShowkeyboardAddTapGestureRecognizer:)]) {
            [self.delegate searchBar:self willShowkeyboardAddTapGestureRecognizer:self.keyboardDismissGestureRecognizer];
        }
	}
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    if ([self.searchField isFirstResponder])
    {
        CGRect keyboardFrame =[[notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        
        if ([self.delegate respondsToSelector:@selector(searchBar:didShowkeyboardWithFrame:)]) {
            [self.delegate searchBar:self didShowkeyboardWithFrame:keyboardFrame];
        }
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    if ([self.searchField isFirstResponder])
    {
        if ([self.delegate respondsToSelector:@selector(searchBar:willHidekeyboardRemoveTapGestureRecognizer:)]) {
            [self.delegate searchBar:self willHidekeyboardRemoveTapGestureRecognizer:self.keyboardDismissGestureRecognizer];
        }
        
    }
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    if ([self.delegate respondsToSelector:@selector(didHidekeyboard)]) {
        [self.delegate didHidekeyboard];
    }
}



- (void)dismissKeyboard:(UITapGestureRecognizer *)gestureRecognizer
{
	if ([self.searchField isFirstResponder])
	{
		[self.window endEditing:YES];
		
		if (self.state != HWSSearchBarStateNormal && self.search == HWSSearchNotFound)
		{
            
			[self hideSearchBar:nil];
		}
	}
}

#pragma mark - clear button handling

- (void)textDidChange:(NSNotification *)notification
{
	BOOL hasText = self.searchField.text.length != 0;
	
	if (hasText)
	{
		if (self.state == HWSSearchBarStateSearchBarVisible)
		{
			self.state = HWSSearchBarStateTransitioning;
			
			self.searchImageViewOn.alpha = 0.0;
			self.searchImageCircle.alpha = 1.0;
			self.searchImageCrossLeft.alpha = 1.0;
			
			[UIView animateWithDuration:kHWSSearchBarAnimationStepDuration animations:^{
				
				self.searchImageCircle.frame = CGRectMake(2.0, 2.0, 18.0, 18.0);
				self.searchImageCrossLeft.frame = CGRectMake(7.0, 7.0, 8.0, 8.0);
				
			} completion:^(BOOL finished) {
				
				[UIView animateWithDuration:kHWSSearchBarAnimationStepDuration animations:^{
					
					self.searchImageCrossRight.alpha = 1.0;
					
				} completion:^(BOOL finished) {
					
					self.state = HWSSearchBarStateSearchBarHasContent;
				
				}];
			}];
		}
	}
	else
	{
		if (self.state == HWSSearchBarStateSearchBarHasContent)
		{
			self.state = HWSSearchBarStateTransitioning;
			
			[UIView animateWithDuration:kHWSSearchBarAnimationStepDuration animations:^{
				
				self.searchImageCrossRight.alpha = 0.0;
				
			} completion:^(BOOL finished) {
				
				[UIView animateWithDuration:kHWSSearchBarAnimationStepDuration animations:^{
					
					self.searchImageCircle.frame = CGRectMake(0.0, 0.0, 18.0, 18.0);
					self.searchImageCrossLeft.frame = CGRectMake(14.0, 14.0, 8.0, 8.0);
					
				} completion:^(BOOL finished) {
					
					self.searchImageViewOn.alpha = 1.0;
					self.searchImageCircle.alpha = 0.0;
					self.searchImageCrossLeft.alpha = 0.0;

					self.state = HWSSearchBarStateSearchBarVisible;
					
				}];
			}];
		}
	}
	
	if ([self.delegate respondsToSelector:@selector(searchBarTextDidChange:)])
	{
		[self.delegate searchBarTextDidChange:self];
	}
}

#pragma mark - text field delegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(searchBarDidEndEditing:)]) {
        [self.delegate searchBarDidEndEditing:self];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	BOOL retVal = YES;
	
	if ([self.delegate respondsToSelector:@selector(searchBarDidTapReturn:)])
	{
		[self.delegate searchBarDidTapReturn:self];
	}
	
	return retVal;
}

#pragma mark - gesture recognizer delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
	BOOL retVal = YES;

	if (CGRectContainsPoint(self.bounds, [touch locationInView:self]))
	{
		retVal = NO;
	}
	
	return retVal;
}

#pragma mark - cleanup

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.searchField];
}

@end
