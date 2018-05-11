---
title: 栅格布局
date: '2017-09-01  21:30'
categories: ios
tags: layout
abbrlink: 30449
---

# [初衷和项目源代码](https://github.com/youngsoft/MyLinearLayout/tree/MyGridLayout)
 **主要是解决:`同一份数据,可以动态切换不同的布局`。如果模型数据很多条,`那么就肯定用UITtableview`。**
 

# 原理

* **MyGirdeLayout->栅格布局:**`树形结构`

* **UIView.subviews->子视图:**`平面结构`

* **栅格布局:**
1. 将一个矩形的视图区域按行或者按列的方式划分为`多个子区域`,子区域根据布局的要求可以`继续递归划分`。栅格布局里面的`子视图`将按照添加的顺序依次填充到对应的`叶子区域中去的布局方式`。
2. 通过`一套自定义的布局体系来划分位置和尺寸`,添加到栅格布局里面的子视图`将不再需要指定位置和尺寸`而是由`栅格布局中的子栅格来完成`,因此可以很很方便的调整布局结构,从而实现动态布局的能力。 所谓栅格其实就是`一个矩形区域`,我们知道一个视图其实就是一个矩形区域,而子视图的frame属性其实就是`父视图中的某个特定的子区域部分`。
3. 既然子视图最终占据的是父视图的某个子矩形区域。那么我们也可以先将`一个矩形区域按照某种规则分解为多个子矩形区域`,然后`再将子视图填充到对应的子矩形区域中去`,这就是栅格布局的`实现思想`。

## 叶子格子和非叶子格子区别 

* `叶子格子`表示里面没有子格子而`非叶子格子`表示里面有子格子

* `非叶子栅格`只能设置一个方向的停靠,具体只能设置左中右或者上中下

* `叶子栅格`如果设置了gravity则填充的子视图必须要设置明确的尺寸

## 视图组

1. 原理
	![](/images/layout/MyGridLayout_ViewGroup.png)

2. 数据
	
	```
	{"size":"fill","cols":[{"size":"50%","padding":"{0,5,0,5}","right-
	borderline":{"head":1,"tail":1,"offset":1,"thick"1,"color":"#EEEEEE"},
	"bottom-borderline":{"head":1,"tail":1,"offset":1,"thick":1,
	"color":"#EEEEEE"},"tag":1003,"action":"handleTap:","rows":
	[{"size":"fill","cols":[{"size":"fill","rows":[{"size":"wrap"},
	{"size":"wrap"},{"padding":"{5, 5, 5, 5}","size":"wrap"}]},
	{"padding":"{5, 5, 5, 5}","size":"fill"}]}]}
	```
3. 视图

	```
	 NSMutableArray *temp = [NSMutableArray array];
    UIImageView *backgroudImageView = [[UIImageView alloc] initWithImage:	[UIImage imageNamed:@"bk1"]];
    [temp addObject:backgroudImageView];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"南京精选";
    titleLabel.font = [CFTool font:13];
    titleLabel.textColor = UIColor.whiteColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    [temp addObject:titleLabel];
    
    UILabel *subTitleLabel = [UILabel new];
    subTitleLabel.text = @"天猫超市";
    subTitleLabel.font = [CFTool font:11];
    subTitleLabel.textColor = UIColor.whiteColor;
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    subTitleLabel.adjustsFontSizeToFitWidth = YES;
    [temp addObject:subTitleLabel];
    
    NSArray *titles = @[@"周末疯狂趴",@"送5升菜籽油"];
    for (NSString *title in titles) {
        UILabel *lb = [UILabel new];
        lb.text = title;
        lb.font = [CFTool font:12];
        lb.textColor = UIColor.redColor;
        lb.adjustsFontSizeToFitWidth = YES;
        [temp addObject:lb];
    }
    
    NSArray *imageNames = @[@"p1-31",@"p1-32"];
    for (NSString *imageName in imageNames) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [temp addObject:imageView];
    }
    
    UIImageView *optionalView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"p1-12"]];
    [temp addObject:optionalView];
    [self.rootLayout addViewGroup:temp withActionData:@"aa" to:sPartTag3];
	```

4. **这样就可以根据数据的`Tag`来指定`标签内才会放置绑定的视图组`。**

# 布局技巧

## 拆分子格子几种方法  

### 描述

![](/images/layout/MyGridLayout_Demo1.png)  

* 把格子拆分为2个行子格子,然后第2个行子格子拆分为2个列子格子。
* 因此按照这个结构,我们就可以将**那些不重叠排列的x布局**按格子布局划分出来。最终所有子视图都将放在叶子格子里面,而子视图的放置顺序,就是按格子这棵树的深度遍历顺序来存放的。
* 叶子格子代表里面没有子格子,比如这个格子里面,格子1和格子2.1,2.2都是叶格子。但是格子2和根格子不是叶子格子,这样如果布局中有3个子视图,那么将按照格子的布局顺序逐步添加对应的视图。
* 例如 视图1 -> 填充1区域格子,视图2 -> 填充2.1区域格子,视图3 -> 填充2.2区域格子。

1.  `明确指定高度的`,比如第一个行子格子的高度时20。那么就会建立一个高度为20,宽度为100的行子格子   
2.  `明确指定高度比例`,比如第二个行子格子的高度时整体高度的30%。那么久会建立一个高度为30,宽度为100的行子格子  
3. `明确指定生于高度比例`,比如第三个行格子的高度是剩余高度的40%,那么就会建立一个(100-20-30) * 0.4 = 20 高度并且宽度为100的行格子 
4. `明确指定剩余下的所有高度`,比如第四个行子格子的高度时剩余下的所有高度,那么就会建立一个高度为30,宽度为100的子格子 


### 案例

1. 建立三个高度分别为33.3333%的行子格子
```
	* [grid addRow:1.0/3];  
	* [grid addRow:1.0/3];  
	* [grid addRow:1.0/3];
```
2. 建立一个高度为剩余33.3333%的行格子,第二个高度为剩余高度50%的行格子,第三个为剩余全高度的行格子 
```
	* [grid addRow:-1.0/3];  
	* [grid addRow:-1.0/2];  
	* [grid addRow:MyLayoutSize.fill];
```
3. 建立3个为剩余全高度的行格子 
```
	* [grid addRow:MyLayoutSize.fill]; 
	* [grid addRow:MyLayoutSize.fill]; 
	* [grid addRow:MyLayoutSize.fill];
```
4. 建立为JSON形式
```
	* grid.gridDictionary = @{"rows":[{"size":"33.33%"}， {"size":"33.33%"}, {"size":"33.33%"}}]}
	* grid.gridDictionary = @{"rows":[{"size":"-33.33%"}, {"size":"-50%"}, {"size":"fill"}]}
	* grid.gridDictionary = @{"rows":[{"size":"fill"},{"size":"fill"},{"size":"fill"}]};
```

**这里面可见:第一种和第二种`都需要指定一个除不尽的小数`;但是第三种和第四种`就不需要指定任何小数`**

## 布局尺寸描述

1. 	@{kMyGridSize:@(20)}   `表示尺寸是20`

2. @{kMyGridSize:@"50%"}  `表示尺寸是总体的50%`

3. @{kMyGridSize:@"-50%"} `表示是剩余的50%`

4. @{kMyGridSize:vMyGridSizeWrap}  `表示尺寸由子格子包裹`

5. @{kMyGridSize:vMyGridSizeFill}  `表示尺寸均分和填充剩余的高度或者宽度`

## anchor锚点

用于`栅格`,表示设置为YES时,栅格也放入一个对应的子视图

## placeholder

用于`叶子栅格`,表示设置为YES时,叶子栅格不会放入一个对应的子视图

## 视图重叠

![](/images/layout/MyGridLayout_Anchor.jpg)

### JSON描述
```
	{
	   "overlap":"bottom|left",
	   "padding":"{0,0,5,0}"
   }
```

### 	内部实现
```
	 MyGravity tempGravity = MyGravity_None;
    NSArray *array = [overlap componentsSeparatedByString:@"|"];
    for (NSString *temp in array) {
        tempGravity |= [self returnGravity:temp];
    }
    if (tempGravity != MyGravity_None){
        gridNode.anchor = true;
        gridNode.measure = 0;
        gridNode.gravity = tempGravity;
        gridNode.overlap = tempGravity;
    }
```

**`内部机制三部曲`**
1. **`"gravity":"bottom|left"`表示`内部视图尺寸包裹`也就是`wrap的简写方式`目的是为了`减少对视图的尺寸设置`关键一点是必须让`视图自己包裹展示,而不是设置尺寸`。否则就达不到重叠视图的效果**
2. **anchor:true**`栅格放入一个视图`
3. **gravity:**`表示重叠时对齐方式`

**`注意事项`**
* 当`"overlap":"top|left"`时:表示视图的顶部对齐,也就是视图区域的底部,然后再往下延伸
* 当`"overlap":"bottom|left"时:`表示视图的底部对齐,也就是视图区域的底部,然后再往上延伸
* 如果想把`千奈美`设置为`左上方`方式:
1. 将高度为0的栅格作为第一行,然后再设置`gravity = top|left`,这种会造成`添加的视图会盖住前面添加的视图`  	
2. 建立一个子栅格`推荐这一种		`					

#  布局属性介绍

## MyGrid 

### 定义格式化栅格描述语言的key和对应的value

* **这些值可以用来设置栅格布局的gridDictionary属性中字典的各种键值对**
```
	kMyGridTag:  NSNumber类型,设置栅格的标签,对应MyGrid的tag属性。具体值为NSInteger
	kMyGridAction:  NSString类型，设置栅格的触摸动作，对应MyGrid的setTarget中的action参数
	kMyGridActionData: id类型,设置栅格的动作数据,对应MyGrid的actionData属性
	kMyGridRows: NSArray<NSDictionary>类型,表示里面的值是行子栅格数组。数组的元素是一个个子栅格字典对象
	kMyGridCols:  NSArray<NSDictionary>类型,表示里面的值是列子栅格数组。数组的元素是一个个子栅格字典对象
	kMyGridSize:  NSString类型或者NSNumber类型。设置栅格的尺寸,可以为特定的值vMyGridSizeWrap或者vMyGridSizeFill,也可以为某个具体的数字比如20.0,还可以为百分比数字比如：@"20%" 或者@"-20%"
	kMyGridPadding: NSString类型,设置栅格的内边距,对应MyGrid的padding属性,具体的值的格式为：@"{上,左,下,右}"
	kMyGridSpace: NSNumber类型，栅格的内子栅格的间距，对应MyGrid的subviewSpace属性
	kMyGridGravity: NSString类型,栅格的停靠属性,对应MyGrid的gravity属性,具体的值请参考下面的定义,比如：@"top|left"
	kMyGridPlaceholder://NSNumber类型,栅格的占位属性,对应MyGrid的placeholder 属性,具体的值设置为YES or NO
	kMyGridAnchor: NSNumber类型，栅格的锚点属性，对应MyGrid的anchor属性，具体的值设置为YES or NO
	
	kMyGridTopBorderline: NSDictionary类型 栅格的顶部边界线对象
	kMyGridBottomBorderline: NSDictionary类型 栅格的底部边界线对象
	kMyGridLeftBorderline: NSDictionary类型 栅格的左边边界线对象
	kMyGridRightBorderline: NSDictionary类型 栅格的右边边界线对象
```

* **栅格的边界线对象所能设置的key**
```
	kMyGridBorderlineColor: NSString类型，用字符串格式描述的颜色值。具体为：@"#FF0000" 表示红色
	kMyGridBorderlineThick: NSNumber类型,边界线的粗细
	kMyGridBorderlineHeadIndent: NSNumber类型,边界线的头部缩进值
	kMyGridBorderlineTailIndent: NSNumber类型,边界线的尾部缩进值
	kMyGridBorderlineOffset: NSNumber类型,边界线的偏移值
	kMyGridBorderlineDash: NSNumber类型,边界线是虚线
```

* **kMyGridSize可以设置的特殊值**
```
	vMyGridSizeWrap: 表示尺寸由子栅格决定
	vMyGridSizeFill: 表示尺寸填充父栅格的剩余部分
```

* **kMyGridGravity可以设置的值**
```
	vMyGridGravityTop:     视图顶部对齐对应MyGravity_Vert_Top
	vMyGridGravityBottom:  视图底部对齐对应MyGravity_Vert_Bottom
	vMyGridGravityLeft:    视图左边对齐对应MyGravity_Horz_Left
	vMyGridGravityRight:   视图右边对齐对应MyGravity_Horz_Right
	vMyGridGravityLeading:  视图头部对应MyGravity_Horz_Leading
	vMyGridGravityTrailing: 视图尾部对应MyGravity_Horz_Trailing
	vMyGridGravityCenterX:  视图橫行居中MyGravity_Horz_CenterX
	vMyGridGravityCenterY:  视图纵向居中MyGravity_Vert_CenterY
	vMyGridGravityWidthFill:  视图宽度填充MyGravity_Horz_Fill
	vMyGridGravityHeightFill:  视图高度填充MyGravity_Vert_Fill
```

### **栅格动作接口,您可以触摸栅格来执行特定的动作和事件**
```
/**
 栅格动作接口，您可以触摸栅格来执行特定的动作和事件。
 */
@protocol MyGridAction<NSObject>
	
/**
 栅格的标签标识，用于在事件中区分栅格。
 */
@property(nonatomic)  NSInteger tag;
	
	
/**
 栅格的动作数据，这个数据是栅格的扩展数据，您可以在动作中使用这个附加的数据来进行一系列操作。他可以是一个数值，也可以是个字符串，甚至可以是一段JS脚本。
 */
@property(nonatomic, strong) id actionData;
	
	
	
/**
 设置栅格的事件,如果取消栅格事件则设置target为nil
	
 @param target action事件的调用者
 @param action action事件，格式为：-(void)handle:(id<MyGrid>)sender
 */
-(void)setTarget:(id)target action:(SEL)action;
	
@end
```

###  栅格协议:用来描述栅格块以及栅格的添加和删除

```
栅格可以按某个方向拆分为众多子栅格,而且这个过程可以递归进行。所有栅格布局中的子视图都将依次放入叶子栅格的区域中

@protocol MyGrid <MyGridAction>

//设置和获取栅格的尺寸
@property(nonatomic, assign) CGFloat measure;

//得到父栅格。根栅格的父栅格为nil
@property(nonatomic, weak, readonly) id<MyGrid> superGrid;

//得到所有子栅格
@property(nonatomic, strong, readonly) NSArray<id<MyGrid>> *subGrids;

//克隆出一个新栅格以及其下的所有子栅格。
-(id<MyGrid>)cloneGrid;

/**
 栅格内子栅格之间的间距。
 */
@property(nonatomic, assign) CGFloat subviewSpace;

/**
 栅格内子栅格或者叶子栅格内视图的四周内边距。
 */
@property(nonatomic, assign) UIEdgeInsets padding;

/**
 栅格内子栅格或者叶子栅格内视图的对齐停靠方式.
 
 1.对于非叶子栅格来说只能设置一个方向的停靠。具体只能设置左中右或者上中下
 2.对于叶子栅格来说，如果设置了gravity 则填充的子视图必须要设置明确的尺寸。
 */
@property(nonatomic, assign) MyGravity gravity;

/**
 占位标志，只用叶子栅格，当设置为YES时则表示这个格子只用于占位，子视图不能填充到这个栅格中。
 */
@property(nonatomic, assign) BOOL placeholder;

/**
  锚点标志，表示这个栅格虽然是非叶子栅格，也可以用来填充视图。如果将非叶子栅格的锚点标志设置为YES，那么这个栅格也可以用来填充子视图，一般用来当做背景视图使用。
 */
@property(nonatomic, assign) BOOL anchor;

/**顶部边界线*/
@property(nonatomic, strong) MyBorderline *topBorderline;
/**头部边界线*/
@property(nonatomic, strong) MyBorderline *leadingBorderline;
/**底部边界线*/
@property(nonatomic, strong) MyBorderline *bottomBorderline;
/**尾部边界线*/
@property(nonatomic, strong) MyBorderline *trailingBorderline;

/**如果您不需要考虑国际化的问题则请用这个属性设置左边边界线，否则用leadingBorderline*/
@property(nonatomic, strong) MyBorderline *leftBorderline;
/**如果您不需要考虑国际化的问题则请用这个属性设置右边边界线，否则用trailingBorderline*/
@property(nonatomic, strong) MyBorderline *rightBorderline;

/**
 添加行栅格，返回新的栅格。其中的measure可以设置如下的值：
 1.大于等于1的常数，表示固定尺寸。
 2.大于0小于1的常数，表示占用整体尺寸的比例
 3.小于0大于-1的常数，表示占用剩余尺寸的比例
 4.MyLayoutSize.wrap 表示尺寸由子栅格包裹
 5.MyLayoutSize.fill 表示占用栅格剩余的尺寸
 */
-(id<MyGrid>)addRow:(CGFloat)measure;

/**
 添加列栅格，返回新的栅格。其中的measure可以设置如下的值：
 1.大于等于1的常数，表示固定尺寸。
 2.大于0小于1的常数，表示占用整体尺寸的比例
 3.小于0大于-1的常数，表示占用剩余尺寸的比例
 4.MyLayoutSize.wrap 表示尺寸由子栅格包裹
 5.MyLayoutSize.fill 表示占用栅格剩余的尺寸
 */
-(id<MyGrid>)addCol:(CGFloat)measure;

//添加栅格，返回被添加的栅格。这个方法和下面的cloneGrid配合使用可以用来构建那些需要重复添加栅格的场景。
-(id<MyGrid>)addRowGrid:(id<MyGrid>)grid;
-(id<MyGrid>)addColGrid:(id<MyGrid>)grid;

-(id<MyGrid>)addRowGrid:(id<MyGrid>)grid measure:(CGFloat)measure;
-(id<MyGrid>)addColGrid:(id<MyGrid>)grid measure:(CGFloat)measure;

//从父栅格中删除。
-(void)removeFromSuperGrid;

//用字典的方式来构造栅格。
@property(nonatomic, strong) NSDictionary *gridDictionary;

@end
```

# 案例   

## [演示](https://github.com/youngsoft/MyLinearLayout/blob/MyGridLayout/MyLayoutDemo)

![](/images/layout/MyGirdLayout_Demo.gif) 

## [数据](https://github.com/youngsoft/MyLinearLayout/blob/MyGridLayout/MyLayoutDemo)

### [Demo4](https://github.com/youngsoft/MyLinearLayout/blob/MyGridLayout/MyLayoutDemo/GLTest4ViewController.m)
```
{"padding":"{10,0,10,0}","tag":1000,"rows":[{"size":120},{"size":20},
{"size":150,"tag":1,"cols":[{"size":"fill","rows":[{"size":"fill","cols":
[{"size":"20%"},{"size":"20%"},{"size":"20%"},{"size":"20%"},
{"size":"20%"}]},{"size":"fill","cols":[{"size":"20%"},{"size":"20%"},
{"size":"20%"},{"size":"20%"},{"size":"20%"}]}]}]},{"size":5,},
{"size":"fill","cols":[{"size":"50%","padding":"{0,5,0,5}","right-
borderline":{"head":1,"tail":1,"offset":1,"thick":
1,"color":"#EEEEEE"},"bottom-borderline":{"head":1,"tail":1,"offset":
1,"thick":1,"color":"#EEEEEE"},"tag":2,"action":"handleTap:","rows":
[{"size":40,"cols":[{"anchor":true,"size":80,"padding":"{5,5,5,5}","space":
5,"rows":[{"size":"fill"},{"size":"fill"}]},
{"size":"fill","padding":"{5,5,5,5}","space":5,"rows":[{"size":"fill"},
{"size":"fill"}]}]},{"space":5,"size":"fill","cols":[{"padding":"{5, 5, 5, 
5}","size":"fill"},{"padding":"{5, 5, 5, 5}","size":"fill"}]},
{"overlap":"bottom|left","padding":"{0,0,5,0}"}]},
{"size":"50%","padding":"{0,5,0,5}","right-borderline":{"head":1,"tail":
1,"offset":1,"thick":1,"color":"#EEEEEE"},"bottom-borderline":{"head":
1,"tail":1,"offset":1,"thick":
1,"color":"#EEEEEE"},"action":"handleTap:","tag":3,"rows":
[{"size":"fill","cols":[{"size":"fill","rows":[{"size":"wrap"},
{"size":"wrap"},{"padding":"{5, 5, 5, 5}","size":"wrap"}]},{"padding":"{5, 
5, 5, 5}","size":"fill"}]}]}]},{"size":"fill","cols":
[{"size":"50%","padding":"{0,5,0,5}","right-borderline":{"head":1,"tail":
1,"offset":1,"thick":1,"color":"#EEEEEE"},"bottom-borderline":{"head":
1,"tail":1,"offset":1,"thick":1,"color":"#EEEEEE"},"tag":
3,"action":"handleTap:","rows":[{"size":"fill","cols":
[{"size":"fill","rows":[{"size":"wrap"},{"size":"wrap"},{"padding":"{5, 5, 5, 5}","size":"wrap"}]},{"padding":"{5, 5, 5, 5}","size":"fill"}]}]},
{"size":"50%","padding":"{0,5,0,5}","right-borderline":{"head":1,"tail":
1,"offset":1,"thick":1,"color":"#EEEEEE"},"bottom-borderline":{"head":
1,"tail":1,"offset":1,"thick":1,"color":"#EEEEEE"},"tag":
3,"action":"handleTap:","rows":[{"size":"fill","cols":
[{"size":"fill","rows":[{"size":"wrap"},{"size":"wrap"},{"padding":"{5, 5, 
5, 5}","size":"wrap"}]},{"padding":"{5, 5, 5, 5}","size":"fill"}]},
{"overlap":"bottom|left","padding":"{0,0,5,0}"}]}]}]}
```

### [Demo5](https://github.com/youngsoft/MyLinearLayout/blob/MyGridLayout/MyLayoutDemo/GLTest5ViewController.m)
```
{"rows":[{"size":240,"padding":"{10,10,5,10}","space":5,"cols":
[{"size":"40%","anchor":true,"tag":222,"padding":"{0,20,0,20}","rows":
[{"size":35,"anchor":"true","rows":[{"size":"fill"}]},{"size":
30,"anchor":"true","rows":[{"size":"fill"}]}]},{"size":"30%","space":
5,"rows":[{"size":"fill","tag":333,"anchor":"true","rows":[{"size":30}]},
{"size":"fill","anchor":"true","tag":333,"rows":[{"size":30}]}]},
{"size":"30%","space":5,"rows":[{"size":"fill","tag":
333,"anchor":"true","rows":[{"size":30}]},
{"size":"fill","anchor":"true","tag":333,"rows":[{"size":30}]}]}]},
{"size":"fill","anchor":true,"tag":111,"top-borderline":{"thick":
10,"offset":5,"color":"#D1D1D1"},"space":
5,"padding":"{10,10,10,10}","rows":[{"size":40,"tag":1},
{"size":"fill","space":10,"cols":[{"size":"fill","anchor":true,"tag":
2,"rows":[{"size":"fill","placeholder":true},{"size":
50,"anchor":true,"cols":[{"placeholder":true,"size":"50%"},
{"size":"50%"}]}]},{"size":"fill","anchor":true,"tag":2,"rows":
[{"size":"fill","placeholder":true},{"size":50,"anchor":true,"cols":
[{"placeholder":true,"size":"50%"},{"size":"50%"}]}]}]},{"size":25,"bottom-
borderline":{"thick":1,"color":"#D1D1D1"}},{"size":
40,"padding":"{10,5,10,5}","cols":[{"size":"fill"},{"size":"wrap"}]}]}]}
```