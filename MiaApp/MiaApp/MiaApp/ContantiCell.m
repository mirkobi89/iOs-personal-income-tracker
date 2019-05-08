//
//  ContantiCell.m
//  MiaApp
//
//  Created by Mirko on 11/09/14.
//  Copyright (c) 2014 mirko. All rights reserved.
//

#import "ContantiCell.h"

@implementation ContantiCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)buttonClicked:(UIButton *)sender {
    if (_delegate &&
        [_delegate respondsToSelector:@selector(didClickOnCellAtIndex:withData:)]) {
            [_delegate didClickOnCellAtIndex:cellIndex
                                    withData:allegato];
    }
}

-(void)setAllegato:(NSString*)url{
    allegato = url;
}
-(NSString*)getAllegato{
    return allegato;
}
-(void)setCellIndex:(NSInteger)indx{
    cellIndex = indx;
}
-(NSInteger)getCellIndex{
    return cellIndex;
}


@end
