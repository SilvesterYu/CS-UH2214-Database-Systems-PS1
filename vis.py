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

x = df1.collabcount.to_list()
y = df1.authorcount.to_list()

print("this is x", x)
print("this is y", y)

# Creating figure and axes
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=[7, 11])

# Plotting the graph using log
ax1.plot(x, y, ':b', linewidth=2, label='vis1')
ax1.set_title('log plot', fontsize=15)
ax1.set_xlabel('collaborator count', fontsize=13)
ax1.set_ylabel('log(author count)', fontsize=13)
ax1.set_yscale('log')
ax1.legend()

# Plotting the graph with Log ticks at x and y axis using loglog
ax2.loglog(x, y, '--r', linewidth=2, label='vis1')
ax2.set_title('loglog plot', fontsize=15)
ax2.set_xlabel('log(collaborator count)', fontsize=13)
ax2.set_ylabel('log(author count)', fontsize=13)
ax2.legend()

plt.tight_layout()
plt.show()
fig.savefig("vis1.png")

# -------------------- for vis2 -----------------------------
x = df2.pubcount.to_list()
y = df2.authorcount.to_list()

print("this is x", x)
print("this is y", y)

# Creating figure and axes
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=[7, 11])

# Plotting the graph using log
ax1.hist(x, y, ':b', linewidth=2, label='vis2')
ax1.set_title('log plot', fontsize=15)
ax1.set_xlabel('publication count', fontsize=13)
ax1.set_ylabel('log(cuthor count)', fontsize=13)
ax1.set_yscale('log')
ax1.legend()

# Plotting the graph with Log ticks at x and y axis using loglog
ax2.loglog(x, y, '--r', linewidth=2, label='vis2')
ax2.set_title('loglog plot', fontsize=15)
ax2.set_xlabel('log(publication count)', fontsize=13)
ax2.set_ylabel('log(author count)', fontsize=13)
ax2.legend()

plt.tight_layout()
plt.show()
fig.savefig("vis2.png")