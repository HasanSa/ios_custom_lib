//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWSSidebarViewController : UITableViewController

@property (nonatomic, readonly) id homeViewController;
@property (nonatomic, readonly) id mapViewController;

- (void)updateMapItemAsSelectedCell;

@end
