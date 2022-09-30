//
//  ViewController.m
//  iOS16OrientationDemo
//
//  Created by mntechMac on 2022/9/30.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;
@property (weak, nonatomic) IBOutlet UIButton *changeOrientations;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _scroller.maximumZoomScale = 1.7;
}
- (IBAction)gotoChangeScreenAction:(UIButton *)sender {
    
    sender.selected = !sender.isSelected;
    
    [self setNeedsUpdateOfSupportedInterfaceOrientations];
    NSArray *array = [[[UIApplication sharedApplication] connectedScenes] allObjects];
    UIWindowScene *scene = [array firstObject];
    UIWindowSceneGeometryPreferencesIOS *pIOS = [[UIWindowSceneGeometryPreferencesIOS alloc] init];
    if (sender.isSelected) {
        // to full screen
        pIOS.interfaceOrientations = UIInterfaceOrientationMaskLandscapeRight;
            
    } else {
        pIOS.interfaceOrientations = UIInterfaceOrientationMaskPortrait;
    }
    [scene requestGeometryUpdateWithPreferences:pIOS errorHandler:^(NSError * _Nonnull error) {
    }];
    
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    NSLog(@"size width: %f, height: %f", size.width, size.height);
    // 注释这段代码感受BUG😄
    _changeOrientations.selected = size.width > size.height;
    if (size.width > size.height) {
        _top.constant = 0;
        _bottom.active = true;
        
    } else {
        _top.constant = 20;
        _bottom.active = false;
    }
    
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _videoView;
}

@end
