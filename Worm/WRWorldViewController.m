//
//  WRWorldViewController.m
//  Worm
//
//  Created by Jon Como on 4/4/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "WRWorldViewController.h"
#import "WRWorldScene.h"

#import "Notifications.h"

@interface WRWorldViewController ()
{
    SKScene *world;
}

@end

@implementation WRWorldViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    world = [WRWorldScene sceneWithSize:CGSizeMake(skView.frame.size.height, skView.frame.size.width)];
    world.scaleMode = SKSceneScaleModeAspectFit;
    
    // Present the scene.
    [skView presentScene:world];
    
    
    __weak WRWorldViewController *weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:WR_GAME_OVER object:nil queue:[NSOperationQueue new] usingBlock:^(NSNotification *note) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
