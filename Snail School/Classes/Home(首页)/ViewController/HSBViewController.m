//
//  HSBViewController.m
//  Snail School
//
//  Created by 远深 on 15/11/10.
//  Copyright © 2015年 himooo. All rights reserved.
//

#import "HSBViewController.h"

@interface HSBViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>


@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *searchResults;


@end

@implementation HSBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for (UIView *view in self.searchBar.subviews)
    {
        if ([view isKindOfClass:NSClassFromString(@"UISeacrchBackground")])
        {
            [view removeFromSuperview];
            break;
        }
        if ([view isKindOfClass:NSClassFromString(@"UIView")]&&view.subviews.count > 0 )
        {
            [[view.subviews objectAtIndex:0]removeFromSuperview];
        }
    }
    self.items = @[@"国服第一臭豆腐 No.1 Stinky Tofu CN.",
                   @"瓦洛兰 Valoran",
                   @"德玛西亚 Demacia",
                   @"诺克萨斯 Noxus",
                   @"艾欧尼亚 Ionia",
                   @"皮尔特沃夫 Piltover",
                   @"弗雷尔卓德 Freijord",
                   @"班德尔城 Bandle City",
                   @"战争学院 The Institute of War",
                   @"祖安 Zaun",
                   @"卡拉曼达 Kalamanda",
                   @"蓝焰岛 Blue Flame Island",
                   @"哀嚎沼泽 Howling Marsh",
                   @"艾卡西亚 Icathia",
                   @"铁脊山脉 Ironspike Mountains",
                   @"库莽古丛林 Kumungu",
                   @"洛克法 Lokfar",
                   @"摩根小道 Morgon Pass",
                   @"塔尔贡山脉 Mountain Targon",
                   @"瘟疫丛林 Plague Jungles",
                   @"盘蛇河 Serpentine River",
                   @"恕瑞玛沙漠 Shurima Desert",
                   @"厄尔提斯坦 Urtistan",
                   @"巫毒之地 Voodoo Lands",
                   @"水晶之痕 Crystal Scar",
                   @"咆哮深渊 Howling Abyss",
                   @"熔岩洞窟 Magma Chambers",
                   @"试炼之地 Proving Grounds",
                   @"召唤师峡谷 Summoner's Rift",
                   @"扭曲丛林 Twisted Treeline"];

}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
    
    self.searchResults = [self.items filteredArrayUsingPredicate:resultPredicate];
}

#pragma mark - UITabelView 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return (tableView == self.tableView) ? self.items.count : self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = (tableView == self.tableView) ? self.items[indexPath.row] : self.searchResults[indexPath.row];
    
    return cell;
}

#pragma mark - UISearchDisplayController 代理

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
