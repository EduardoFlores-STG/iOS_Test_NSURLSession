//
//  ViewController.h
//  Test_NSUrlSession
//
//  Created by Eduardo Flores on 3/24/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)button_useNSURLConnection:(id)sender;
- (IBAction)button_useNSURLSession:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *label_status;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

