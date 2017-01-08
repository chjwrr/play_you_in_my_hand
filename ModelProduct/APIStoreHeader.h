//
//  APIStoreHeader.h
//  ModelProduct
//
//  Created by apple on 16/1/13.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#ifndef ModelProduct_APIStoreHeader_h
#define ModelProduct_APIStoreHeader_h

#define API_STORE_APIKEY  @"1ea9cd2d426a84e1bd19f8fb974007e9"

/**********************************APIStore  接口*************************************/



/*
 文本搜图
 
 word         查询词,转成URF-8格式
 
 pn           请求返回起始页号，范围0-2000
 
 rn           请求返回结果数，范围1-60
 
 ie           查询词编码类型，可选utf-8, gbk
 
 apikey       API密钥  (参数位置：header)
 
 */

#define wen_ben_sou_tu_API   @"image_search/search/search"

/*
 中国和世界天气预报
 
 apikey       API密钥  (参数位置：header)
 
 city         城市名称，国内城市支持中英文，国际城市支持英文
 
 天气代码对照   http://www.heweather.com/documents/condition-code
 
 天气图片地址   http://files.heweather.com/cond_icon/101.png   100*100
 
 */

#define zhong_guo_he_shi_jie_tian_qi_yu_bao_image_url   @"http://files.heweather.com/cond_icon/"
#define zhong_guo_he_shi_jie_tian_qi_yu_bao_API         @"heweather/weather/free"


/*
 景点查询
 
 apikey       API密钥  (参数位置：header)
 
 id         输入景点名称（拼音）或景点uid。 uid 说明：指poi唯一id，可通过关键字检索或者周边检索获得poi和对应的id
 
 output     输出的数据格式，默认为xml格式，当output设置为’json’时，输出的为json格式的数据。
 

 参数介绍
 
 error                   返回结果状态标识     请求状态，如果成功返回0，如果失败返回其他数字，详细见状态码附录
 status	                 返回结果状态信息	   success 表示返回成功，否则表示失败
 date                    日期               请求日期
 result	                 返回结果数组
 result.name	         景点名称
 result.location	     当前景点坐标（经纬度）
 result.location.lng	 经度
 result.location.lat	 纬度
 result.telephone        景点咨询电话
 result.url	             详情页地址    如http://lvyou.baidu.com/yiheyuan
 result.abstract	     景点印象摘要
 result.description	     景点介绍
 
 result.ticket_info.open_time	景点开放时间	如：旺季（4月1日~10月31日）：06:30~20:00 停止售票时间：18:00
 result.ticket_info.attention	更多事项
 */

#define jing_dian_cha_xun_API     @"http://apis.baidu.com/apistore/attractions/spot"

/*
 易源_笑话大全
 
 apikey       API密钥  (参数位置：header)

 page         第几页。每页最多返回20条
 
 */

#define yi_yuan_xiao_hua_da_quan_API   @"http://apis.baidu.com/showapi_open_bus/showapi_joke/joke_text"

/*
 猜一猜
 
 apikey       API密钥  (参数位置：header)
 
 id           数据id,不填则随机选取
*/

#define cai_yi_cai_API    @"myml/c1c/c1c"


/*
 天狗开放阅图-最新图库
 
 apikey       API密钥  (参数位置：header)

 id           最新图库ID  0
 rows         条数  20
 classify     图库分类ID  0
 
 
 说明：img字段返回的是不完整的图片路径src，
 需要在前面添加【http://tnfs.tngou.net/image】或者【http://tnfs.tngou.net/img】
 前者可以在图片后面添加宽度和高度，如：http://tnfs.tngou.net/image/top/default.jpg_180x120
 
 详情请参考：http://www.tngou.net/doc/gallery
*/

#define tian_gou_zui_xin_API   @"tngou/gallery/news"


/*
 天狗开放阅图-图库分类
 
 apikey       API密钥  (参数位置：header)

 */

#define tian_gou_fen_lei_API   @"tngou/gallery/classify"

/*
 天狗开放阅图-图库列表
 
 apikey       API密钥  (参数位置：header)
 
 id   number	否	urlParam   图库分类ID   0
 
 page   number	否	urlParam   页数  1
 
 rows    number	否	urlParam   条数   20
 
 */

#define tian_gou_lie_biao_API   @"tngou/gallery/list"

/*
 天狗开放阅图-图库详情
 
 apikey       API密钥  (参数位置：header)
 
 id    number	是	urlParam   图库ID   10
 
 */

#define tian_gou_xiang_qing_API   @"tngou/gallery/show"

//图库图片地址前缀
#define tukuHeaderURL           @"http://tnfs.tngou.net/image"


/*
 历史上的今天
 
 apikey       API密钥  (参数位置：header)

 yue    月份
 ri     日期
 type   数据类型，1：国内国际大事件，2：民间事件包含部分国家大事件
 page   请求页数，默认page=1
 rows   返回记录条数，默认rows=20,最大50
 dtype  返回数据格式，XML或JSON，默认为JSON
 format  当返回结果格式为JSON时，是否对其进行格式化
 
*/

#define li_shi_shang_de_jin_tian_API   @"http://apis.baidu.com/avatardata/historytoday/lookup"



/*
 音乐搜索接口
 
 apikey       API密钥  (参数位置：header)
 
 s            关键字
 limit        返回条数10
 p            分页1
 */

#define yin_yue_sou_suo_API   @"geekery/music/query"



/*
 名人名言
 keyword    查找关键字
 
*/

#define ming_ren_ming_yan_API   @"avatardata/mingrenmingyan/lookup"


/*
 脑筋急转弯
 
 */
#define nao_jin_ji_zhuan_wan_API  @"txapi/naowan/naowan"


#endif
