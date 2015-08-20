# SEAssociationView
- Like a linkage menu, using two UITableView / 大概是个联动菜单吧, 使用两个UITableView制作
- you can custom cell's icon/background for both normal and heighted / 可以自定义cell的图片背景图
- also you can use custom cell created by nib / 也可以自定义cell
- be happy :)

## How to use
- Step 1. add the SEAssociationView to your project. Just drag the "SEAssociationView" folder into your xcode
- Step 2. add import in your sourcefile `#import "SEAssociationView.h"`
- Step 3. create an instance

```objective-c
SEAssociationView *associationView = [SEAssociationView associationView];
associationView.frame = (CGRect){ 0, 20, self.view.frame.size.width, self.view.frame.size.height };
associationView.dataSource = self;
[self.view addSubview:associationView];
```
- Step 4. implement dataSource methods

```objective-c
#pragma mark - SEAssociationViewDataSource
- (NSInteger)numberOfRowsInMainTable:(SEAssociationView *)associationView {
    return self.categories.count;
}

- (NSString *)associationView:(SEAssociationView *)associationView titleInMainTableAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = [self.categories[indexPath.row] objectForKey:@"name"];
    return title;
}

- (NSArray *)associationView:(SEAssociationView *)associationView subTitlesForRowInMainTableAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *subData = [self.categories[indexPath.row] objectForKey:@"subcategories"];
    return subData;
}
```

## 如何使用
- 步骤 1. 把这个控件放入项目中。直接拖拽"SEAssociationView"文件夹到源代码
- 步骤 2. 添加头文件`#import "SEAssociationView.h"`
- 步骤 3. 创建实例

```objective-c
SEAssociationView *associationView = [SEAssociationView associationView];
associationView.frame = (CGRect){ 0, 20, self.view.frame.size.width, self.view.frame.size.height };
associationView.dataSource = self;
[self.view addSubview:associationView];
```

- 步骤 4. 实现代理方法

```objective-c
#pragma mark - SEAssociationViewDataSource
- (NSInteger)numberOfRowsInMainTable:(SEAssociationView *)associationView {
    return self.categories.count;
}

- (NSString *)associationView:(SEAssociationView *)associationView titleInMainTableAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = [self.categories[indexPath.row] objectForKey:@"name"];
    return title;
}

- (NSArray *)associationView:(SEAssociationView *)associationView subTitlesForRowInMainTableAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *subData = [self.categories[indexPath.row] objectForKey:@"subcategories"];
    return subData;
}
```

## More / 更多
- read file `SEAssociationView.h` / 查阅文件`SEAssociationView.h`
- try the example project / 试用示例

## Demo / 示例
### 显示自定义的菜单条目
![](http://7xjjcp.com1.z0.glb.clouddn.com/github_menu01.gif)

### 显示地区选择
![](http://7xjjcp.com1.z0.glb.clouddn.com/github_menu02.gif)

### 显示食品菜单 自定义cell
![](http://7xjjcp.com1.z0.glb.clouddn.com/github_menu03.gif)
