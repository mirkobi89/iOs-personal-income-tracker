//
//  AllegatiViewController.h
//  MiaApp
//
//  Created by Mirko on 16/10/14.
//  Copyright (c) 2014 mirko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AllegatiViewController;

@protocol AllegatiViewControllerDelegate <NSObject>
-(void)AllegatiViewController:(AllegatiViewController*)controller Indietro:(NSURL*)imgUrl;
-(void)AllegatiViewController:(AllegatiViewController*)controller Conferma:(NSURL*)imgUrl;
@end

@interface AllegatiViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *ipc;
    UIPopoverController *popover;
    NSURL* urlAllegato;
}

@property (nonatomic,weak) id <AllegatiViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *btnGallery;
@property (weak, nonatomic) IBOutlet UIButton *btnCamera;
@property (weak, nonatomic) IBOutlet UIImageView *ivPickedImage;

-(IBAction)indietro:(id)sender;
-(IBAction)conferma:(id)sender;

@end
