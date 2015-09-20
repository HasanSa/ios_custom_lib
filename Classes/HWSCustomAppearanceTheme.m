//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import "HWSCustomAppearanceTheme.h"
#import "HWSAppearanceDecoder.h"

@implementation HWSCustomAppearanceTheme

- (UIStatusBarStyle)statusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIColor *)mainColor
{
    
    return [[HWSAppearanceDecoder appearanceData] mainColor];
}

- (UIColor *)secondColor
{
    return  [[HWSAppearanceDecoder appearanceData] secondColor];
}

- (UIColor *)navigationTextColor
{
    return [[HWSAppearanceDecoder appearanceData] navigationTextColor];
}

- (UIColor *)highlightColor
{
    return [[HWSAppearanceDecoder appearanceData] highlightColor];
}

- (UIColor *)shadowColor
{
    return [[HWSAppearanceDecoder appearanceData] shadowColor];
}

- (UIColor *)highlightShadowColor
{
    return [[HWSAppearanceDecoder appearanceData] highlightShadowColor];;
}

- (UIColor *)navigationTextShadowColor
{
    return [[HWSAppearanceDecoder appearanceData] navigationTextShadowColor];
}

- (UIFont *)navigationFont
{
    return [UIFont fontWithName:[[HWSAppearanceDecoder appearanceData] navigationFont] size:16.5f];
}

- (UIFont *)barButtonFont
{
    return [UIFont fontWithName:[[HWSAppearanceDecoder appearanceData] barButtonFont] size:14.5f];
}

- (UIColor *)backgroundColor
{
    return [[HWSAppearanceDecoder appearanceData] backgroundColor];
}

- (UIColor *)baseTintColor
{
    return [[HWSAppearanceDecoder appearanceData] baseTintColor];
}

- (CGSize)shadowOffset
{
    return CGSizeMake(0, 0);
}

- (UIImage *)topShadow
{
    return nil;
}

- (UIColor *)tabbarTintColor
{
    return [[HWSAppearanceDecoder appearanceData] tabbarTintColor];
}

- (UIColor *)selectedTabbarItemTintColor
{
    return [[HWSAppearanceDecoder appearanceData] selectedTabbarItemTintColor];
}

- (UIColor *)segmentedTintColor
{
    return [[HWSAppearanceDecoder appearanceData] segmentedTintColor];
}

- (UIImage *)navigationBackgroundForBarMetrics:(UIBarMetrics)metrics
{
    NSString * name = [[HWSAppearanceDecoder appearanceData] navigationBackground];
    //    if (metrics == UIBarMetricsLandscapePhone) {
    //        name = [name stringByAppendingString:@"Landscape"];
    //    }
    UIImage * image =  [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    CGFloat height = 64;
    CGFloat width = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 320 : (metrics == UIBarMetricsCompact ? 1024 : 768);
    UIImage * bottomImage = [self viewBackground];
    
    CGSize newSize = CGSizeMake(width, height);
    UIGraphicsBeginImageContext( newSize );
    
    [bottomImage drawInRect:CGRectMake(0, 0, newSize.width, bottomImage.size.height)];
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height) blendMode:kCGBlendModeNormal alpha:1];
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)barButtonBackgroundForState:(UIControlState)state style:(UIBarButtonItemStyle)style barMetrics:(UIBarMetrics)barMetrics
{
    NSString * name = [[HWSAppearanceDecoder appearanceData] barButtonBackground];
    if (style == UIBarButtonItemStyleDone) {
        name = [name stringByAppendingString:@"Done"];
    }
    if (barMetrics == UIBarMetricsCompact) {
        name = [name stringByAppendingString:@"Landscape"];
    }
    if (state == UIControlStateHighlighted) {
        name = [name stringByAppendingString:@"Highlighted"];
    }
    UIImage * image = [UIImage imageNamed:name];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
    return image;
}

- (UIImage *)backBackgroundForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics
{
    NSString * name = [[HWSAppearanceDecoder appearanceData] backBackground];
    if (barMetrics == UIBarMetricsCompact) {
        name = [name stringByAppendingString:@"Landscape"];
    }
    if (state == UIControlStateHighlighted) {
        name = [name stringByAppendingString:@"Highlighted"];
    }
    UIImage * image = [UIImage imageNamed:name];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 17.0, 0.0, 5.0)];
    return image;
}

- (UIImage *)toolbarBackgroundForBarMetrics:(UIBarMetrics)metrics
{
    NSString * name =[[HWSAppearanceDecoder appearanceData] toolbarBackground];
    if (metrics == UIBarMetricsCompact) {
        name = [name stringByAppendingString:@"Landscape"];
    }
    UIImage * image = [UIImage imageNamed:name];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 8.0, 0.0, 0)];
    return image;
}

- (UIImage *)tableBackground
{
    //    UIImage * image = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? [UIImage imageNamed:@"background-568h"] : [UIImage imageNamed:@"aBackground"];
    UIImage * image = [UIImage imageNamed:[[HWSAppearanceDecoder appearanceData] tableBackground]];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsZero];
    return image;
}

- (UIImage *)tableSectionHeaderBackground
{
    UIImage * image = [UIImage imageNamed:[[HWSAppearanceDecoder appearanceData] tableSectionHeaderBackground]];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsZero];
    return image;
}


- (UIImage *)tableFooterBackground
{
    UIImage * image = [UIImage imageNamed:[[HWSAppearanceDecoder appearanceData] tableFooterBackground]];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsZero];
    return image;
}

- (UIImage *)viewBackground
{
    //    UIImage * image = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? [UIImage imageNamed:@"background-568h"] : [UIImage imageNamed:@"aBackground"];
    UIImage * image = [UIImage imageNamed:[[HWSAppearanceDecoder appearanceData] viewBackground]];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsZero];
    return image;
}

- (UIImage *)buttonBackgroundForState:(UIControlState)state
{
    NSString * name =[[HWSAppearanceDecoder appearanceData] buttonBackground];
    if (state == UIControlStateHighlighted) {
        name = [name stringByAppendingString:@"Highlighted"];
    } else if (state == UIControlStateDisabled) {
        name = [name stringByAppendingString:@"Disabled"];
    }
    UIImage * image = [UIImage imageNamed:name];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 16.0, 0.0, 16.0)];
    return image;
}

- (UIImage *)tabBarBackground
{
    return nil;
    //    UIImage * bottomImage = [self viewBackground];
    //    NSString * name       = [[AppearanceDecoder appearanceData] tabBarBackground];
    //    UIImage * image       = [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 0, 0)];
    //
    //    CGSize newSize = CGSizeMake(320, 45);
    //    UIGraphicsBeginImageContext( newSize );
    //
    //    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    //    CGFloat padding;
    //    if(UIInterfaceOrientationIsLandscape(window.rootViewController.interfaceOrientation)) {
    //        padding = bottomImage.size.height - (bottomImage.size.height - CGRectGetMaxX(window.frame) + 45);
    //    } else {
    //        padding = bottomImage.size.height - (CGRectGetMaxY(window.frame) - bottomImage.size.height + 45);
    //    }
    //    [bottomImage drawInRect:CGRectMake(0, -padding, newSize.width, bottomImage.size.height)];
    //
    //
    //    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height) blendMode:kCGBlendModeNormal alpha:1];
    //    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //
    //    UIGraphicsEndImageContext();
    //
    //    return newImage;
}

- (UIImage *)tabBarSelectionIndicator
{
    return [UIImage imageNamed:[[HWSAppearanceDecoder appearanceData] tabBarSelectionIndicator]];
}

- (UIImage *)imageForTab:(ThemeTab)tab
{
    return nil;
}

- (UIImage *)finishedImageForTab:(ThemeTab)tab selected:(BOOL)selected
{
    NSString * name = nil;
    if (tab == ThemeTabSecure) {
        name = @"tabbar-tab1";
    } else if (tab == ThemeTabDocs) {
        name = @"tabbar-tab2";
    } else if (tab == ThemeTabBugs) {
        name = @"tabbar-tab3";
    } else if (tab == ThemeTabBook) {
        name = @"tabbar-tab4";
    } else if (tab == ThemeTabOptions) {
        name = @"tabbar-tab5";
    }
    //    if (selected) {
    //        name = [name stringByAppendingString:@"-selected"];
    //    }
    return (name ? [UIImage imageNamed:name] : nil);
}

@end
