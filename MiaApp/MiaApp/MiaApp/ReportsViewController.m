//
//  ReportsViewController.m
//  MiaApp
//
//  Created by Xcode on 26/09/14.
//  Copyright (c) 2014 mirko. All rights reserved.
//

#import "ReportsViewController.h"
#import "ReportsCell.h"
#import "FileOps.h"
#import "Categorie.h"
@interface ReportsViewController ()

@end

@implementation ReportsViewController


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
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.currentDate = [NSDate date];
    self.dateBar.title = [self formatDateBar:self.currentDate];
    self.tableViewArray = [self recuperaRaccoltaCategorie];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self recuperaRaccoltaCategorie] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReportsCell* cell = [tableView dequeueReusableCellWithIdentifier: @"ReportsCell" forIndexPath:indexPath];

    NSInteger indx = indexPath.row;
    Categorie* cat = [[Categorie alloc]init];
     
    cat = [self.tableViewArray objectAtIndex:indx];
    cell.catLabel.text = cat.nome;
    cell.totLabel.text = [NSString stringWithFormat:@"%.2f",cat.totale];
    cell.percLabel.text = [NSString stringWithFormat:@"%.2f",cat.percentuale];
    
    
    return cell;
    
}


-(IBAction)prec:(id)sender{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:components toDate:self.currentDate options:0];
    self.currentDate = newDate;
    self.dateBar.title = [self formatDateBar:newDate];
    self.tableViewArray = [self recuperaRaccoltaCategorie];
    [self.tableView reloadData];
    
}

-(IBAction)succ:(id)sender{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:components toDate:self.currentDate options:0];
    self.currentDate = newDate;
    self.dateBar.title = [self formatDateBar:newDate];
    self.tableViewArray = [self recuperaRaccoltaCategorie];
    [self.tableView reloadData];
}

-(NSString*)formatDateBar:(NSDate*)date{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *itLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"it_IT"];
    [dateFormatter setLocale:itLocale];
    [dateFormatter setDateFormat:@"MMMM, yyyy"];
    NSString* dateString = [dateFormatter stringFromDate:date];

    return dateString;
    
}

-(NSArray*)recuperaRaccoltaCategorie{
    
    FileOps* files = [[FileOps alloc]init];
    
    NSError* error;
    NSData* jsonData = [files.readFromFile dataUsingEncoding:NSUTF8StringEncoding];
    NSArray* array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    
    NSArray* arrayCat = [self arrayCategorie];
    NSMutableArray* raccolta = [NSMutableArray arrayWithCapacity:10];
    
    
    for (NSString* catElem in arrayCat) {
        
        Categorie* elemento = [[Categorie alloc]init];
        elemento.nome = catElem;
        elemento.totale = 0;
        elemento.percentuale = 0;
        for (NSDictionary *object in array) {
        
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"dd-MM-yyyy"];
            NSDate* dateToCheck = [dateFormatter dateFromString:
                           [object objectForKey:@"data"]];
            
            if([self isDateThisMonth:dateToCheck]){
                if ([[object objectForKey:@"categoria"] isEqualToString:catElem]) {
                    
                    elemento.totale = elemento.totale+
                    [[object objectForKey:@"importo"] doubleValue];
                }
                
            }
        }
        [raccolta addObject:elemento];
        
    }
    double totCat = 0;
    for (Categorie* catElem in raccolta) {
        totCat = totCat + catElem.totale;
    }
    for (Categorie* catElem in raccolta) {
        catElem.percentuale = (catElem.totale/totCat)*100;
        if (totCat==0) {
            catElem.percentuale = 0;
        }
    }
    
    return raccolta;
}

-(BOOL)isDateThisMonth:(NSDate *)date {
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.currentDate];
    [comp setDay:1];
    NSDate *firstDayOfMonth = [gregorian dateFromComponents:comp];
    [comp setMonth:[comp month]+1];
    [comp setDay:0];
    NSDate *lastDayofMonth = [gregorian dateFromComponents:comp];
    
    NSTimeInterval extends;
    NSCalendar *cal=[NSCalendar autoupdatingCurrentCalendar];
  
    BOOL success= [cal rangeOfUnit:NSMonthCalendarUnit startDate:&firstDayOfMonth
                          interval: &extends forDate:lastDayofMonth];
    if(!success)return NO;
    NSTimeInterval dateInSecs = [date timeIntervalSinceReferenceDate];
    NSTimeInterval dayStartInSecs= [firstDayOfMonth timeIntervalSinceReferenceDate];
    if(dateInSecs > dayStartInSecs && dateInSecs < (dayStartInSecs+extends)){
        return YES;
    }
    else {
        return NO;
    }}

-(NSArray*)arrayCategorie{
    
    FileOps* files = [[FileOps alloc]init];
    NSMutableArray* arrayCat = [NSMutableArray arrayWithCapacity:10];
    NSError* error;
    NSData* jsonData = [files.readFromFile dataUsingEncoding:NSUTF8StringEncoding];
    NSArray* array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    
    for (NSDictionary *object in array) {
        NSString* newCat = [object objectForKey:@"categoria"];
        [arrayCat addObject:newCat];
}
    NSArray *noDuplicates = [[NSSet setWithArray: arrayCat] allObjects];
    return  noDuplicates;
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

