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
def crawler_func(start_page, end_page, base_url):
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
            line[4] = row.find("a")["href"]
          data.append(line)
          #print(line)
    np_data = np.array(data)
    df = pd.DataFrame(np_data)
    return df

########################### for conference ########################
base_url1 = "http://portal.core.edu.au/conf-ranks/?search=&by=all&source=all&sort=atitle&page="
start_page1 = 1
end_page1 = 45

df1 = crawler_func(start_page1, end_page1, base_url1)

df1.columns = ['title', 'acronym', 'source', 'rank', 'dblp', 'hasdata', 'primaryfor', 'comments', 'averagerating']
df1 = df1[['title', 'acronym', 'source', 'rank', 'dblp']]    

########################## for journal ########################
base_url2 = "http://portal.core.edu.au/conf-ranks/?search=&by=all&source=all&sort=atitle&page="
start_page2 = 1
end_page2 = 18

df2 = crawler_func(start_page2, end_page2, base_url2)

df2.columns = ['title', 'acronym', 'source', 'rank', 'dblp', 'hasdata', 'primaryfor', 'comments', 'averagerating']
df2 = df2[['title', 'acronym', 'source', 'rank', 'dblp']]  
    

    