//
//  ViewController.h
//  DualTimer
//
//  Created by Mark Publicewicz on 11/7/12.
//  Copyright (c) 2012 Mark Publicewicz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIAlertViewDelegate>
{
    NSTimeInterval upperTimeBase;
    NSTimeInterval lowerTimeBase;
    
    NSTimeInterval upperTimeTotal;
    NSTimeInterval lowerTimeTotal;
    
    NSTimeInterval timerStartedAt;
    
    BOOL upperIsRunning;
    BOOL lowerIsRunning;
    
}

@property(nonatomic, strong) IBOutlet UILabel *upperLabel;
@property(nonatomic, strong) IBOutlet UILabel *lowerLabel;

@property(nonatomic, strong) IBOutlet UIButton *upperButton;
@property(nonatomic, strong) IBOutlet UIButton *lowerButton;

@property(nonatomic, strong) IBOutlet UIButton *upperResetButton;
@property(nonatomic, strong) IBOutlet UIButton *lowerResetButton;

@property(nonatomic, strong) NSTimer *timer;

-(IBAction)upperButtonTapped:(id)sender;
-(IBAction)upperResetButtonTapped:(id)sender;

-(IBAction)lowerButtonTapped:(id)sender;
-(IBAction)lowerResetButtonTapped:(id)sender;

@end
