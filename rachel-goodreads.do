use "https://docs.google.com/uc?id=0B5Y56f52-YHrMEpQX2ZwVDV0QVE&export=download",clear
d
edit


//here were trying to load from google but too big
//goodreads
// https://drive.google.com/open?id=1uhBRW10KS7gzY4adCxH1DQ12y67IFQaO
// https://drive.google.com/open?id=1uhBRW10KS7gzY4adCxH1DQ12y67IFQaO
//insheet using "https://docs.google.com/uc?id=1uhBRW10KS7gzY4adCxH1DQ12y67IFQaO&export=download",clear
//drop id till ampersand the end sign and replace with your id

//so just download by hand
//this insheet using... clear will download or import the data file. 
//Use ,clear bc stata needs to start fresh every time
 insheet using /home/u1/Downloads/100kSamplOfAllSeed4694329905allBooksReadMin1revV1.csv,clear
 
 d
sum
l in 1 
//this "counts" how many reviews/books the user did 
count if usrid==27080036
l if usrid==27080036
// this describes their book reviews verbatin review
l description if usrid==27080036
//this makes table of first 100 users id 
ta usrid in 1/100
// this is title of books user read
l title if usrid==85659
l description if usrid==85659 & title=="Those Who Save Us"
l rev if usrid==85659 & title=="Those Who Save Us"
// "description" is like what the book is about 
// "rev" or review is the actual person's book review

tab usrid in 1/100
tab usrid in 1/100, nol 
recode usrid (1 =164) // did not work... 0 changes

drop isbn13 // this took away isbn13 from table

help string functions
substr("abcdef",2,3) //= "bcd"
substr("abcdef",-3,2) //= "de"
substr("abcdef",2,.) //= "bcdef"
substr("abcdef",-3,.) //= "def"
substr("abcdef",2,0) //= ""
substr("abcdef",15,2) //= ""

//this generates "day" variable with date of added rev
gen day=substr(datadd,1, 3)
ta day
gen day_num=.
replace day_num=1 if day=="Mon"
ta day day_num, mi
edit day day_num
//for recode has to have numeric
recode day_num (6 7=1)(1 2 3 4 5=0), gen(weekend)

help egen
//this shows "each" userid, generates # of books each user read
bys usrid: egen numBooUsr=count(booid)
//this just changes label of variable to something easier to read
la var numBooUsr "number of books for a user"
sort usrid booid
//this lists the userid, bookids, and number of books the user read all in 1 list 
list usrid booid numBooUsr in 1/1000, sepby(usrid)
sum numBooUsr
//this lists which user ids read 3280 books 
ta usrid if numBooUsr==3280

//making the rest of the numbers into days :) 
replace day_num=2 if day=="Tue"
replace day_num=3 if day=="Wed"
replace day_num=4 if day=="Thu"
replace day_num=5 if day=="Fri"
replace day_num=6 if day=="Sat"
replace day_num=7 if day=="Sun"
ta day day_num, mi
edit day day_num 

// going to see num of rev per user 
bys usrid: egen numRevUsr=count(rev)
la var numRevUsr "number of reviews for a user"
// lists userid and how many reviews in 1st 1000 people, separated by their userid
l usrid numRevUsr in 1/1000, sepby(usrid)
// maybe add booid?
l usrid numRevUsr booid in 1/1000, sepby (usrid)

//calculate mean of numBooUsr 
//"statistics" "summaries" "summaries+descrpt stats" "means"
mean numBooUsr 
// The average number of books all users reads is 356.9768
mean numRevUsr
// The average number of reviews for all users is 41.65879 \
// Are they reading many more books than they are reviewing?
// try revid instead?

bys usrid: egen numRevIDUsr=count(revid)
la var numRevIDUsr "number of reviewID for a user" 
l usrid numRevIDUsr booid in 1/1000, sepby (usrid) 
mean numBooUsr numRevIDUsr 
// both means are now the same! 
//**Comment for HW: The averages for both the number of 
//books read for all users and the number of reviews 
//provided by all users are the same number (356.9768) 
//because each book read should have 1 review per user. 
//As users have the option to add books to their list 
//that they've read without being required to write a 
//review, this is interesting!** 

drop numRevUsr

recode day_num (1 2 3 4 5=1) generate (weekday)
help recode




  

