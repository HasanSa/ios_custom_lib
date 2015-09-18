//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipCell : UITableViewCell

+ (TipCell*) tipCell;

- (void)displayDataForPoiDescriptionText:(NSString*)text;

@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

@end
