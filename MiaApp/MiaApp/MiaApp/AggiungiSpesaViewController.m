//
//  AggiungiSpesaViewController.m
//  MiaApp
//
//  Created by Mirko on 02/09/14.
//  Copyright (c) 2014 mirko. All rights reserved.
//

#import "AggiungiSpesaViewController.h"
#import "AllegatiViewController.h"
@interface AggiungiSpesaViewController ()

@end

@implementation AggiungiSpesaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.importoTextField setKeyboardType:UIKeyboardTypeDecimalPad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)indietro:(id)sender{
    
    [self.delegate AggiungiSpesaViewControllerIndietro:self];
    
}

-(IBAction)conferma:(id)sender{
    if(self.checkImporto == NO){
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Attenzione!"
                                                          message:@"Valore non valido!"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];
    }
    else{
    
        if (jsonArray==nil) {
            jsonArray = [NSMutableArray arrayWithCapacity:10];
            [self aggiungiRecord];
    
        }
        else{
            [self aggiungiRecord];
        }
    
    }
    
}

-(IBAction)dateClicked:(id)sender{
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    NSLocale *itLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"it_IT"];
    [datePicker setLocale:itLocale];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.dateTextField setInputView:datePicker];

}

-(void)aggiungiRecord{
    
    FileOps *files = [[FileOps alloc] init];
    
    NSData* data = [files.readFromFile dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableArray *values = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    // if you are expecting  the JSON string to be in form of array else use NSDictionary instead
    
    //NSData *jsonDataR = [NSJSONSerialization dataWithJSONObject:values options:NSJSONWritingPrettyPrinted error:nil];
    
    //NSString *jsonStrR = [[NSString alloc]initWithData:jsonDataR encoding:NSJSONWritingPrettyPrinted];
    NSString *allegato = [urlAllegato absoluteString];
    
    NSDictionary* dictW = [NSDictionary dictionaryWithObjectsAndKeys:
                          self.dateTextField.text,@"data",
                          self.descTextField.text,@"descrizione",
                          self.importoTextField.text,@"importo",
                          self.catTextField.text, @"categoria",
                          allegato, @"allegato",
                          nil];
    
    [values addObject:dictW];
    
    
    NSData *jsonDataW = [NSJSONSerialization dataWithJSONObject:values
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    
    NSString *jsonStrW = [[NSString alloc] initWithData:jsonDataW
                                                 encoding:NSUTF8StringEncoding];
    
    [files WriteToStringFile:[jsonStrW mutableCopy]];
    
}

-(void)updateTextField:(id)sender
{
    
    UIDatePicker *picker = (UIDatePicker*)self.dateTextField.inputView;
    self.dateTextField.text = [NSString stringWithFormat:@"%@",
                               [self formattaDataStringa:picker.date]];
}

-(NSString*)formattaDataStringa:(NSDate*)data{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    return [dateFormatter stringFromDate:data];
}


-(BOOL)checkImporto{
    bool check;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:
                                  @"^[0-9]+([.][0-9]{2})"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];
    if ([regex numberOfMatchesInString:self.importoTextField.text options:0 range:NSMakeRange(0, self.importoTextField.text.length)]) {
        check = YES;
    }
    else{
        check = NO;
    }
    
    return check;
    
}

#pragma mark - AllegatiViewControllerDelegate

- (void)AllegatiViewController:(AllegatiViewController *)controller
                      Indietro:(NSURL*)imgUrl
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)AllegatiViewController:(AllegatiViewController *)controller
                      Conferma:(NSURL*)imgUrl
{
    urlAllegato = imgUrl;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Allegati"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        AllegatiViewController* allegatiViewController = [navigationController viewControllers][0];
        allegatiViewController.delegate = self;
    }
}

@end
