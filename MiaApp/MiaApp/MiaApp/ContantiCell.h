//
//  ContantiCell.h
//  MiaApp
//
//  Created by Mirko on 11/09/14.
//  Copyright (c) 2014 mirko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellDelegate <NSObject>
- (void)didClickOnCellAtIndex:(NSInteger)cellIndex withData:(NSString*)data;
@end

@interface ContantiCell : UITableViewCell
{
    NSString* allegato;
    NSInteger cellIndex;
}

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *impLabel;
@property (weak, nonatomic) id <CellDelegate>delegate;

-(IBAction)buttonClicked:(UIButton *)sender;
-(void)setAllegato:(NSString*)url;
-(NSString*)getAllegato;
-(void)setCellIndex:(NSInteger)indx;
-(NSInteger)getCellIndex;

@end
