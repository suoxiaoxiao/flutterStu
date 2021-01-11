# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class CarfiveonefivefascrapyItem(scrapy.Item):
    # define the fields for your item here like:
    title = scrapy.Field() #标题
    author = scrapy.Field() #作者
    publisher = scrapy.Field() #阅读数
    publishTime = scrapy.Field() #出版日期
    pic = scrapy.Field() #图片
