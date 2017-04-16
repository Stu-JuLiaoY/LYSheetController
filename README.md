# LYSheetController
> A simple, powerful pop-up menu view
# 设计思路
设计仿照了系统的 `UITableView`,其实内部的实现也是一个使用了系统的`UITableView`。依于此，我们可以使用`- registSheetControllerCell:forStyle:`大大提高扩展性.

# 使用 Usage
由于仿照了`UITableView`的设计思路，所以，你可以像使用`UITableView`一样，使用`LYShetController`

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

你可以继承`LYSheetModel`来宽展`LYSheetModel` 没有的属性。并且把你自定义的 Model 放到一个数组里面，赋值给`LYSheetController`.

如果你这样做了，那么意味着你也需要继承`LYSheetCell`自定义 cell。因为`LYSheetController`提供的`LYSheetCell`不会对你自定义的`LYSheetModel`提供支持(即无法显示属性)。

可以参考仓库中的 Demo。

# License

`LYSheetController` is released under a MIT License. See LICENSE file for details.
