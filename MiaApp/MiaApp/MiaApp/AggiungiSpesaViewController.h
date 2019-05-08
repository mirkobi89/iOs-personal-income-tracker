//
//  AggiungiSpesaViewController.h
//  MiaApp
//
//  Created by Mirko on 02/09/14.
//  Copyright (c) 2014 mirko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileOps.h"
#import "AllegatiViewController.h"

@class AggiungiSpesaViewController;

@protocol AggiungiSpesaViewControllerDelegate <NSObject>
-(void)AggiungiSpesaViewControllerIndietro:(AggiungiSpesaViewController*)controller;
-(void)AggiungiSpesaViewControllerConferma:(AggiungiSpesaViewController*)controller;
@end

@interface AggiungiSpesaViewController : UIViewController
                                        <AllegatiViewControllerDelegate>
{
    NSURL* urlAllegato;
    NSMutableArray* jsonArray;
    NSMutableArray* jsonObject;
}

@property (nonatomic,weak) id <AggiungiSpesaViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *descTextField;
@property (weak, nonatomic) IBOutlet UITextField *importoTextField;
@property (weak, nonatomic) IBOutlet UITextField *catTextField;


-(IBAction)indietro:(id)sender;
-(IBAction)conferma:(id)sender;
-(IBAction)dateClicked:(id)sender;
-(void)updateTextField:(id)sender;

-(NSString*)formattaDataStringa:(NSDate*)data;
@end
