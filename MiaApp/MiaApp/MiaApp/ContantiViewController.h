//
//  ContantiViewController.h
//  MiaApp
//
//  Created by Mirko on 11/08/14.
//  Copyright (c) 2014 mirko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AggiungiSpesaViewController.h"
#import "ContantiCell.h"

@class ContantiViewController;

@protocol ContantiViewControllerDelegate <NSObject>
-(void)contantiViewControllerAggiungi:(ContantiViewController*)controller;
@end

@interface ContantiViewController : UITableViewController<AggiungiSpesaViewControllerDelegate,CellDelegate>
{
    UIImageView *imgV;
}

@property (nonatomic,weak) id <ContantiViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *deleteButton;

@property (strong, nonatomic) NSMutableArray* dataArray;

@end
