# LYSheetController
> A simple, powerful pop-up menu view
![](https://img.shields.io/badge/version-0.0.2-blue.svg)
# 设计思路
设计仿照了系统的 `UITableView`,其实内部的实现也是一个使用了系统的`UITableView`。依于此，我们可以使用`- registSheetControllerCell:forStyle:`大大提高扩展性.

# 使用 Usage - V0.0.2
由于仿照了`UITableView`的设计思路，所以，你可以像使用`UITableView`一样，使用`LYShetController`.

```
    // init
    LYSheetController *sheet = [[LYSheetController alloc] init];
    // or LYSheetController *sheet = [[LYSheetController alloc] initWithDataSource:datasource];
    sheet.delegate = self;
    
    // show
    [sheet showSheetControllerWithAnimated:YES completionHandler:nil];
    
    // dismiss
    [sheet dismissSheetControllerWithAnimated:YES completionHandler:nil];
    
    // action handle
    - (void)sheetController:(LYSheetController *)sheetController didSelectRowAtIndexPath:(NSInteger)indexPath;
```
## 自定义 Custom
此外， `LYSheetController`还支持高度自定义。
在`0.0.2`时候，把继承子类的自定义方式变为了遵守协议：`LYSheetModel` - 自定义数据`Model`,`LYSheetCell` - 自定义`Cell`，大大提高了灵活性。所以，你可以自定义任何`Cell`，`LYSheetCell`中没有任何必须要遵守的协议，只是给你提供了一些比较常用的，以方便你使用。`LYSheetModel`则不同，你必须实现`sheetStyle`属性，因为`LYSheetController`需要知道`sheetCell` 是那种类型才能在复用池中取。


具体可以参考仓库中的 Demo。

# License

`LYSheetController` is released under a MIT License. See LICENSE file for details.
