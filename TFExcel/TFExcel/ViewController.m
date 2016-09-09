//
//  ViewController.m
//  TFExcel
//
//  Created by Fengtf on 16/9/9.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "ViewController.h"

#import "Masonry.h"
#import "TFNumber.h"
#import "Flight.h"

@interface ViewController ()<BSNumbersViewDelegate>

@property (strong, nonatomic) BSNumbersView *excelView;

@property (strong, nonnull) NSArray<Flight *> *flights;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


    [self.view addSubview:self.excelView];
//    self.excelView.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20);

    [self.excelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view).mas_offset(UIEdgeInsetsMake(50, 0, 0, 0));
    }];

    self.title = @"航班信息";

    NSArray<NSDictionary *> *flightsInfo = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"flightsInfo" ofType:@"plist"]];

    NSMutableArray<Flight *> *flights = @[].mutableCopy;
    for (NSDictionary *flightInfo in flightsInfo) {
        Flight *flight = [[Flight alloc]initWithDictionary:flightInfo];
        [flights addObject:flight];
    }
    self.flights = flights.copy;

    self.excelView.bodyData = flights;
    //optional
    self.excelView.headerData = @[@"Flight Company", @"Flight Number", @"Type Of Aircraft", @"Date", @"Place Of Departure", @"Place Of Destination", @"Departure Time", @"Arrive Time", @"Price"];
    self.excelView.freezeColumn = 1;
    self.excelView.slideBodyFont = [UIFont systemFontOfSize:14];
    self.excelView.horizontalSeparatorStyle = BSNumbersSeparatorStyleSolid;
    self.excelView.horizontalSeparatorColor = [UIColor whiteColor];
    self.excelView.verticalSeparatorColor = [UIColor greenColor];

    self.excelView.delegate = self;

    self.excelView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.excelView.layer.borderWidth = 0.5;

    [self.excelView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- BSNumbersViewDelegate

- (UIView *)numbersView:(BSNumbersView *)numbersView viewAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0 && indexPath.section != 0) {
        CGSize size = [numbersView sizeForRow:indexPath.row];
        NSString *text = [numbersView textAtIndexPath:indexPath];

        UIView *view = [UIView new];
        view.backgroundColor = [UIColor lightGrayColor];

        UIView *square = [UIView new];
        square.backgroundColor = [UIColor orangeColor];
        square.frame = CGRectMake(0, 0, 15, 15);
        square.center = CGPointMake(size.width/2 - 35, size.height/2);
        [view addSubview:square];

        UILabel *label = [UILabel new];
        label.text = text;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        label.frame = CGRectMake(0, 0, 100, 100);
        label.center = CGPointMake(size.width/2 + 10, size.height/2);
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];

        return view;
    }
    return nil;
}

- (NSAttributedString *)numbersView:(BSNumbersView *)numbersView attributedStringAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1 && indexPath.section != 0) {
        NSString *text = [numbersView textAtIndexPath:indexPath];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:text];

        [string addAttributes:@{NSForegroundColorAttributeName: [UIColor redColor],
                                NSFontAttributeName: [UIFont systemFontOfSize:11]} range:NSMakeRange(0, 2)];
        [string addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:19]} range:NSMakeRange(2, text.length - 2)];
        return string;
    }
    return nil;
}

- (void)numbersView:(BSNumbersView *)numbersView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section = %ld, row = %ld", (long)indexPath.section, (long)indexPath.row);

    //modify the text
    //1 you can use - (nullable UIView *)numbersView:(BSNumbersView *)numbersView viewAtIndexPath:(NSIndexPath *)indexPath;  return a UITextField or UITextView to modify data, and then - (void)reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
    //2 you can use UIAlertController to alert modify text

    if (indexPath.section > 0) {
        //the section 1 is header
        Flight *flight = self.flights[indexPath.section - 1];
        flight.company = @"四川航空";
        [numbersView reloadItemsAtIndexPaths:@[indexPath]];
    }
}

-(BSNumbersView *)excelView
{
    if (!_excelView) {
        _excelView = [[BSNumbersView alloc]init];
//        [self.view addSubview:_excelView];
//        _excelView.frame = self.view.bounds;
    }
    return _excelView;
}


@end
