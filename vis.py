# -*- coding: utf-8 -*-
"""
Created on Wed Feb 23 13:34:24 2022

@author: yulif
"""

#!/usr/bin/python
# Importing necessary libraries
import numpy as np
from matplotlib import pyplot as plt
import pandas as pd

df1 = pd.read_csv("vis1.csv")
df2 = pd.read_csv("vis2.csv")

x1 = df1.collabcount.to_list()
x2 = df2.pubcount.to_list()

x1 = pd.Series(x1)
x2 = pd.Series(x2)


# --------------- vis1 collaborator --------------------
hist, bins, _ = plt.hist(x1, bins=50)
logbins = np.logspace(np.log10(bins[0]),np.log10(bins[-1]),len(bins))
plt.subplot(211)
plt.hist(x1, bins=logbins, log = True)
plt.xscale('log')
plt.title("log-log collaborator visualization")
plt.xlabel("log of bollaborator count")
plt.ylabel("log of author count")
plt.show()
plt.savefig("vis1-collaborator-distribution.png")


# --------------- vis2 publication --------------------
hist, bins, _ = plt.hist(x2, bins=50)
logbins = np.logspace(np.log10(bins[0]),np.log10(bins[-1]),len(bins))
plt.subplot(221)
plt.hist(x2, bins=logbins, log = True)
plt.xscale('log')
plt.title("log-log publication visualization")
plt.xlabel("log of publication count")
plt.ylabel("log of author count")
plt.show()
plt.savefig("vis2-publication-distribution.png")


