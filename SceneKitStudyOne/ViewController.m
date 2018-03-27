//
//  ViewController.m
//  SceneKitStudyOne
//
//  Created by 王涛 on 2018/3/27.
//  Copyright © 2018年 王涛. All rights reserved.
//

#import "ViewController.h"
#import "WTMusicPlayNode.h"

@interface ViewController ()
@property (nonatomic, strong) SCNView *scnView;
@property (nonatomic, strong) SCNNode *scnNode;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSceneView];
    [self setupSceneNode];
//    [self addGeometry];
    [self addMusic];
}

- (void)setupSceneView {
    self.view.backgroundColor = [UIColor whiteColor];
    _scnView = [[SCNView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    _scnView.center = self.view.center;
    _scnView.backgroundColor = [UIColor lightGrayColor];
    _scnView.scene = [SCNScene new];// 设置场景
    _scnView.allowsCameraControl = YES;
    [self.view addSubview:_scnView];
}

- (void)setupSceneNode {
    //创建节点
    _scnNode = [[SCNNode alloc] init];
    _scnNode.position = SCNVector3Make(5, 5, 2);
    [_scnView.scene.rootNode addChildNode:_scnNode];
    
    // create and add a light to the scene
    SCNNode *lightNode = [SCNNode node];
    lightNode.light = [SCNLight light];
    lightNode.light.type = SCNLightTypeOmni;
    lightNode.position = SCNVector3Make(0, 10, 10);
    [_scnView.scene.rootNode addChildNode:lightNode];
    
    // create and add an ambient light to the scene
    SCNNode *ambientLightNode = [SCNNode node];
    ambientLightNode.light = [SCNLight light];
    ambientLightNode.light.type = SCNLightTypeAmbient;
//    ambientLightNode.light.color = [UIColor redColor];
    [_scnView.scene.rootNode addChildNode:ambientLightNode];
    // 设置相机的位置。决定你所看到的范围
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera.automaticallyAdjustsZRange = YES;
    cameraNode.camera = [SCNCamera camera];
    [_scnView.scene.rootNode addChildNode:cameraNode];
    cameraNode.position = SCNVector3Make(0, 0, 10);
}

- (void)addGeometry {
    //盒子
    SCNBox *box = [SCNBox boxWithWidth:2 height:2 length:2 chamferRadius:0];
    SCNNode *geometryNode = [[SCNNode alloc] init];
    geometryNode.geometry = box;
    box.firstMaterial.diffuse.contents = [UIImage imageNamed:@"Alipay"];
    [_scnView.scene.rootNode addChildNode:geometryNode];
}



- (void)addMusic {
    NSString *videoPathString = [[NSBundle mainBundle] pathForResource:@"今生今世遥不可及" ofType:@"mp3"];
    WTMusicPlayNode *musciNode = [[WTMusicPlayNode alloc] initWithMusicPathString:videoPathString];
    [musciNode play];
    [_scnView.scene.rootNode addChildNode:musciNode];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches allObjects].firstObject;
    CGPoint touchPoint = [touch locationInView:self.scnView];
    NSArray *hitResults = [self.scnView hitTest:touchPoint options:nil];
    if (hitResults.count > 0) {
        SCNHitTestResult * hit = [hitResults firstObject];
        SCNNode *node = hit.node;
        if ([node isKindOfClass:[WTMusicPlayNode class]]) {
            WTMusicPlayNode *mNode = (WTMusicPlayNode *)node;
            if ([mNode isPlaying]) {
                [mNode pause];
            } else {
                [mNode play];
            }
        }
    }
}

@end
