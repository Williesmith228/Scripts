#!/usr/bin/python
# coding:utf8

import sys
import os
import urllib2
import jieba
import re
import time
import MySQLdb
reload(sys)
sys.setdefaultencoding('utf8')

url_info = 'http://m.byr.cn/board/JobInfo?p='
find_re = re.compile('<a href="/article/JobInfo/(\d{6})">(.*?)</a>',re.DOTALL)

def get_content(url,begin,end):
	
	for i in range(begin,end):
		try:
			content = urllib2.urlopen(url + str(i)).read()
		except (httplib.BadStatusLine,socket.timeout,socket.error,urllib2.HTTPError,urllib2.URLError):
			sleep(1)
			continue
		#print content
		#time.sleep(2)
		get_theme(content)

def get_theme(content):
	
	for x in re.findall('<a href="/article/JobInfo/(\d{6})">([\s\S]+?)</a>',content):
		 get_word(x[1])

def get_word(theme):

	word_list = jieba.cut(theme,cut_all = False)
	for word in word_list:
		insert_data(word.upper())

def insert_data(word):
	
	print word
	if word != '\\':
		db = MySQLdb.connect(host='localhost',user='root',passwd='123456',port=3306,charset='utf8')
		cursor = db.cursor()
		db.select_db('spider')

		cursor.execute('select * from `byr` where post = "%s";'%(word))
		count = 0
		results = cursor.fetchall()
	
		if len(results) == 0:
			cursor.execute("insert into `byr`(`post`,`count`) values('%s','%d');" %(word,1))
		else:
			for i in results: 
				count = i[2] + 1
				cursor.execute("update `byr` set `count` = '%d' where `post` = '%s';" %(count,word)) 

if __name__ == '__main__':
	
	get_content(url_info,1,1000)

