import scrapy
from carfiveonefivefaScrapy.items import CarfiveonefivefascrapyItem
import json
import re

class ExampleSpider(scrapy.Spider):
    name = '515fa'
    allowed_domains = ['515fa.com']
    start_urls = ['http://www.515fa.com/qcxl/']

    def parse(self, response):
        with open("carfa.html", "w") as f:
            f.write(response.text)

        # 存放老师信息的集合
        items = []
        lists = []
        for each in response.xpath("//div[@class='wen2']"):
            # 将我们得到的数据封装到一个 `CarfiveonefivefascrapyItem` 对象
            item = CarfiveonefivefascrapyItem()
            # extract()方法返回的都是字符串
            titleElems = each.xpath("div[@class='w2_tit']/a//b")  # 标题
            if len(titleElems) == 2:
                title = each.xpath("div[@class='w2_tit']/a/b/b/text()").extract()[0]
            else:
                title = each.xpath("div[@class='w2_tit']/a/b/text()").extract()[0]
            print(title)
            author = each.xpath("div[@class='w2_riq']/text()").extract()[0].split('　')[0]  # 作者
            publisher = each.xpath("div[@class='w2_riq']/text()").extract()[0].split('　')[1]  # 阅读数
            publishTime = each.xpath("div[@class='w2_riq']/text()").extract()[0].split('　')[2]  # 出版日期
            pic = each.xpath("img/@src").extract()[0].replace('../','http://www.515fa.com')  # 图片

            readmberList = re.findall(r'\d+', publisher)

            publisher = ''.join(readmberList)
            # xpath返回的是包含一个元素的列表
            item['title'] = title
            item['author'] = author
            item['publisher'] = publisher
            item['publishTime'] = publishTime
            item['pic'] = pic

            dict = {
                'title' : title,
                'author' : author,
                'readNumber' : publisher,
                'publishTime' : publishTime,
                'pic' : pic
            }
            lists.append(dict)
            items.append(item)
            print(item)
            # 直接返回最后数据

        with open('data.json', 'w') as f:
            json.dump(lists, f)

        # print(items)
        return items