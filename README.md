# DatabasePS1
### Citation
problem set from CSE 544 - Principles of Database Systems taught @ University of Washington.

### What are Here and How to Run

* the .csv files in this folder are just for easier reference.

### 2 Database Design and Integration

1. When creating the schema, I didn't add primary and foreign key constraints yet dur to the long run time. I added after the table was populated.

### 3 Transformation

1. I'm using intermediate tables:
    (1) merged: joining the publication types with what's alreay in field table
    (2) a_with_homepage: authors with homepage, for easier update of author table
    (3) a_without_homepage: authors without homepage, for easier update of author dable
2. I drop them all at the end of the sql script

### 4.2 Data Integration

#### Question 4.2.2
1. First run crawler.py, it will create 2 csv files 'journal_ranking.csv' and 'conference_ranking.csv' with conference keys, names, and rankings.
2. To successfully load the data into PostgreSQL, make sure to change the [absolute paths] in 'integration.sql' (under '-- Question 2:') to the paths of the two csv's above. Then run 'integration.sql'.

#### Question 4.2.5 Extra Credit
I'm using external python script sadly...
How to run:
0. navigate to the bottom of integration.sql, to where -- Question 5 is
1. comment out section 2 and run section 1
2. run extra_credit_google_scholar.py
3. change absolute path in section 2
4. comment out section 1 and run section 2

### 4.3 Data Visualization

1. before running vis.sql, change (at the bottom of the file) the absolute path directory to the absolute path of this assignment folder. Then run. This file will create two csv files for visualization purpose.
2. Then run vis.py. It will create histograms.
