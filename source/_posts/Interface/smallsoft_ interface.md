---
title: 小程序接口
date: 2019-01-29 15:09:10
tags: interview
---

# 接口

## __construct构造函数

> 默认其它请求接口传参数包含:
> 
> **必要参数:**
> > open_id  `小程序授权open_id`
> > 
> > app_id   `当前小程序的唯一标识`
> > 
> > nick_name `名称`
> > 
> > gender `性别`
> > 
> > city `城市`
> > 
> > province `省份`
> > 
> > avatar_url `头像`
> > 
> 授权成功以后就会保存当前这个用户所有信息,小程序就不用传uid参数


## sendMessageCode

> 根据手机号码发送短信验证码
> 
> **必要参数:**
> > mobile `手机号码`


## bindingMobile

> 绑定手机号码
> 
> **必要参数:**
> > mobile `手机号码`
> > 
> > code `短信验证码`
> > 
> 根据绑定后的手机就同步该用户订单历史信息和个人信息


## index

> 小程序首页接口
> 
> **return参数:**
`
	state: 10,
	msg: "成功",
	data: {
	second_kill_data: [
	
		{
		   id: "137",
			title: "倒流香（塔香）45粒/盒",
			product_id: "2272916",
			retail_price: "67",
			second_kill_price: "0.1",
			limit_num: "1",
			syt_sku: "9050265",
			price_id: "13589",
			start_time: "2019-01-22 00:00:00",
			end_time: "2019-01-25 00:00:00",
			desc: "观山流水，犹在山间。",
			pic: "http://pic1.syt.cn/upload/2019/01/14/141304K7EFM1RQ8TBVX4ND.jpg"
		},
		{
		id: "136",
		title: "透明管状线香10g装",
		product_id: "2272127",
		retail_price: "37",
		second_kill_price: "0.01",
		limit_num: "2",
		syt_sku: "9050247",
		price_id: "12608",
		start_time: "2019-01-22 00:00:00",
		end_time: "2019-01-25 00:00:00",
		desc: "",
		pic: "http://pic3.syt.cn/upload/2018/03/27/102754AEMH73MUVXYH2L56.jpg"
		}
	]
	}
`

## flashSaleDetailInfo

> 抢购 → 详情界面数据
> 
> **必要参数**
> > id 秒杀标识id
> **return参数**
`
	'id'  #秒杀Id
    'product_id'  #产品Id
    'carousels' #轮播图片
    'second_kill_price' #秒杀价格
    'retail_price' #零售价格
    'title' #标题
    'price_id'#套餐id
    'price_name'  #套餐名称
    'graphic_text' #描述
    'limit_num' #数量
    'remain_second'  #剩余多少秒
    'is_shared' => '1', # 判断分享数量是否大于购买数量  ≥ 购买数量 为 1  否则 为0
`


## goSecondKillProduct

> 立即抢购 → 商品
> 
> **必要参数:**
> > id `秒杀Id`
> > 
> > addr_id `地址Id`
> > 
> > uid `用户Id`

## queryAllTagData

> 查询全部tag 类型数据
> 
> **return数据**
`
	array(
	'id'=>'0', #标识Id
	'name' => '全部', #标题
	),
	array(
	    'id'=>'1', #标识Id
	    'name' => '自用', #标题
	),
	array(
	    'id'=>'2', #标识Id
	    'name' => '礼盒', #标题
	),array(
	    'id'=>'3', #标识Id
	    'name' => '饰品', #标题
	),
	array(
	    'id'=>'4', #标识Id
	    'name' => '雕刻', #标题
	),array(
	    'id'=>'5', #标识Id
	    'name' => '药用', #标题
	),
`

## queryAllProductData

> 获取沉香全部商品
> 
> **必要参数:**
> > tag_id `标签类型Id`
> > 
> > page `分页索引`
> > 
> > size `分页获取数据数量`
> **return数据:**
`
	{
	id: "2273044",
	family_id: "18120000",
	category_id: "0",
	pic: "http://pic3.syt.cn/upload/2019/01/29/134048DUK4MPDXG67EF6QE.jpg",
	title: "【沉香雕件】仙人指路",
	l_price: "11900",
	h_price: "11900",
	retail_price: null,
	syt_sku: "CXSH00011S",
	background_color: "#cccccc"
	}
`

## queryProductDetailInfo

> 获取商品详情
> 
> **必要参数:**
> > pid `商品Id`
> > 
> **return数据**
`
	{"state":10,"msg":"success","data":{"id":2273028,"name":"\u3010\u6c89\u9999\u96d5\u4ef6\u3011\u6e38\u5c71\u73a9\u6c34","carousels":["http:\/\/pic3.syt.cn\/upload\/2019\/01\/22\/1149271LMTHCJWLF5Z61V3.jpg","http:\/\/pic1.syt.cn\/upload\/2019\/01\/22\/114943QUKL57WXGPQFG67X.jpg","http:\/\/pic3.syt.cn\/upload\/2019\/01\/22\/1149383PWYZJ3SBCKSTC24.jpg","http:\/\/pic3.syt.cn\/upload\/2019\/01\/22\/115003RV3M67WYH7RFZJ3S.jpg","http:\/\/pic2.syt.cn\/upload\/2019\/01\/22\/115007BAZJL56DE9UVWM5C.jpg"],"subname":"\u3010\u6c89\u9999\u96d5\u4ef6\u3011\u6e38\u5c71\u73a9\u6c34","subdesc":"","brand":"\u4e0a\u5143\u5802","family":"\u6c89\u9999\u4ea7\u54c1","type":"\u6c89\u9999\u4ea7\u54c1","factory":"","graphic_text":"&lt;img src=\"http:\/\/pic3.syt.cn\/upload\/2019\/01\/22\/115016MP29F5G6JD2ELYTZ_800x800.jpg\"&gt;&lt;img src=\"http:\/\/pic1.syt.cn\/upload\/2019\/01\/22\/115017C45BU7DRF9GBPC7E_800x800.jpg\"&gt;&lt;img src=\"http:\/\/pic3.syt.cn\/upload\/2019\/01\/22\/1150188TUHQW3X5GP1V3EL_800x800.jpg\"&gt;&lt;img src=\"http:\/\/pic3.syt.cn\/upload\/2019\/01\/22\/115019SPKRS5TZV2WRFAZU_800x800.jpg\"&gt;&lt;img src=\"http:\/\/pic2.syt.cn\/upload\/2019\/01\/22\/115019PS5B1DKE4Y5HPJ83_800x800.jpg\"&gt;&lt;img src=\"http:\/\/pic3.syt.cn\/upload\/2019\/01\/22\/1150203UPVK9YMHU2DLXAG_800x800.jpg\"&gt;&lt;img src=\"http:\/\/pic3.syt.cn\/upload\/2019\/01\/22\/1150219J9AH13AGJ2SB189_800x800.jpg\"&gt;&lt;img src=\"http:\/\/pic3.syt.cn\/upload\/2019\/01\/22\/115022YWM67WFH7RXG18FZ_800x800.jpg\"&gt;&lt;img src=\"http:\/\/pic3.syt.cn\/upload\/2019\/01\/22\/1150224HV29FMTPJQK94A5_800x800.jpg\"&gt;&lt;br \/&gt;&lt;p&gt;&lt;img src=\"http:\/\/pic.syt.cn\/img\/www\/pro_explain.jpg\" \/&gt;&lt;\/p&gt;","on_sale":"1","syt_sku":"  CXSH00016","comments":[],"l_price":"6000","h_price":"6000","taocan":[{"id":13726,"name":"\u3010\u9999\u5bfb\u6709\u7f18\u4eba\u3011","desc":"","price":"6000"}],"taocanInfo":[{"price_id":13726,"name":"\u3010\u9999\u5bfb\u6709\u7f18\u4eba\u3011","item":[{"name":"\u3010\u6c89\u9999\u96d5\u4ef6\u3011\u6e38\u5c71\u73a9\u6c34","num":"1"}]}]}}
`

## queryAllCommentData

> 获取沉香全部商品
> 
> **必要参数:**
> > pid `商品Id`
> > 
> > page `分页索引`
> > 
> > size `分页获取数据数量`
> **return数据:**
`
	state: 10,
	msg: "success",
	data: [
	{
	mobile: "189****6122",
	nickname: "",
	mem_level: null,
	comment: "不错,发货速度很快",
	score: "5",
	response: "",
	com_time: "0000-00-00 00:00:00",
	images: [ ]
	},
	{
	mobile: "189****9516",
	nickname: "",
	mem_level: null,
	comment: "东西是正品",
	score: "5",
	response: "",
	com_time: "0000-00-00 00:00:00",
	images: [ ]
	}
	]
`

## queryAllOrderListData

> 查询所有订单数据
> 
> **必要参数:**
> > uid `用户Id`
> > 
> > page `分页索引`
> > 
> > size `分页获取数据数量`
> > 
> > state `state -1 为全部订单	订单状态（0 取消  10 下单  20 支付/待发货  30待收货 40已收货 50 已评价）
> > 
> **return数据:**
`
	{
	ordnum: "GW190124113141",
	state: "0",
	ctime: "2019-01-24 11:09:07",
	addr_name: "葛海峰",
	address: "江苏省 南京市 江宁区 宏运大道2199号上元堂",
	mobile: "18013042212",
	total_price: "0.1",
	products: [
	{
	id: "2272916",
	name: "【新春福利】上元堂 倒流香（塔香） 45粒/盒 4盒塔香送手串或挂珠",
	pic: "http://pic1.syt.cn/upload/2019/01/14/141304K7EFM1RQ8TBVX4ND.jpg",
	price_id: "13589",
	price_name: "【标准品】单盒塔香无香炉",
	price: "67",
	num: "1"
	}
	],
	express_type: "kd",
	express_name: "",
	express_num: "",
	url: ""
	}
`

## queryShoppingCartAllData

> 购物车商品列表
> 
> **必要参数:**
> > uid `用户Id`
> **return数据:**
`
	'id'	//商品id
	'name'	//商品名
	'pic'	//商品封面
	'price_id' //套餐id
	'price_name'	//套餐名
	'price'	//套餐价格
	'num'		//购物车中数量
	'tejia'	0,
	's_price'	
	'limit_num'	-1,
`

## addShoppingCart

> 添加购物车中商品
> 
> **必要参数:**
> > uid `用户Id`
> > 
> > price_id `套餐id`
> > 
> > num `购买数量`


## removeShoppingCart

> 删除购物车中商品
> 
> **必要参数:**
> > uid `用户Id`
> > 
> > price_id `套餐id`


## getUserAddress

> 管理收货地址——收货地址列表
> 
> **必要参数:**
> > uid `用户Id`
> > 
> **return数据:**
`
	{
	    "id": "45830",
	    "uid": "1",
	    "province": "江苏省",
	    "city": "南京市",
	    "area": "江宁区",
	    "address": "宏运大道2199号上元堂",
	    "name": "葛海峰",
	    "mobile": "18013042212",
	    "tel": "",
	    "isdefault": "1",
	    "lng": "",
	    "lat": "",
	    "add_time": "2018-03-15 16:44:02",
	    "upd_time": "2018-03-15 16:44:02",
	    "effect": "1"
	}
`

## setDefaultAddress

> 管理收货地址——设置默认地址
> 
> **必要参数:**
> > uid `用户Id`
> > 
> > addr_id `收货地址Id`

## editAddress

> 管理收货地址——编辑地址
> 
> **必要参数:**
> >
> > addr_id `收货地址Id`
> > 
> > province `省份`
> > 
> > city `城市`
> > 
> > area `地区`
> > 
> > address `详细地址`
> > 
> > name `名字`
> > 
> > mobile `手机号码`

## creatAddress

> 管理收货地址——添加地址
> 
> **必要参数:**
> > 
> > province `省份`
> > 
> > city `城市`
> > 
> > area `地区`
> > 
> > address `详细地址`
> > 
> > name `名字`
> > 
> > mobile `手机号码`


## areaGetByParentId

>  根据parent_id 查询数据
> 
>  **必要参数:**
> 
>  parent_id `默认为0 查询所有parentId 为0的数据`
> 
>  **return参数:**
> 
>  state: 10,
	msg: "success",
	data: {
		110000: {
		id: "110000",
		name: "北京市",
		parent_id: "0"
		}
	}



## provinceCityArea

> 管理收货地址——省市区接口
> 
> **return参数:**
`
	{
	    "id": "110000",
	    "name": "北京市",
	    "parent_id": "0",
	    "level_depth": 1,
	    "children": [
	        {
	            "id": "110100",
	            "name": "市辖区",
	            "parent_id": "110000",
	            "level_depth": 2,
	            "children": [
	                {
	                    "id": "110101",
	                    "name": "东城区",
	                    "parent_id": "110100",
	                    "level_depth": 3
	                },
	                {
	                    "id": "110102",
	                    "name": "西城区",
	                    "parent_id": "110100",
	                    "level_depth": 3
	                },
	                {
	                    "id": "110105",
	                    "name": "朝阳区",
	                    "parent_id": "110100",
	                    "level_depth": 3
	                },
	                {
	                    "id": "110106",
	                    "name": "丰台区",
	                    "parent_id": "110100",
	                    "level_depth": 3
	                },
	                {
	                    "id": "110107",
	                    "name": "石景山区",
	                    "parent_id": "110100",
	                    "level_depth": 3
	                },
	                {
	                    "id": "110108",
	                    "name": "海淀区",
	                    "parent_id": "110100",
	                    "level_depth": 3
	                },
	                {
	                    "id": "110109",
	                    "name": "门头沟区",
	                    "parent_id": "110100",
	                    "level_depth": 3
	                },
	                {
	                    "id": "110111",
	                    "name": "房山区",
	                    "parent_id": "110100",
	                    "level_depth": 3
	                },
	                {
	                    "id": "110112",
	                    "name": "通州区",
	                    "parent_id": "110100",
	                    "level_depth": 3
	                },
	                {
	                    "id": "110113",
	                    "name": "顺义区",
	                    "parent_id": "110100",
	                    "level_depth": 3
	                },
	                {
	                    "id": "110114",
	                    "name": "昌平区",
	                    "parent_id": "110100",
	                    "level_depth": 3
	                },
	                {
	                    "id": "110115",
	                    "name": "大兴区",
	                    "parent_id": "110100",
	                    "level_depth": 3
	                },
	                {
	                    "id": "110116",
	                    "name": "怀柔区",
	                    "parent_id": "110100",
	                    "level_depth": 3
	                },
	                {
	                    "id": "110117",
	                    "name": "平谷区",
	                    "parent_id": "110100",
	                    "level_depth": 3
	                }
	            ]
	        },
	        {
	            "id": "110200",
	            "name": "县",
	            "parent_id": "110000",
	            "level_depth": 2,
	            "children": [
	                {
	                    "id": "110228",
	                    "name": "密云县",
	                    "parent_id": "110200",
	                    "level_depth": 3
	                },
	                {
	                    "id": "110229",
	                    "name": "延庆县",
	                    "parent_id": "110200",
	                    "level_depth": 3
	                }
	            ]
	        }
	    ]
	}
`

## orderConfirm

> 订单确认接口
> 
> **返回参数:**
> 
> > data   `产品列表`
> > 
> > **返回参数:**
> > 
> > > state `状态`
> > > 
> > > msg   `消息`
> > > 
> > > product `产品`
> > > 
> > > address `地址`
> > > 
> > > total_price `总价`


## creatOrder

> 订单创建接口
> 
> **请求参数:**
> > open_id `微信_open_id`
> > 
> > app_id `项目标识号`
> > 
> > nick_name `名称`
> > 
> > city `城市`
> > 
> > avatarUrl `头像`
> > 
> > data  `列表`
> > > 
> > > addr_id  `选中地址Id`
> > > 
> > > remake  `留言`
> > > 
> > > products `商品列表`
> > > 
> > > **JSON案例:**
`
	{
		"open_id": "110200",
		"app_id": "123",
		"nick_name": "华仔",
		"city": "南京",
		"avatarUrl": "www.baidu.com",
		"data": [
		 {
			"addr_id": "110228",
			"products": [
				{
					"id": "110228",
					"name": "沉香粉"
				}
			]
		}	
	}
`
> **返回参数:**
> > state  `状态值`
> > 
> > msg    `提示信息`
> > 
> > data   `返回列表`
> > 
> > > ordnum `订单编号`
> > > 
> > > total_price `总价格`


## queryOrderInfo

> 查询订单详情
> 
> **请求参数:**
> > open_id `微信_open_id`
> > 
> > app_id `项目标识号`
> > 
> > ord_num `订单标识`
> > 
> **return参数:**
> 
> > 返回订单详情数据


## cancelOrder

> 取消订单
> 
> 订单状态（0 取消  10 下单  20 支付/待发货  30待收货 40已收货 50 已评价）
> 
> **请求参数:**
> > open_id `微信_open_id`
> > 
> > app_id `项目标识号`
> > 
> > ord_num `订单标识`
> > 
> > reason  `理由`




## jscode2session

> 微信验证
> 
> **请求参数:** 
> > app_id `项目标识号`
> > 
> > js_code `标识码`
> 
> **返回参数:**
> > state  `状态值`
> > 
> > msg    `提示信息`
> > 
> > data   `内容列表`



## queryInformation

> 获取用户信息
> 
> **返回参数:**
> > state  `状态值`
> > 
> > msg    `提示信息`
> > 
> > data   `内容列表`
> > 
> > > mobile **未绑定手机号码:00000000000** 
> > > 
> > > other parameters `其它参数`



## editOrder

> 修改订单信息
> 
> **参数:**
> > ord_num  `订单号`
> > 
> > province    `省`
> > 
> > city   `城市`
> > 
> > area  `地区`
> > 
> > address  `详情` 
> > 
> > name `收货人名称` 
> > 
> > mobile `电话`


## confirmOrder

> 修改订单信息
> 
> **参数:**
> > ord_num  `订单号`


## secondKillSettingIsShare

> 设置用户表秒杀状态值
> > 
> > 分享成功 share_success 值为 1
> > 
> > 秒杀成功 share_success 值为 0
> 
> **参数:**
> > share_success  `分享是否成功 1 → 成功  0 → 失败`
