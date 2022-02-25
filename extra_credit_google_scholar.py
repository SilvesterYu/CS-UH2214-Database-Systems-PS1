from bs4 import BeautifulSoup as bs
import requests #a library to load web pages
import pandas as pd #import pandas library to help us store the data
import numpy as np

d = pd.read_csv("extra_credit_links.csv")
d_select = d[["name", "homepage"]]
my_d = dict(d_select.values)
print(my_d)

data = []
for key, val in my_d.items():
    name = key
    my_url = val
    r = requests.get(my_url)
    soup = bs(r.content, features="html.parser")
    soup.prettify() #on Google Colab it will not show the HTML with indentations but if you did this in Python directly, it will work correctly.
    indicators = [h.text for h in soup.find_all('td', {'class':'gsc_rsb_std'})][::2]
    print(indicators)
    if len(indicators) >= 1:
        indicators.insert(0, name)
        data.append(indicators)
print(data)
df = pd.DataFrame(data)
df.columns = ["name", "citations", "h-index", "i10-index"]
print(df)
df.to_csv("google_scholar.csv", index = False, header = False)