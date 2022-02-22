-- query 1
/*
select author.name from author,
(select id, count(*) from authored
group by id order by count(*) desc limit 20) as temp1
where author.id = temp1.id
*/
-- anaswer 1: H. Vincent Poor, Mohamed-Slim Alouini, Philip S. Yu, Wei Wang, Yang Liu, Lajos Hanzo, Yu Zhang, Wei Zhang, Zhu Han 0001, Lei Zhang, Victor C. M. Leung, Witold Pedrycz, Wen Gao 0001, Dacheng Tao, Hai Jin 0001, , Lei Wang, Xin Wang, Wei Li, Luca Benini, Li Zhang

-- query 2

select author.name from author, authored, inproceedings
where author.id = authored.id and inproceedings.pubid = authored.pubid and inproceedings.booktitle = 'STOC'
group by author.id order by count(authored.pubid) desc
limit 20;
-- answer 2: Avi Wigderson, Robert Endre Tarjan, Ran Raz, Noam Nisan, Moni Naor, Uriel Feige, Rafail Ostrovsky, Santosh S. Vempala, Mihalis Yannakakis, Venkatesan Guruswami, Frank Thomson Leighton, Oded Goldreich 0001, Christos H. Papadimitriou, Mikkel Thorup, Prabhakar Raghavan, Moses Charikar, Yin Tat Lee, Rocco A. Servedio, Noga Alon, "Madhu Sudan" 

--- query 3
