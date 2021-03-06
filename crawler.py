# -*- coding: utf-8 -*-
"""
Created on Wed Feb 23 15:55:27 2022

@author: yulif
"""

from bs4 import BeautifulSoup as bs
import requests #a library to load web pages
import pandas as pd #import pandas library to help us store the data
import numpy as np

####################### a simple crawler ##############################
def crawler_func(start_page, end_page, base_url, linkloc):
    data = []
    
    for i in range(start_page, end_page+1):
        print("--------------------", i, "--------------------------")
        my_url = base_url + str(i)
        r = requests.get(my_url)
        soup = bs(r.content, features="html.parser")        
        soup.prettify() #on Google Colab it will not show the HTML with indentations but if you did this in Python directly, it will work correctly.
        rows = soup.find_all('tr', {"class": ["evenrow", "oddrow"]})
        for row in rows:
          line = [] # store all things in one line
          cells = row.find_all("td")
          for cell in cells:
            clean_row = cell.text.strip('\n').strip()
            line.append(clean_row)
          if row.find("a") != None:
            line[linkloc] = row.find("a")["href"]
          data.append(line)
          #print(line)
    np_data = np.array(data)
    df = pd.DataFrame(np_data)
    return df

########################### for conference ########################
base_url1 = "http://portal.core.edu.au/conf-ranks/?search=&by=all&source=CORE2021&sort=atitle&page="
start_page1 = 1
end_page1 = 20
linkloc1 = 4

df1 = crawler_func(start_page1, end_page1, base_url1, linkloc1)

df1.columns = ['title', 'acronym', 'source', 'rank', 'dblp', 'hasdata', 'primaryfor', 'comments', 'averagerating']
df1 = df1[['title', 'rank', 'dblp']]      
df1["ckey"] = df1['dblp'].apply(lambda x: "/".join(x.strip('/').split("/")[-2:]))
df1 = df1[['ckey', 'title', 'rank', 'dblp']]
df1 = df1[df1.ckey != 'none']
# make sure ckey is unique
df1 = df1.drop_duplicates(subset = 'ckey', keep = 'first')
df1.to_csv("conference_ranking.csv", header = False, index = False)

########################## for journal ########################
base_url2 = "http://portal.core.edu.au/jnl-ranks/?search=&by=all&source=CORE2020&sort=atitle&page="
start_page2 = 1
end_page2 = 13
linkloc2 = 3

df2 = crawler_func(start_page2, end_page2, base_url2, linkloc2)

df2.columns = ['title', 'source', 'rank', 'dblp', 'hasdata', 'for', 'comments', 'averagerating']
df2 = df2[['title', 'rank', 'dblp']]
df2["jkey"] = df2['dblp'].apply(lambda x: "/".join(x.strip('/').split("/")[-2:]))
df2 = df2[['jkey', 'title', 'rank', 'dblp']]
df2 = df2[df2.jkey != 'none']
# make sure jkey is unique
df2 = df2.drop_duplicates(subset = 'jkey', keep = 'first')
df2.to_csv("journal_ranking.csv", header = False, index = False)

    