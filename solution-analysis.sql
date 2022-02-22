-- query 1
/*
select author.name from author,
(select id, count(*) from authored
group by id order by count(*) desc limit 20) as temp1
where author.id = temp1.id
*/
-- anaswer 1: H. Vincent Poor, Mohamed-Slim Alouini, Philip S. Yu, Wei Wang, Yang Liu, Lajos Hanzo, Yu Zhang, Wei Zhang, Zhu Han 0001, Lei Zhang, Victor C. M. Leung, Witold Pedrycz, Wen Gao 0001, Dacheng Tao, Hai Jin 0001, , Lei Wang, Xin Wang, Wei Li, Luca Benini, Li Zhang

-- query 2
/*
select author.name from author, authored, inproceedings
where author.id = authored.id and inproceedings.pubid = authored.pubid and inproceedings.booktitle = 'STOC'
group by author.id order by count(authored.pubid) desc
limit 20;
-- answer 2: Avi Wigderson, Robert Endre Tarjan, Ran Raz, Noam Nisan, Moni Naor, Uriel Feige, Rafail Ostrovsky, Santosh S. Vempala, Mihalis Yannakakis, Venkatesan Guruswami, Frank Thomson Leighton, Oded Goldreich 0001, Christos H. Papadimitriou, Mikkel Thorup, Prabhakar Raghavan, Moses Charikar, Yin Tat Lee, Rocco A. Servedio, Noga Alon, "Madhu Sudan" 
*/

/*
select author.name from author, authored, inproceedings
where author.id = authored.id and inproceedings.pubid = authored.pubid and inproceedings.booktitle = 'SOSP'
group by author.id order by count(authored.pubid) desc
limit 20;
-- answer 2: "M. Frans Kaashoek" "Nickolai Zeldovich""Roger M. Needham""Henry M. Levy""Andrea C. Arpaci-Dusseau""Remzi H. Arpaci-Dusseau""Gerald J. Popek""Gregory R. Ganger""Thomas E. Anderson""Brian N. Bershad""Yuanyuan Zhou 0001""David Mazières""Barbara Liskov""Emmett Witchel""David K. Gifford""Matei Zaharia""Mahadev Satyanarayanan""Ion Stoica""David R. Cheriton""Michael D. Schroeder"
*/

/*
select author.name from author, authored, inproceedings
where author.id = authored.id and inproceedings.pubid = authored.pubid and inproceedings.booktitle = 'CHI'
group by author.id order by count(authored.pubid) desc
limit 20;
-- answer 2: "Patrick Olivier""Carl Gutwin""Tovi Grossman""Scott E. Hudson""Steve Benford""Ravin Balakrishnan""Patrick Baudisch""John Vines""Kasper Hornbæk""George W. Fitzmaurice""Antti Oulasvirta""James A. Landay""Jacob O. Wobbrock""Shumin Zhai""Peter C. Wright""Stephen A. Brewster""Robert E. Kraut""Chris Harrison 0001""Jennifer Mankoff""Regan L. Mandryk"
*/

--- query 3
/*
-- (a)
select author.name from author, authored, inproceedings
where author.id = authored.id and inproceedings.pubid = authored.pubid and inproceedings.booktitle = 'SIGMOD Conference'
group by author.id
having count(authored.pubid) >= 10
except
(select author.name from author, authored, inproceedings
where author.id = authored.id and inproceedings.pubid = authored.pubid and inproceedings.booktitle = 'PODS');
-- answer 3(a): "Themis Palpanas", "Jian Pei", "Alvin Cheung", "Eric Lo 0001", "Stanley B. Zdonik", "K. SelÃ§uk Candan", "Stratos Idreos", "Sihem Amer-Yahia", "Kaushik Chakrabarti", "Gang Chen 0001", "Jens Teubner", "Dirk Habich", "Bingsheng He", "James Cheng", "Carsten Binnig", "Goetz Graefe", "Jiawei Han 0001", "Jianhua Feng", "Bruce G. Lindsay 0001", "Donald Kossmann", "Peter A. Boncz", "Jayavel Shanmugasundaram", "Nicolas Bruno", "Luis Gravano", "Torsten Grust", "Kevin S. Beyer", "Guy M. Lohman", "Zhifeng Bao", "Arun Kumar 0001", "Zhenjie Zhang", "Wook-Shin Han", "Lei Chen 0002", "Jim Gray 0001", "Boon Thau Loo", "Nan Tang 0001", "Mourad Ouzzani", "Alfons Kemper", "Anthony K. H. Tung", "Juliana Freire", "Ioana Manolescu", "Carlos Ordonez 0001", "Xifeng Yan", "Qiong Luo 0001", "Chee Yong Chan", "Clement T. Yu", "Chengkai Li", "JosÃ© A. Blakeley", "Sourav S. Bhowmick", "Michael J. Cafarella", "Jignesh M. Patel", "Carlo Curino", "Barzan Mozafari", "Lijun Chang", "Bin Cui 0001", "Anastasia Ailamaki", "Georgia Koutrika", "AnHai Doan", "Kevin Chen-Chuan Chang", "Tim Kraska", "Jeffrey Xu Yu", "Suman Nath", "Wei Wang 0011", "Xu Chu", "Badrish Chandramouli", "Nick Roussopoulos", "Guoliang Li 0001", "Michael Stonebraker", "Yanlei Diao", "Ashraf Aboulnaga", "Meihui Zhang 0001", "Aaron J. Elmore", "Jiannan Wang", "Shuigeng Zhou", "Hans-Arno Jacobsen", "Lu Qin 0001", "Sailesh Krishnamurthy", "David B. Lomet", "Xiaofang Zhou 0001", "Stefano Ceri", "Jun Yang 0001", "Samuel Madden", "Nan Zhang 0004", "Volker Markl", "Andrew Pavlo", "Feifei Li 0001", "Jorge-Arnulfo QuianÃ©-Ruiz", "Krithi Ramamritham", "Viktor Leis", "Ion Stoica", "Elke A. Rundensteiner", "Fatma Ã–zcan", "Theodoros Rekatsinas", "Aditya G. Parameswaran", "Daniel J. Abadi", "Ugur Ã‡etintemel", "Mohamed F. Mokbel", "Xin Luna Dong", "Byron Choi", "Sudipto Das", "Ihab F. Ilyas", "Yinghui Wu", "Gautam Das 0001", "Jingren Zhou", "Ahmed K. Elmagarmid", "Immanuel Trummer", "Gao Cong", "Yinan Li", "Bolin Ding", "Raymond Chi-Wing Wong", "Xiaokui Xiao", "Cong Yu 0001", "Jianliang Xu", "Eugene Wu 0002"
*/

/*
-- (b)
select distinct author.name from author, authored, inproceedings
where author.id = authored.id and inproceedings.pubid = authored.pubid and inproceedings.booktitle = 'PODS'
group by author.id
having count(authored.pubid) >= 5
except
(select author.name from author, authored, inproceedings
where author.id = authored.id and inproceedings.pubid = authored.pubid and inproceedings.booktitle = 'SIGMOD Conference');
-- answer 3(b): "Marco Console", "Andreas Pieris", "Alan Nash", "Mikolaj Bojanczyk", "Miguel Romero 0001", "Kobbi Nissim", "David P. Woodruff", "Michael Mitzenmacher", "Reinhard Pichler", "Kari-Jouko RÃ¤ihÃ¤", "Matthias Niewerth", "Nofar Carmeli", "Cristian Riveros", "Srikanta Tirthapura", "Domagoj Vrgoc", "Rasmus Pagh", "Vassos Hadzilacos", "Nancy A. Lynch", "Jef Wijsen", "Hubie Chen", "Atri Rudra", "Francesco Scarcello", "Martin Grohe", "Marco A. Casanova", "Giuseppe De Giacomo", "Thomas Schwentick", "Nicole Schweikardt", "Stavros S. Cosmadakis", "Eljas Soisalon-Soininen"
*/

-- query 4
/*
drop table if exists year_count;
create table year_count as
select year, count(*) from publication group by year;

drop table if exists decade_count;
create table decade_count as
select cast(year/10 as varchar(3)) as decade, sum(count) as count from year_count
where year is not null group by decade;

select concat(decade, '0-', decade, '9') as decade, count
from decade_count
order by decade;
-- answer 4: "1930-1939"---56, "1940-1949"---192, "1950-1959"---2617, "1960-1969"---13402, "1970-1979"---47308, "1980-1989"---139092, "1990-1999"---463397, "2000-2009"---1444347, "2010-2019"---3015620, "2020-2029"---861926
*/

-- query 5
/*
drop table if exists collab;
create table collab as
select distinct name, y.id from author, authored x, authored y
where author.id = x.id and x.pubid = y.pubid and y.id != x.id
;

select name from collab
group by name order by count(*) desc limit 20;
-- answer 5: "Yang Liu", "Wei Wang", "Wei Zhang", "Yu Zhang", "Lei Zhang", "Wei Li", "Lei Wang", "Wei Liu", "Yang Li", "Xin Li", "Xin Wang", "Wei Chen", "Li Zhang", "Jing Wang", "Yan Li", "Yi Zhang", "Jing Li", "Yan Wang", "Yan Zhang", "Jun Wang"
*/

-- query 6
/*
drop table if exists decade_author;
create table decade_author as
select distinct id, pubkey, cast(year/10 as varchar(3)) as decade
from authored, publication
where authored.pubid = publication.pubid;

SELECT decade, name, cnt
FROM (   SELECT concat(decade, '0-', decade, '9') as decade, id, cnt,
          RANK() OVER (PARTITION BY decade 
                       ORDER BY cnt DESC) AS rn
   FROM (
      SELECT decade, id, COUNT(id) AS cnt
      FROM decade_author
      GROUP BY decade, id ) t
) s, author
WHERE s.rn = 1 and s.id = author.id
-- answer 6: "1930-1939"	"Willard Van Orman Quine"	7, "1940-1949"	"Willard Van Orman Quine"	10, "1950-1959"	"Hao Wang 0001"	14, "1960-1969"	"Henry C. Thacher Jr."	41, "1970-1979"	"Jeffrey D. Ullman"	85, "1970-1979"	"Grzegorz Rozenberg"	85, "1980-1989"	"Azriel Rosenfeld"	173, "1990-1999"	"Toshio Fukuda"	268, "2000-2009"	"Wen Gao 0001"	566, "2010-2019"	"H. Vincent Poor"	1215, "2020-2029"	"Yang Liu"	611
*/


