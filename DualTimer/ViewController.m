//
//  ViewController.m
//  DualTimer
//
//  Created by Mark Publicewicz on 11/7/12.
//  Copyright (c) 2012 Mark Publicewicz. All rights reserved.
//

#import "ViewController.h"

#define TIMER_TICK_INTERVAL 0.1

@interface ViewController ()

-(void)changeButtonLabel:(UIButton*)button label:(NSString*)label;
-(void)timerStart;
-(void)timerStop;
-(void)timerTick;

@end

@implementation ViewController

@synthesize timer;

@synthesize upperButton;
@synthesize lowerButton;

@synthesize upperLabel;
@synthesize lowerLabel;

-(IBAction)upperButtonTapped:(id)sender
{
    if (upperIsRunning) {
        [self timerStop];
        upperTimeBase = upperTimeTotal;
        [self changeButtonLabel:upperButton label:@"START"];
        upperIsRunning = NO;
    } else {
        if (lowerIsRunning) {
            [self timerStop];
            lowerTimeBase = lowerTimeTotal;
            [self changeButtonLabel:lowerButton label:@"START"];
        }
        [self changeButtonLabel:upperButton label:@"STOP"];
        lowerIsRunning = NO;
        upperIsRunning = YES;
        [self timerStart];
    }
}

-(IBAction)lowerButtonTapped:(id)sender
{
    if (lowerIsRunning) {
        [self timerStop];
        lowerTimeBase = lowerTimeTotal;
        [self changeButtonLabel:lowerButton label:@"START"];
        lowerIsRunning = NO;
    } else {
        if (upperIsRunning) {
            [self timerStop];
            upperTimeBase = upperTimeTotal;
            [self changeButtonLabel:upperButton label:@"START"];
        }
        [self changeButtonLabel:lowerButton label:@"STOP"];        
        upperIsRunning = NO;
        lowerIsRunning = YES;
        [self timerStart];
    }
}

- (void)viewDidLoad
{
    upperIsRunning = NO;
    lowerIsRunning = NO;
    
    upperTimeTotal = 0;
    upperTimeBase = 0;

    lowerTimeTotal = 0;
    lowerTimeBase = 0;
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeButtonLabel:(UIButton *)button label:(NSString *)label
{
    [button setTitle:label forState:UIControlStateNormal];
    [button setTitle:label forState:UIControlStateHighlighted];
}

-(void)timerStop
{
    [self.timer invalidate];
}

-(void)timerStart
{        
    timerStartedAt = [[NSDate date] timeIntervalSince1970];
    
    self.timer = [NSTimer timerWithTimeInterval:TIMER_TICK_INTERVAL target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

-(NSString*)timeLabel:(NSTimeInterval)interval
{
    NSInteger hours = interval / 3600;    
    interval -= hours * 3600;
    NSInteger minutes = interval / 60;    
    NSInteger seconds = (NSInteger)interval % 60;
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
}

-(void)timerTick
{
    NSTimeInterval chunkLength = [[NSDate date] timeIntervalSince1970] - timerStartedAt;
    if (upperIsRunning) {
        upperTimeTotal = upperTimeBase + chunkLength;
        upperLabel.text = [self timeLabel:upperTimeTotal];
    } else if (lowerIsRunning) {
        lowerTimeTotal = lowerTimeBase + chunkLength;
        lowerLabel.text = [self timeLabel:lowerTimeTotal];
    }
}

-(void)dealloc
{
    
    [timer invalidate];
    [timer release];
    
    [upperLabel release];
    [lowerLabel release];
    
    [upperButton release];
    [lowerButton release];
    
    [super dealloc];
}

@end
