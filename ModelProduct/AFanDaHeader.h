//
//  AFanDaHeader.h
//  ModelProduct
//
//  Created by apple on 16/1/13.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#ifndef ModelProduct_AFanDaHeader_h
#define ModelProduct_AFanDaHeader_h





/*********************************DT阿凡达数据***********************************/

/*
 chjwrr
 ?airong!913717
 
 */



/*
 新华字典
 
 AppKey： 08bb577228214821a04453d1f99b5a5d
 
 
 
 接口地址：http://api.avatardata.cn/XinHuaZiDian/LookUp
 返回格式：JSON/XML
 请求方式：GET/POST
 请求示例： http://api.avatardata.cn/XinHuaZiDian/LookUp?key=08bb577228214821a04453d1f99b5a5d&content=我是中国人
 接口备注：查找短语的每一个字的解释

 请求参数：
 名称	             类型	    必填	      说明
 key	             String	    是	      应用APPKEY
 content	         String	    是	      需要从字典中查找的汉字字符串，可一次查多个汉字，最多一次查50个，超出部分将截断
 dtype	             String	    否	      返回结果格式：可选JSON/XML，默认为JSON
 format	             Boolean	否	      当返回结果格式为JSON时，是否对其进行格式化，为了节省流量默认为false，测试时您可以传入true来熟悉返回内容
 */

#define   xin_hua_zi_dian_key     @"08bb577228214821a04453d1f99b5a5d"
#define   xin_hua_zi_dian_DTAPI   @"XinHuaZiDian/LookUp"



/*
 歇后语
 
 AppKey： 97bf136315fc412fbd8670e798a8fe25
 
 
 接口地址：http://api.avatardata.cn/XieHouYu/Search
 返回格式：JSON/XML
 请求方式：GET/POST
 请求示例： http://api.avatardata.cn/XieHouYu/Search?key=97bf136315fc412fbd8670e798a8fe25&keyWord=瞎子点灯
 接口备注：根据关键字搜索歇后语

 请求参数：
 名称	      类型	    必填	说明
 key	      String	是	应用APPKEY
 keyWord	  String	是	查找关键词
 page	      Int	    是	请求页数，默认page=1
 rows	      Int	    否	返回记录条数，默认rows=20,最大50
 dtype	      String	否	返回结果格式：可选JSON/XML，默认为JSON
 format	      Boolean	否	当返回结果格式为JSON时，是否对其进行格式化，为了节省流量默认为false，测试时您可以传入true来熟悉返回内容
 
 
*/

#define xie_hou_yu_key    @"97bf136315fc412fbd8670e798a8fe25"
#define xie_hou_yu_DTAPI  @"XieHouYu/Random"



/*
 历史上的今天
 
 AppKey： 915c08970d18496dac46a2f113703866
 
 
 接口地址：http://api.avatardata.cn/HistoryToday/LookUp
 返回格式：JSON/XML
 请求方式：GET/POST
 请求示例： http://api.avatardata.cn/HistoryToday/LookUp?key=915c08970d18496dac46a2f113703866&yue=1&ri=1&type=1&page=1&rows=5
 接口备注：查询历史上的今天大事件，支持分页
 
 请求参数：
 名称	       类型	     必填	说明
 key	       String	 是	    应用APPKEY
 yue	       Int	     是	    月份
 ri	           Int	     是	    日期
 type	       Int	     是	    数据类型，1：国内国际大事件，2：民间事件包含部分国家大事件
 page	       Int	     否	    请求页数，默认page=1
 rows	       Int	     否	    返回记录条数，默认rows=20,最大50
 dtype	       String	 否	    返回结果格式：可选JSON/XML，默认为JSON
 format	       Boolean	 否	    当返回结果格式为JSON时，是否对其进行格式化，为了节省流量默认为false，测试时您可以传入true来熟悉返回内容
 
 */

#define li_shi_shang_de_jin_tian_DTAPI  @"http://api.avatardata.cn/HistoryToday/LookUp"


/*
 辞海
 
 AppKey： cac95297f2584eb4a6210b70bc82d95e
 
 
 接口地址：http://api.avatardata.cn/CiHai/LookUp
 返回格式：JSON/XML
 请求方式：GET/POST
 请求示例： http://api.avatardata.cn/CiHai/LookUp?key=cac95297f2584eb4a6210b70bc82d95e&keyword=一生一世
 接口备注：通过单个词语查询解释
 
 请求参数：
 名称	      类型	    必填	说明
 key	      String	是	应用APPKEY
 keyword	  String	是	查询的词语
 dtype	      String	否	返回结果格式：可选JSON/XML，默认为JSON
 format    	  Boolean	否	当返回结果格式为JSON时，是否对其进行格式化，为了节省流量默认为false，测试时您可以传入true来熟悉返回内容
 */
#define ci_hai_key          @"cac95297f2584eb4a6210b70bc82d95e"
#define ci_hai_DTAPI        @"CiHai/query"
#define ci_hai_SuiJi_DTAPI  @"CiHai/Random"

/*
 根据关键字搜索成语
 
 AppKey： 83fd20737600427f86dd4255ff4f793e
 
 
 接口地址：http://api.avatardata.cn/ChengYu/Search
 返回格式：JSON/XML
 请求方式：GET/POST
 请求示例： http://api.avatardata.cn/ChengYu/Search?key=83fd20737600427f86dd4255ff4f793e&keyWord=龙马精神
 接口备注：根据关键字搜索成语
 
 请求参数：
 名称	     类型	     必填	说明
 key	     String	     是	    应用APPKEY
 keyWord	 String	     是	    查找关键词
 page	     Int	     否	    请求页数，默认page=1
 rows	     Int	     否	    返回记录条数，默认rows=20,最大50
 dtype	     String	     否	    返回结果格式：可选JSON/XML，默认为JSON
 format	     Boolean	 否	    当返回结果格式为JSON时，是否对其进行格式化，为了节省流量默认为false，测试时您可以传入true来熟悉返回内容 
 */

#define cheng_yu_key                         @"83fd20737600427f86dd4255ff4f793e"
#define guan_jian_zi_sou_suo_cheng_yu_DTAPI  @"ChengYu/Search"



/*
 单个成语详细解释

 
 AppKey： 83fd20737600427f86dd4255ff4f793e
 
 
 接口地址：http://api.avatardata.cn/ChengYu/LookUp
 返回格式：JSON/XML
 请求方式：GET/POST
 请求示例： http://api.avatardata.cn/ChengYu/LookUp?key=83fd20737600427f86dd4255ff4f793e&id=d420b457-4b86-4ab1-b824-cb84440131fc
 接口备注：单个成语详细解释
 
 请求参数：
 名称	     类型	     必填	说明
 key	     String	     是	    应用APPKEY
 id	         String	     是	    单个成语对应id
 dtype	     String	     否	    返回结果格式：可选JSON/XML，默认为JSON
 format	     Boolean	 否	    当返回结果格式为JSON时，是否对其进行格式化，为了节省流量默认为false，测试时您可以传入true来熟悉返回内容
 */

#define jie_shi_cheng_yu_DTAPI  @"ChengYu/LookUp"


/*
 根据关键字搜索唐诗宋词

 
 AppKey： b0f4612bf2b94aec99c8da9a452d1941
 
 
 接口地址：http://api.avatardata.cn/TangShiSongCi/Search
 返回格式：JSON/XML
 请求方式：GET/POST
 请求示例： http://api.avatardata.cn/TangShiSongCi/Search?key=b0f4612bf2b94aec99c8da9a452d1941&keyWord=秋兴
 接口备注：根据关键字搜索唐诗宋词
 
 请求参数：
 名称	     类型	 必填	说明
 key	     String	  是	    应用APPKEY
 keyWord	 String	  是	    查找关键词
 page	     Int	  否	    请求页数，默认page=1
 rows	     Int	  否	    返回记录条数，默认rows=20,最大50
 dtype	     String	  否	    返回结果格式：可选JSON/XML，默认为JSON
 format	     Boolean  否	    当返回结果格式为JSON时，是否对其进行格式化，为了节省流量默认为false，测试时您可以传入true来熟悉返回内容
 */

#define shi_ci_key                 @"b0f4612bf2b94aec99c8da9a452d1941"
#define guan_jian_zi_shi_ci_DTAPI  @"TangShiSongCi/Search"



/*
 单个唐诗宋词详细解释
 AppKey： b0f4612bf2b94aec99c8da9a452d1941
 
 
 接口地址：http://api.avatardata.cn/TangShiSongCi/LookUp
 返回格式：JSON/XML
 请求方式：GET/POST
 请求示例： http://api.avatardata.cn/TangShiSongCi/LookUp?key=b0f4612bf2b94aec99c8da9a452d1941&id=fbbc1ccd-fabb-4429-9277-e78bb46c0d25
 接口备注：单个唐诗宋词详细解释
 
 请求参数：
 名称	     类型	 必填	  说明
 key	     String	 是	      应用APPKEY
 id	         String	 是	      单个诗词对应id
 dtype	     String	 否	      返回结果格式：可选JSON/XML，默认为JSON
 format	     Boolean 否	      当返回结果格式为JSON时，是否对其进行格式化，为了节省流量默认为false，测试时您可以传入true来熟悉返回内容
 */

#define jie_shi_shi_ci_DTAPI  @"TangShiSongCi/LookUp"



/*
 名人名言
 AppKey： 0e82d72a7ffc43b78e7270c791bdacd1
 
 
 接口地址：http://api.avatardata.cn/MingRenMingYan/LookUp
 返回格式：JSON/XML
 请求方式：GET/POST
 请求示例： http://api.avatardata.cn/MingRenMingYan/LookUp?key=0e82d72a7ffc43b78e7270c791bdacd1&keyword=天才&page=1&rows=5
 接口备注：使用关键字查询名人名言，关键字为名人时返回该名人的名言,关键字为名言时返回该名言所属的名人,支持模糊查询和分页
 
 请求参数：
 名称	     类型	必填	说明
 key	     String	是	应用APPKEY
 keyword	 String	是	查找关键字
 page	     Int	否	请求页数，默认page=1
 rows	     Int	否	返回记录条数，默认rows=20,最大50
 dtype	     String	否	返回结果格式：可选JSON/XML，默认为JSON
 format	     Boolean否	当返回结果格式为JSON时，是否对其进行格式化，为了节省流量默认为false，测试时您可以传入true来熟悉返回内容
 */

#define guan_jian_zi_ming_yan_jing_ju_DTAPI  @"http://api.avatardata.cn/MingRenMingYan/LookUp"

/*
 星座配对
 
 AppKey： 5e0097fb4da544cc910fa6c47bff6424
 
 
 接口地址：http://api.avatardata.cn/XingZuoPeiDui/Lookup
 返回格式：JSON/XML
 请求方式：GET/POST
 请求示例： http://api.avatardata.cn/XingZuoPeiDui/Lookup?key=5e0097fb4da544cc910fa6c47bff6424&xingzuo1=天蝎座&xingzuo2=天秤座
 接口备注：
 请求参数：
 名称	     类型	必填	说明
 key	     String	是	应用APPKEY
 xingzuo1	 String	是	需要配对的主星座
 xingzuo2	 String	是	需要配对的副星座
 dtype	     String	否	返回结果格式：可选JSON/XML，默认为JSON
 format	     Boolean否	当返回结果格式为JSON时，是否对其进行格式化，为了节省流量默认为false，测试时您可以传入true来熟悉返回内容
 */

#define xing_zuo_pei_dui_key    @"5e0097fb4da544cc910fa6c47bff6424"
#define xing_zuo_pei_dui_DTAPI  @"XingZuoPeiDui/Lookup"


/*
 生肖配对
 
 AppKey： afc01f60700c47fa87e3fcdc2e78c3c3
 
 
 接口地址：http://api.avatardata.cn/ShengXiaoPeiDui/Lookup
 返回格式：JSON/XML
 请求方式：GET/POST
 请求示例： http://api.avatardata.cn/ShengXiaoPeiDui/Lookup?key=afc01f60700c47fa87e3fcdc2e78c3c3&shengxiao1=鼠&shengxiao2=虎
 接口备注：
 
 请求参数：
 名称	     类型	必填	说明
 key	     String	是	应用APPKEY
 shengxiao1  String	是	需要配对的主生肖
 shengxiao2	 String	是	需要配对的副生肖
 dtype	     String	否	返回结果格式：可选JSON/XML，默认为JSON
 format	     Boolean	否	当返回结果格式为JSON时，是否对其进行格式化，为了节省流量默认为false，测试时您可以传入true来熟悉返回内容
 */

#define sheng_xiao_pei_dui_key    @"afc01f60700c47fa87e3fcdc2e78c3c3"
#define sheng_xiao_pei_dui_DTAPI  @"ShengXiaoPeiDui/Lookup"

/*
 周公解梦-通过词语查找梦的解释

 
 AppKey： 2bd750de297746f0a3ac01126f6a9a6a
 
 
 接口地址：http://api.avatardata.cn/ZhouGongJieMeng/LookUp
 返回格式：JSON/XML
 请求方式：GET/POST
 请求示例： http://api.avatardata.cn/ZhouGongJieMeng/LookUp?key=2bd750de297746f0a3ac01126f6a9a6a&keyword=梦见妈妈
 接口备注：通过词语查找梦的解释，查询格式是“梦见***”
 
 请求参数：
 名称	     类型	必填	说明
 key	     String	是	应用APPKEY
 keyword	 String	是	梦到的事物,格式为 梦见***
 page	     Int	否	请求页数，默认page=1
 rows	     Int	否	返回记录条数，默认rows=20
 dtype	     String	否	返回结果格式：可选JSON/XML，默认为JSON
 format	     Boolean	否	当返回结果格式为JSON时，是否对其进行格式化，为了节省流量默认为false，测试时您可以传入true来熟悉返回内容
 */

#define jiemengKey              @"2bd750de297746f0a3ac01126f6a9a6a"
#define ci_yu_jie_meng_DTAPI    @"ZhouGongJieMeng/LookUp"


/*
 周公解梦-通过类型查找梦境解释
 
 
 AppKey： 2bd750de297746f0a3ac01126f6a9a6a
 
 
 接口地址：http://api.avatardata.cn/ZhouGongJieMeng/QueryType
 返回格式：JSON/XML
 请求方式：GET/POST
 请求示例： http://api.avatardata.cn/ZhouGongJieMeng/QueryType?key=2bd750de297746f0a3ac01126f6a9a6a&type=人物类&page=1&rows=12
 接口备注：通过类型查找梦境解释，共有十种类型,分别是1.生活类2.物品类3.人物类4.植物类5.活动类6.建筑类7.动物类8.自然类9.其他类10.鬼神类
 
 请求参数：
 名称	     类型	必填	说明
 key	     String	是	应用APPKEY
 type	     String	是	梦境类型,共十种,分别是1.生活类2.物品类3.人物类4.植物类5.活动类6.建筑类7.动物类8.自然类9.其他类10.鬼神类
 page	     Int	否	请求页数，默认page=1
 rows	     Int	否	返回记录条数，默认rows=20
 dtype	     String	否	返回结果格式：可选JSON/XML，默认为JSON
 format	     Boolean否	当返回结果格式为JSON时，是否对其进行格式化，为了节省流量默认为false，测试时您可以传入true来熟悉返回内容
 */

#define lei_xing_jie_meng_DTAPI  @"ZhouGongJieMeng/QueryType"


/*
 星座运势
 
 
 AppKey： 2ed144974eeb41b8bc9f7b3415bb8034
 
 
 接口地址：http://api.avatardata.cn/Constellation/Query
 返回格式：JSON/XML
 请求方式：GET/POST
 请求示例： http://api.avatardata.cn/Constellation/Query?key=2ed144974eeb41b8bc9f7b3415bb8034&consName=%E7%8B%AE%E5%AD%90%E5%BA%A7&type=today
 接口备注：十二星座的今日运势
 
 请求参数：
 名称	     类型	必填	说明
 key	     String	是	应用APPKEY
 consName	 String	是	星座名称，如:金牛座
 type	     String	是	运势类型：today,tomorrow,week,nextweek,month,year
 dtype	     String	否	返回结果格式：可选JSON/XML，默认为JSON
 format	     Boolean	否	当返回结果格式为JSON时，是否对其进行格式化，为了节省流量默认为false，测试时您可以传入true来熟悉返回内容
 */

#define xing_zuo_yun_shi_DTAPI  @"http://api.avatardata.cn/Constellation/Query"



/*
 姓氏起源
 
 
 AppKey： 96f2c453e16c4173a15a7fbd8dd14b6c
 
 
 接口地址：http://api.avatardata.cn/XingShiQiYuan/LookUp
 返回格式：JSON/XML
 请求方式：GET/POST
 请求示例： http://api.avatardata.cn/XingShiQiYuan/LookUp?key=96f2c453e16c4173a15a7fbd8dd14b6c&xingshi=百里
 接口备注：
 请求参数：
 名称	     类型	必填	说明
 key	     String	是	应用APPKEY
 xingshi	 String	是	姓氏
 dtype	     String	否	返回结果格式：可选JSON/XML，默认为JSON
 format	     Boolean	否	当返回结果格式为JSON时，是否对其进行格式化，为了节省流量默认为false，测试时您可以传入true来熟悉返回内容
 */

#define xing_shi_qi_yuan_key           @"96f2c453e16c4173a15a7fbd8dd14b6c"
#define xing_shi_qi_yuan_DTAPI         @"XingShiQiYuan/LookUp"
#define xing_shi_qi_yuan_sui_ji_DTAPI  @"XingShiQiYuan/Random"



/*
 AppKey： 292d1bf66ed44de9abbd96426b022b25
 接口地址：http://api.avatardata.cn/Joke/NewstJoke
 返回格式：JSON/XML
 请求方式：GET/POST
 请求示例： http://api.avatardata.cn/Joke/NewstJoke?key=292d1bf66ed44de9abbd96426b022b25&page=2&rows=10

 请求参数：
 名称	类型	必填	说明
 key	String	是	应用APPKEY
 page	Int	否	当前页数,默认1
 rows	Int	否	返回记录条数，默认rows=20,最大50
 dtype	String	否	返回结果格式：可选JSON/XML，默认为JSON
 format	Boolean	否	当返回结果格式为JSON时，是否对其进行格式化，为了节省流量默认为false，测试时您可以传入true来熟悉返回内容
 */

#define xiao_hua_zui_xin_key     @"292d1bf66ed44de9abbd96426b022b25"
#define xiao_hua_zui_xin_DTAPI   @"Joke/NewstJoke"


/*
 
 接口地址：http://api.avatardata.cn/Joke/NewstImg
 返回格式：JSON/XML
 请求方式：GET/POST
 请求示例： http://api.avatardata.cn/Joke/NewstImg?key=[您申请的APPKEY]&page=2&rows=10
 请求参数：
 名称	类型	必填	说明
 key	String	是	应用APPKEY
 page	Int	否	当前页数,默认1
 rows	Int	否	返回记录条数，默认rows=20,最大50
 dtype	String	否	返回结果格式：可选JSON/XML，默认为JSON
 format	Boolean	否	当返回结果格式为JSON时，是否对其进行格式化，为了节省流量默认为false，测试时您可以传入true来熟悉返回内容
 
 */

#define qu_tu_zui_xin_DTAPI  @"Joke/NewstImg"













#endif
