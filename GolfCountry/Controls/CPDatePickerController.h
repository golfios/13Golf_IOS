//
//  CPDatePickerController.h
//  DTC_YGJT
//
//  Created by  on 12-4-10.
//  Copyright (c) 2012年 DTCLOUD_POWER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPDatePickerController : UIViewController <UIPickerViewDelegate ,UIPickerViewDataSource>

@property (retain ,nonatomic) IBOutlet UIBarButtonItem *doneBtn;

- (IBAction) doneBtnClicked:(id)sender;

@end
