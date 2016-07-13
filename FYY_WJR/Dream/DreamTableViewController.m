//
//  DreamTableViewController.m
//  FYY_WJR
//
//  Created by wjr on 16/4/29.
//  Copyright © 2016年 wjr. All rights reserved.
//

#import "DreamTableViewController.h"
#import "AddDreamViewController.h"
#import "MyTools.h"
#import "DreamDetailViewController.h"
#import "ModelTool.h"

@interface DreamTableViewController ()

@property(strong, nonatomic) ModelTool* dreamTool;

@end

@implementation DreamTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.title = @"愿望";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self clearExtraLine:self.tableView];
    
    self.dreamTool = [[ModelTool alloc]initByType:ModelTypeDream];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewDream)];
    self.navigationItem.rightBarButtonItem = addBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dreamTool getModelArr].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DreamCell"];
    
    // Configure the cell...
    DreamModel* model = [self.dreamTool getModelArr][indexPath.row];
    cell.textLabel.text = model.name;
    if ([model.isFinish isEqualToString:@"0"]) {
        cell.detailTextLabel.text = @"未完成";
    }
    else{
        cell.detailTextLabel.text = model.date;
    }
    //右边箭头样式
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DreamDetailViewController* detailVc = [[DreamDetailViewController alloc] init];
    detailVc.changedDelegate = self;
    //取得选中行
    NSIndexPath* path = [self.tableView indexPathForSelectedRow];
    detailVc.index = path.row;
    detailVc.dreamModel = [self.dreamTool getModelArr][path.row];
    [self.navigationController pushViewController:detailVc animated:YES];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dreamTool removeModel:indexPath.row];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)addNewDream{
    AddDreamViewController* addVc = [[AddDreamViewController alloc] init];
    addVc.addDelegate = self;
    [self.navigationController pushViewController:addVc animated:YES];
}

#pragma mark - 去掉table多余的线
- (void)clearExtraLine:(UITableView*)tableView {
    //用一个view做table的footerview来盖住
    UIView* view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    id vc =segue.destinationViewController;
//    //如果是跳转到添加控制器
//    if ([vc isKindOfClass:[AddDreamViewController class]]) {
//        AddDreamViewController* addVc = vc;
//        addVc.addDelegate = self;
//    }
//    else if ([vc isKindOfClass:[DreamDetailViewController class]]) {
//        DreamDetailViewController* detailVc = vc;
//        detailVc.changedDelegate = self;
//        //取得选中行
//        NSIndexPath* path = [self.tableView indexPathForSelectedRow];
//        detailVc.index = path.row;
//        detailVc.dreamModel = [self.dreamTool getDreamArr][path.row];
//    }
}

- (void)addDreamFinish{
    //刷新表视图
    [self.tableView reloadData];
}

- (void)Dreamchanged{
    [self.tableView reloadData];
}


@end
