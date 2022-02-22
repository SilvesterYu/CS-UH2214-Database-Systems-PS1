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

select author.name from author, authored, inproceedings
where author.id = authored.id and inproceedings.pubid = authored.pubid and inproceedings.booktitle = 'CHI'
group by author.id order by count(authored.pubid) desc
limit 20;
-- answer 2: "Patrick Olivier""Carl Gutwin""Tovi Grossman""Scott E. Hudson""Steve Benford""Ravin Balakrishnan""Patrick Baudisch""John Vines""Kasper Hornbæk""George W. Fitzmaurice""Antti Oulasvirta""James A. Landay""Jacob O. Wobbrock""Shumin Zhai""Peter C. Wright""Stephen A. Brewster""Robert E. Kraut""Chris Harrison 0001""Jennifer Mankoff""Regan L. Mandryk"

--- query 3
