//
//  ViewController.m
//  Test_NSUrlSession
//
//  Created by Eduardo Flores on 3/24/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "ViewController.h"

#define URL_CAR_1   @"http://i.telegraph.co.uk/multimedia/archive/02556/Ford-Fiesta-2_2556130k.jpg"
#define URL_CAR_2   @"http://i.telegraph.co.uk/multimedia/archive/01433/cruze1_1433175c.jpg"

@interface ViewController ()

@end

@implementation ViewController
@synthesize label_status, imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button_useNSURLConnection:(id)sender
{
    label_status.text = @"Selected NSURLConnection";
    
    NSURL *url = [NSURL URLWithString:URL_CAR_1];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    dispatch_queue_t loadQ = dispatch_queue_create("DownloadQueue", NULL);
    dispatch_sync(loadQ,
                  ^{
                      NSData *data = [NSURLConnection sendSynchronousRequest:request
                                                           returningResponse:nil
                                                                       error:nil];
                      dispatch_async(dispatch_get_main_queue(),
                                     ^{
                                         imageView.image = [UIImage imageWithData:data];
                                     });
                  });
    
    
}


- (NSURLSession *)getURLSession
{
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
                      session = [NSURLSession sessionWithConfiguration:configuration];
                  });
    return session;
}

- (IBAction)button_useNSURLSession:(id)sender
{
    label_status.text = @"Selected NSURLSession";
    
    NSURL *url = [NSURL URLWithString:URL_CAR_2];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *task = [[self getURLSession]
                                  dataTaskWithRequest:request
                                  completionHandler:^(NSData *data,
                                                      NSURLResponse *response,
                                                      NSError *error)
    {
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           imageView.image = [UIImage imageWithData:data];
                       });
        
    }];
    
    [task resume];
}
@end















































