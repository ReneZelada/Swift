//
//  ViewController.m
//  Conversor
//
//  Created by René Zelada on 7/7/21.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)Convertir:(UIButton *)sender {
    float dolarValue = [self.dinero.text floatValue];
    float res = dolarValue * 8;
    [self.resultado setText: [NSString stringWithFormat:@"Quetzales %.2f",res]];
    self.resultado.hidden = NO;
}


@end
