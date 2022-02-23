# -*- coding: utf-8 -*-
"""
Created on Wed Feb 23 15:55:27 2022

@author: yulif
"""

from bs4 import BeautifulSoup as bs
import requests #a library to load web pages
import pandas as pd #import pandas library to help us store the data
import numpy as np

data = []
base_url = "http://portal.core.edu.au/conf-ranks/?search=&by=all&source=all&sort=atitle&page="

for i in range(1, 46):
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
      print(line)
      
print(data[:200])
print(len(data))
    
np_data = np.array(data)
df = pd.DataFrame(np_data)
    
    
    
    
    