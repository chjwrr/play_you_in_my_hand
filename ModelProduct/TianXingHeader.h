//
//  interfaceHeader.h
//  ModelProduct
//
//  Created by apple on 16/1/13.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#ifndef ModelProduct_interfaceHeader_h
#define ModelProduct_interfaceHeader_h

#define TX_APIKEY  @"bee76a2202b7c21dd90c5163cb8b4506"

//接口信息

/*********************************天行微信API数据聚合平台***********************************/

/*
 11195775872qq.com
 airong913717
 
 API密钥 :bee76a2202b7c21dd90c5163cb8b4506
 
 70000次请求
*/


/*
 微信热门精选
 
 请求方法：HTTP GET
 数据来源：微信公众平台
 接口地址：http://api.tianapi.com/wxnew/?key=APIKEY&num=10
 使用帮助：默认返回十条数据，num参数最大支持50。
 更新周期：1小时/次（晚间23-07不更新）
 
 key		用户自己的key
 num	    指定返回数量，最大50
 rand		参数值为1则随机获取
 word		检索关键词
 page		翻页，每页输出数量跟随num参数
 
 */

#define TX_weixin_news_server             @"wxnew"


/*
 社会新闻数据
 
 请求方法：HTTP GET
 数据来源：网易、搜狐等社会新闻频道
 接口地址：http://api.huceo.com/social/other/?key=APIKEY&num=10
 使用帮助：默认返回十条数据，num参数最大支持50。
 更新周期：3小时/次

 key	API密钥（请在个人中心获取）	用户自己的key
 num		指定返回数量，最大50
 rand		参数值为1则随机获取
 word		检索关键词
 page		翻页，每页输出数量跟随num参数
*/

#define TX_shehui_news_server             @"social"


/*
 国内新闻数据
 
 请求方法：HTTP GET
 数据来源：网易国内新闻频道
 接口地址：http://api.huceo.com/guonei/other/?key=APIKEY&num=10 JSON返回示例
 使用帮助：默认返回十条数据，num参数最大支持50。
 更新周期：3小时/次

 key		API密钥（请在个人中心获取）	用户自己的key
 num		指定返回数量，最大50
 rand		参数值为1则随机获取
 word		检索关键词
 page		翻页，每页输出数量跟随num参数
*/

#define TX_guonei_news_server             @"guonei"


/*
 国际新闻数据
 
 请求方法：HTTP GET
 数据来源：搜狐国际新闻频道
 接口地址：http://api.huceo.com/world/other/?key=APIKEY&num=10 JSON返回示例
 使用帮助：默认返回十条数据，num参数最大支持50。
 更新周期：3小时/次

 key		API密钥（请在个人中心获取）	用户自己的key
 num		指定返回数量，最大50
 rand		参数值为1则随机获取
 word		检索关键词
 page		翻页，每页输出数量跟随num参数
*/

#define TX_guoji_news_server             @"world"


/*
 体育新闻数据
 
 请求方法：HTTP GET
 数据来源：腾讯等体育栏目
 接口地址：http://api.huceo.com/tiyu/other/?key=APIKEY&num=10 JSON返回示例
 使用帮助：默认返回十条数据，num参数最大支持50。
 更新周期：6小时/次

 key		API密钥（请在个人中心获取）	用户自己的key
 num		指定返回数量，最大50
 rand		参数值为1则随机获取
 word		urlParam	检索关键词
 page		翻页，每页输出数量跟随num参数
*/

#define TX_tiyu_news_server             @"tiyu"


/*
 娱乐花边数据
 
 请求方法：HTTP GET
 数据来源：娱乐花边新闻网、腾讯明星、娱乐频道
 接口地址：http://api.huceo.com/huabian/other/?key=APIKEY&num=10 JSON返回示例
 使用帮助：默认返回十条数据，num参数最大支持50。
 更新周期：6小时/次

 key		API密钥（请在个人中心获取）	用户自己的key
 num		指定返回数量，最大50
 rand		参数值为1则随机获取
 word		检索关键词
 page		翻页，每页输出数量跟随num参数
*/

#define TX_yule_news_server             @"huabian"


/*
 美女图片数据
 
 请求方法：HTTP GET
 数据来源：美图网等
 接口地址：http://api.huceo.com/meinv/other/?key=APIKEY&num=10 JSON返回示例
 使用帮助：默认返回十条数据，num参数最大支持50。
 更新周期：6小时/次

 key		API密钥（请在个人中心获取）	用户自己的key
 num		指定返回数量，最大50
 rand		参数值为1则随机获取
 word		检索关键词
 page		翻页，每页输出数量跟随num参数
*/

#define TX_meinv_news_server             @"meinv"


/*
 科技新闻数据
 
 请求方法：HTTP GET
 数据来源：和讯科技新闻频道
 接口地址：http://api.huceo.com/keji/other/?key=APIKEY&num=10 JSON返回示例
 使用帮助：默认返回十条数据，num参数最大支持50。
 更新周期：3小时/次

 key		API密钥（请在个人中心获取）	用户自己的key
 num		指定返回数量，最大50
 rand		参数值为1则随机获取	0
 word		检索关键词
 page		翻页，每页输出数量跟随num参数
*/

#define TX_keji_news_server             @"keji"


/*
 奇闻异事数据
 
 请求方法：HTTP GET
 数据来源：猎奇网
 接口地址：http://api.huceo.com/qiwen/other/?key=APIKEY&num=10 JSON返回示例
 使用帮助：默认返回十条数据，num参数最大支持50。
 更新周期：3小时/次

 key		API密钥（请在个人中心获取）	用户自己的key
 num		指定返回数量，最大50
 rand		参数值为1则随机获取
 word		检索关键词
 page		翻页，每页输出数量跟随num参数
*/
#define TX_qiwen_news_server             @"qiwen"



/*
 健康资讯数据
 请求方法：HTTP GET
 数据来源：网易健康
 接口地址：http://api.huceo.com/health/other/?key=APIKEY&num=10 JSON返回示例
 使用帮助：默认返回十条数据，num参数最大支持50。
 更新周期：3小时/次

 key	    API密钥（请在个人中心获取）	用户自己的key
 num		指定返回数量，最大50
 rand		参数值为1则随机获取
 word		检索关键词
 page		翻页，每页输出数量跟随num参数
*/

#define TX_jiankang_news_server             @"health"


/*
 旅游热点数据
 请求方法：HTTP GET
 数据来源：网易旅游
 接口地址：http://api.huceo.com/travel/other/?key=APIKEY&num=10 JSON返回示例
 使用帮助：默认返回十条数据，num参数最大支持50。
 更新周期：3小时/次

 key		API密钥（请在个人中心获取）	用户自己的key
 num		指定返回数量，最大50
 rand		参数值为1则随机获取
 word			检索关键词
 page		翻页，每页输出数量跟随num参数
*/

#define TX_lvyou_news_server             @"travel"


/*
 苹果新闻数据
 请求方法：HTTP GET
 数据来源：25PP
 接口地址：http://api.huceo.com/apple/?key=APIKEY&num=10 JSON返回示例
 使用帮助：默认返回十条数据，num参数最大支持50。
 更新周期：3小时/次

 key		API密钥（请在个人中心获取）	用户自己的key
 num		指定返回数量，最大50
 rand		参数值为1则随机获取
 word		检索关键词
 page		翻页，每页输出数量跟随num参数
*/

#define TX_pingguo_news_server             @"apple"


#endif
