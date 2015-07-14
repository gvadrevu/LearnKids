//
//  ViewController.m
//  lalilali
//
//  Created by Gopal Vadrevu on 7/7/15.
//
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController
{
    NSString* ansString;
    NSDictionary  *alphaSounds;
    NSString *arrType;
    int inc;
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
      arrType = @"Alphabets";
      alphaSounds = @{@"AAA":@"Pooji", @"A":@"PoojiA", @"B":@"PoojiB" , @"C":@"PoojiC" , @"D":@"PoojiD" , @"E":@"PoojiE" , @"F":@"PoojiF" , @"G":@"PoojiG" , @"H":@"PoojiH" , @"I":@"PoojiI" , @"J":@"PoojiJ" , @"K":@"PoojiK" , @"L":@"PoojiL" , @"M":@"PoojiM" , @"N":@"PoojiN" , @"O":@"PoojiO" , @"P":@"PoojiP", @"Q":@"PoojiQ" , @"R":@"PoojiR", @"S":@"PoojiS", @"T":@"PoojiT", @"U":@"PoojiU", @"V":@"PoojiV", @"W":@"PoojiW", @"X":@"PoojiX", @"Y":@"PoojiY", @"Z":@"PoojiZ", @"1":@"Pooji1", @"2":@"Pooji2" , @"3":@"Pooji3" , @"4":@"Pooji4" , @"5":@"Pooji5" , @"6":@"Pooji6" , @"7":@"Pooji7" , @"8":@"Pooji8" , @"9":@"Pooji9" , @"0":@"Pooji0"};
    [self showItems];
    
    
}

-(void) showItems{
    // Do any additional setup after loading the view, typically from a nib.
    NSString *usedString = @"";
    NSMutableArray *threeArray = [[NSMutableArray alloc]init];
    for(int i=0; i<3; i++){
        [threeArray addObject:[ self getRandomCharAsNSString:usedString returnType:arrType]];
        usedString = [NSString stringWithFormat:@"%@%@",usedString,[threeArray objectAtIndex:i]];
    }
    self.label1.text = [threeArray objectAtIndex:0];
    self.label2.text = [threeArray objectAtIndex:1];
    self.label3.text = [threeArray objectAtIndex:2];
    
    int rnd = arc4random_uniform((int)[threeArray count]);
    ansString = [threeArray objectAtIndex:rnd];
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    UITapGestureRecognizer* tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.label1 addGestureRecognizer:tap1];
    [self.label2 addGestureRecognizer:tap2];
    [self.label3 addGestureRecognizer:tap3];
    
    
    /* Use this code to play an audio file */
    if ([arrType  isEqual: @"Alphabets"]){
        [self playSound:@"Pooji" :@"wav"];
    }
    else if ([arrType isEqual:@"Numbers"])
    {
        [self playSound:@"Pooji" :@"wav"];
        
    }
    
    double delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self playSound:alphaSounds[ansString] :@"wav"];
    });

}

-(void)tapAction:(id)sender
{
    UIImageView *rightImg;
    UIImageView *wrongImg ;
    UITapGestureRecognizer *tapRec = (UITapGestureRecognizer *)sender;
    UILabel *label = (UILabel *)tapRec.view;
    if(label.text == ansString){
     rightImg = (UIImageView *)[self.view viewWithTag:label.tag+3];
        rightImg.hidden = NO;
        if (inc<10){
            double delayInSeconds = 2.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                rightImg.hidden = YES;
                wrongImg.hidden = YES;
                [self showItems];
            });
            inc++;
        } else
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            ViewController *homeScreen = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainScreen"];
            
         
            [self presentViewController:homeScreen animated:YES completion:nil];
        }

    }
    else{
         wrongImg = (UIImageView *)[self.view viewWithTag:label.tag+6];
        wrongImg.hidden = NO;
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            wrongImg.hidden = YES;
        });

    }
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getRandomCharAsNSString: (NSString *) usedCharString returnType:(NSString *) returnType {
  
    NSMutableArray *resultArr = [[NSMutableArray alloc]init];
    NSString * ret;
   
    if([returnType containsString:@"Alphabets"])
    {
        for (char a = 'A'; a <= 'Z'; a++)
        {
            if (![usedCharString containsString:[NSString stringWithFormat:@"%c",a] ] ){
             [resultArr  addObject:[NSString stringWithFormat:@"%c",a ] ];
            }
        }
        int rnd = arc4random_uniform((int)[resultArr count]);
        ret = [resultArr objectAtIndex:rnd];
    }
   else if([returnType containsString:@"Numbers"])
    {
        for (char a = '0'; a <= '9'; a++)
        {
            if (![usedCharString containsString:[NSString stringWithFormat:@"%c",a] ] ){
                [resultArr  addObject:[NSString stringWithFormat:@"%c",a ] ];
            }
        }
        int rnd = arc4random_uniform((int)[resultArr count]);
        ret = [resultArr objectAtIndex:rnd];
    }

    
    return ret;
}



- (void)playSound :(NSString *)fName :(NSString *) ext{
    SystemSoundID audioEffect;
    NSString *path = [[NSBundle mainBundle] pathForResource : fName ofType :ext];
    if ([[NSFileManager defaultManager] fileExistsAtPath : path]) {
        NSURL *pathURL = [NSURL fileURLWithPath: path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
        AudioServicesPlaySystemSound(audioEffect);
    }
    else {
        NSLog(@"error, file not found: %@", path);
    }
}

@end
