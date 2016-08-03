# HYScrollMessage-master
很好用的文字上下滚动效果哦

使用时导入头文件#import "HYScrollMessageView.h"


@interface ViewController ()

{
    NSArray *msgArray;
}
@property (strong, nonatomic) HYScrollMessageView *messageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Message";
    msgArray= [NSArray arrayWithObjects:@"今天天气不错,哈哈",@"明天有雨，哈哈",@"后天晴天转多云",@"前天多云转晴，嘿嘿", nil];
    _messageView = [[HYScrollMessageView alloc]initWithFrame:CGRectMake(50, 100, 200, 25)];
    [_messageView makeMsgArr:msgArray];
    __weak typeof (self) myself = self;
    _messageView.messageClickBlock = ^(){
        WebViewController *vc = [[WebViewController alloc] init];
        [myself.navigationController pushViewController:vc animated:YES];
    };
    [self.view addSubview:_messageView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
     [_messageView startTimer];
}

- (void)viewWillDisappear:(BOOL)animated{
    [_messageView stopTimer];
}
