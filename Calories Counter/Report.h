#import <UIKit/UIKit.h>
@interface Report : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic ,retain) IBOutlet UIBarButtonItem *back;
@property (nonatomic ,retain) IBOutlet UICollectionView *canlender;
@property(nonatomic ,retain )  IBOutlet UIDatePicker *Date;
@property (retain ,nonatomic) IBOutlet UILabel * weight;

-(IBAction)datechnage:(id)sender;
-(IBAction) Back:(id)sender;
@end
