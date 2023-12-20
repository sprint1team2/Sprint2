toc.dat                                                                                             0000600 0004000 0002000 00000013203 14537352734 0014453 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP   ,                    {            moviedatabase    16.0    16.0     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false         �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false         �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false         �           1262    24846    moviedatabase    DATABASE     �   CREATE DATABASE moviedatabase WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Canada.1252';
    DROP DATABASE moviedatabase;
                postgres    false         �            1259    24859    movies    TABLE     �   CREATE TABLE public.movies (
    movieid integer NOT NULL,
    title character varying(100) NOT NULL,
    releasedate date,
    genres character varying(100),
    director character varying(100),
    userid integer
);
    DROP TABLE public.movies;
       public         heap    postgres    false         �            1259    24858    movies_movieid_seq    SEQUENCE     �   CREATE SEQUENCE public.movies_movieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.movies_movieid_seq;
       public          postgres    false    218         �           0    0    movies_movieid_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.movies_movieid_seq OWNED BY public.movies.movieid;
          public          postgres    false    217         �            1259    24848    users    TABLE     
  CREATE TABLE public.users (
    userid integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    firstname character varying(50),
    lastname character varying(50)
);
    DROP TABLE public.users;
       public         heap    postgres    false         �            1259    24847    users_userid_seq    SEQUENCE     �   CREATE SEQUENCE public.users_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.users_userid_seq;
       public          postgres    false    216         �           0    0    users_userid_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.users_userid_seq OWNED BY public.users.userid;
          public          postgres    false    215         V           2604    24862    movies movieid    DEFAULT     p   ALTER TABLE ONLY public.movies ALTER COLUMN movieid SET DEFAULT nextval('public.movies_movieid_seq'::regclass);
 =   ALTER TABLE public.movies ALTER COLUMN movieid DROP DEFAULT;
       public          postgres    false    218    217    218         U           2604    24851    users userid    DEFAULT     l   ALTER TABLE ONLY public.users ALTER COLUMN userid SET DEFAULT nextval('public.users_userid_seq'::regclass);
 ;   ALTER TABLE public.users ALTER COLUMN userid DROP DEFAULT;
       public          postgres    false    216    215    216         �          0    24859    movies 
   TABLE DATA           W   COPY public.movies (movieid, title, releasedate, genres, director, userid) FROM stdin;
    public          postgres    false    218       4850.dat �          0    24848    users 
   TABLE DATA           W   COPY public.users (userid, username, password, email, firstname, lastname) FROM stdin;
    public          postgres    false    216       4848.dat �           0    0    movies_movieid_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.movies_movieid_seq', 100, true);
          public          postgres    false    217         �           0    0    users_userid_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_userid_seq', 100, true);
          public          postgres    false    215         ^           2606    24864    movies movies_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (movieid);
 <   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_pkey;
       public            postgres    false    218         X           2606    24857    users uc_email 
   CONSTRAINT     J   ALTER TABLE ONLY public.users
    ADD CONSTRAINT uc_email UNIQUE (email);
 8   ALTER TABLE ONLY public.users DROP CONSTRAINT uc_email;
       public            postgres    false    216         Z           2606    24853    users users_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    216         \           2606    24855    users users_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_username_key;
       public            postgres    false    216         _           2606    24865    movies movies_userid_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid);
 C   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_userid_fkey;
       public          postgres    false    4698    216    218                                                                                                                                                                                                                                                                                                                                                                                                     4850.dat                                                                                            0000600 0004000 0002000 00000015255 14537352734 0014277 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Emotion	2017-04-22	Comedy|Horror	Felice Muccino	\N
2	Divine Intervention (Yadon ilaheyya)	2012-12-29	Comedy|Drama|Romance|War	Modesta Smedley	\N
3	Big Shots	2008-03-15	Adventure|Children|Comedy	Cristabel Ahearne	\N
4	Malice N Wonderland	2016-03-18	Drama|Musical	Rodi Shoard	\N
5	Altered States	2002-10-07	Drama|Sci-Fi	Packston Gillice	\N
6	Seitsemän veljestä	2009-07-01	Drama	Bili Grimsdale	\N
7	Mother and Child	2023-01-13	Drama	Hercules Gamage	\N
8	Sexy Beast	2000-01-18	Comedy|Crime|Drama	Kessiah Gloyens	\N
9	Outrageous Class (Hababam sinifi)	2000-06-15	Comedy|Drama	Ammamaria Fazakerley	\N
10	Hands of the Ripper	2011-06-27	Horror|Thriller	Josiah Whitley	\N
11	Labyrinth of Passion (Laberinto de Pasiones)	2001-12-03	Comedy	Derwin Annakin	\N
12	Waterdance, The	2010-02-01	Drama	Jana Petrolli	\N
13	3 Women (Three Women)	2013-11-10	Drama	Jeanna Durnin	\N
14	Hadewijch	2012-09-10	Drama	Alley Youle	\N
15	Stardust	2013-06-08	Drama	Bryant Dailey	\N
16	Castle Keep	2011-10-26	Drama|War	Barbabra Tither	\N
17	River of No Return	2021-12-29	Adventure|Western	Aldous Seres	\N
18	Tyler Perry's Daddy's Little Girls	2021-06-09	Comedy|Romance	Kirk Welbourn	\N
19	Changing Sides (De l'autre côté du lit)	2017-05-23	Comedy	Barclay Gatteridge	\N
20	Something Real and Good	2007-05-11	Drama	Vittorio Jiranek	\N
21	Super Cops, The	2007-05-21	Action|Comedy|Crime|Drama|Thriller	Payton Harmson	\N
22	Great Stone Face, The	2001-10-25	Documentary	Arie Escot	\N
23	A Good Marriage	2003-10-15	Thriller	Edward Driver	\N
24	35 Up	2016-11-11	Documentary	Ellswerth Chappelow	\N
25	Great Ecstasy of Robert Carmichael, The	2023-07-05	Drama|Horror	Gretna St. Quentin	\N
26	Tale of Despereaux, The	2005-11-11	Adventure|Animation|Children|Comedy|Fantasy	Eudora Asser	\N
27	Decline of Western Civilization Part II: The Metal Years, The	2011-10-11	Documentary	Chandler Brummitt	\N
28	Tension at Table Rock	2000-03-07	Western	Emmalee Vincent	\N
29	So Undercover	2011-08-11	Action|Comedy	Norean MacArthur	\N
30	Conspiracy	2012-02-07	Drama|War	Estevan Jikylls	\N
31	Retrogade	2007-10-17	Action|Adventure|Sci-Fi	Erroll MacGiffin	\N
32	Shotgun Stories	2012-08-25	Drama|Thriller	Benedicto Baldry	\N
33	The Diary of Anne Frank	2020-06-27	Drama	Marty Loughran	\N
34	Karla	2012-08-06	Crime|Drama|Thriller	Prinz Luddy	\N
35	Mama	2016-01-19	Horror	Elva Allin	\N
36	Devil's Chair, The	2014-07-03	Horror	Hilarius Iredale	\N
37	Illustrious Corpses (Cadaveri eccellenti)	2002-02-28	Crime|Mystery|Thriller	Byrle Ahlf	\N
38	Golden Boys, The	2005-07-09	Comedy|Romance	Morten Menelaws	\N
39	Next Man, The	2008-12-17	Action|Thriller	Benedikta Ellul	\N
40	Alien from L.A.	2008-08-28	Sci-Fi	Etty Cushelly	\N
41	Even Money	2009-02-04	Crime|Drama	Clifford Propper	\N
42	Blue Like Jazz	2013-06-29	Comedy|Drama	Mathe Shellshear	\N
43	Downhill	2007-04-15	Drama	Sayre Cargenven	\N
44	Dreamlife of Angels, The (Vie rêvée des anges, La)	2017-06-10	Drama	Ian Kenealy	\N
45	Bridge, The (Die Brücke)	2016-08-03	War	Marillin Forton	\N
46	Tell No One (Ne le dis à personne)	2006-06-08	Crime|Drama|Mystery|Thriller	Adi Mendel	\N
47	Village People Radio Show (Apa khabar orang kampung)	2020-11-30	Documentary	Wyndham Dood	\N
48	Summer's Tale, A (Conte d'été)	2009-06-01	Comedy|Drama|Romance	Ursulina Peele	\N
49	Frankenstein	2004-02-01	Drama|Horror|Sci-Fi	Niles Gentric	\N
50	Eye for an Eye, An (Oeil pour oeil) (Eyes of the Sahara)	2020-04-10	Drama	Adele Sherston	\N
51	God's Country	2008-10-21	Documentary	Egbert Neagle	\N
52	Elevator	2019-07-05	Comedy|Drama	Gunar Gallahar	\N
53	Sound of the Mountain (Thunder of the Mountain, The) (Yama no oto)	2013-11-18	Drama	Kathi Senner	\N
54	Sense and Sensibility	2001-08-10	Drama|Romance	Fin Ewdale	\N
55	Christmas Holiday	2005-03-30	Drama|Film-Noir	Pauletta McCarter	\N
56	Phantom of the Opera, The	2005-03-02	Drama|Horror|Musical	Stephen Wedderburn	\N
57	River Murders, The	2000-02-25	Thriller	Kelli O'Sheils	\N
58	Bloody Angels (1732 Høtten: Marerittet har et postnummer)	2020-12-17	Thriller	Nicolette Bullent	\N
59	Tokyo Chorus (Tôkyô no kôrasu)	2014-02-11	Comedy|Drama	Halsey Duxbury	\N
60	Salomè	2012-07-08	Drama	Lenka Goodlife	\N
61	Thinner	2007-12-07	Horror|Thriller	Brina Sommerled	\N
62	Split Second	2006-01-20	Film-Noir|Thriller	Corena Aubury	\N
63	New Wave (Nouvelle vague)	2022-10-28	Drama	Kerrill Zelake	\N
64	10 Mountains 10 Years	2014-09-12	Documentary	Eldon Davley	\N
65	Let the Right One In (Låt den rätte komma in)	2008-01-14	Drama|Fantasy|Horror|Romance	Sherm Rigmond	\N
66	Redbelt	2012-10-04	Action|Drama	Darby Pettigree	\N
67	Paranormal Activity 4	2016-01-02	Horror|IMAX	Dominga Sellar	\N
68	Godzilla vs. King Ghidorah (Gojira vs. Kingu Gidorâ)	2020-07-21	Action|Sci-Fi	Pattie Rowlands	\N
69	Angus, Thongs and Perfect Snogging	2013-05-28	Comedy|Romance	Cyndy Tiernan	\N
70	Soul Man	2001-08-14	Comedy	Hank Ghelarducci	\N
71	Sam Peckinpah's West: Legacy of a Hollywood Renegade	2019-11-18	Documentary	Gianina Thayre	\N
72	Against All Flags	2012-02-19	Action|Adventure|Drama|Romance	Guinevere Daen	\N
73	Project Moon Base	2015-11-05	Sci-Fi	Granville Plain	\N
74	Sky Captain and the World of Tomorrow	2001-11-14	Action|Adventure|Sci-Fi	Fifine Hurrion	\N
75	Salon Kitty	2008-05-03	Drama	Somerset Cogger	\N
76	Spider-Man 3	2002-10-16	Action|Adventure|Sci-Fi|Thriller|IMAX	Floria Ruse	\N
77	Alice Adams	2016-05-15	Comedy|Drama	Doralin Carlet	\N
78	We Are Young. We Are Strong.	2006-10-17	Drama	Colline Dady	\N
79	Black Eagle	2019-12-26	Action|Drama	Ransom Arnould	\N
80	Cabaret Balkan (Bure Baruta)	2021-08-31	Drama	Jeanette Gittins	\N
81	My Son John	2011-01-19	Drama	Emera Persich	\N
82	Mystic River	2023-10-07	Crime|Drama|Mystery	Somerset Local	\N
83	Grave Decisions (Wer früher stirbt, ist länger tot)	2018-10-20	Comedy|Drama	Davita Reuss	\N
84	One Man Band	2007-05-18	Animation|Comedy|Musical	Vito Gubbin	\N
85	Babysitters, The	2018-08-28	Drama	Grannie Lynam	\N
86	Crisis: Behind a Presidential Commitment	2011-01-07	Documentary	Eben Lau	\N
87	Wild Boys of the Road	2023-06-01	Adventure|Drama|Romance	Faye Filipczak	\N
88	Fidel	2018-09-17	Documentary	Gennie Seccombe	\N
89	Carnage	2023-08-11	Comedy|Drama	Nedi Sposito	\N
90	Detropia	2019-06-15	Documentary	Birch Kondratenya	\N
91	Happy Times (Xingfu shiguang)	2000-02-09	Comedy|Drama	Marian Lorand	\N
92	Adventure in Space and Time, An	2019-09-19	Drama	Rosalia Rechert	\N
93	Adam's Apples (Adams æbler)	2023-07-02	Comedy|Drama	Eward MacLaverty	\N
94	Invaders from Space	2017-02-05	Action|Sci-Fi	Amelia Krahl	\N
95	Paranormal Activity 2	2016-10-26	Horror|IMAX	Austina Cherrie	\N
96	Scattered Clouds (Midaregumo)	2015-12-18	Drama	Modesty Goady	\N
97	Moneyball	2009-12-24	Drama	Douglas Iskower	\N
98	Bowfinger	2016-03-01	Comedy	Bobbe Armand	\N
99	Paris, France	2021-05-21	Comedy	Doloritas Shilstone	\N
100	Hand, The	2007-12-23	Drama|Horror	Jaymie Vannet	\N
\.


                                                                                                                                                                                                                                                                                                                                                   4848.dat                                                                                            0000600 0004000 0002000 00000014477 14537352734 0014313 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	clistone0	oA7()r,h	clistone0@ucla.edu	Cristionna	Listone
2	csleeman1	cF3!iee4=IF~=	csleeman1@plala.or.jp	Claudine	Sleeman
3	drobbey2	vM3!~4TjS	drobbey2@google.ru	Darsie	Robbey
4	rfoyster3	oF0)oWl!F	rfoyster3@jalbum.net	Rick	Foyster
5	xleathlay4	bF3%1Rn'dsx	xleathlay4@dmoz.org	Xylia	Leathlay
6	ablewis5	oG0<I2z(@GnP=oiZ	ablewis5@npr.org	Artemis	Blewis
7	sattride6	cA8@vT&D|N9	sattride6@free.fr	Starlene	Attride
8	givachyov7	bZ7_u$C`=2	givachyov7@livejournal.com	Goldina	Ivachyov
9	amack8	aF0"oy|j#vHLW*s,	amack8@cnet.com	Alfy	Mack
10	dbaldacchino9	xI4<r}S(80<af~'	dbaldacchino9@cdbaby.com	Dewain	Baldacchino
11	lhalla	vJ5%=FPj=c0zR=&e	lhalla@twitter.com	Linnell	Hall
12	epoundesfordb	uM0<Ytcey6	epoundesfordb@marriott.com	Emmeline	Poundesford
13	dcapenorc	zT8~W'fal<A	dcapenorc@hugedomains.com	Dianne	Capenor
14	ndeningtond	bM0)txy0D/H	ndeningtond@jimdo.com	Nadine	Denington
15	emuslime	qM3@h?wln>~S	emuslime@illinois.edu	Egan	Muslim
16	narpurf	uQ4(b2N>/O	narpurf@pcworld.com	Normy	Arpur
17	lmitking	lR1>A$A|.ruR5	lmitking@google.co.jp	Leopold	Mitkin
18	fbensteadh	rT1}b3{xlfzt'c	fbensteadh@simplemachines.org	Fawn	Benstead
19	acarnowi	bE1,@G78	acarnowi@ocn.ne.jp	Alyss	Carnow
20	oletfordj	aQ6<2*oJ.aNv	oletfordj@macromedia.com	Onofredo	Letford
21	vandryunink	yW3@o1{K~	vandryunink@godaddy.com	Vevay	Andryunin
22	jthowlessl	cY6%c{T~7bl	jthowlessl@microsoft.com	Jabez	Thowless
23	ldumbrallm	rF9._>Pn	ldumbrallm@un.org	Lucilia	Dumbrall
24	rridgewayn	aT1<|An<HG7v7	rridgewayn@bizjournals.com	Ricky	Ridgeway
25	gcrackero	vO3"R,s/	gcrackero@alexa.com	Garret	Cracker
26	soldfieldcherryp	qQ9!0+Auc	soldfieldcherryp@mac.com	Shelton	Oldfield-Cherry
27	tffordeq	sG1<UaBg15I@&	tffordeq@huffingtonpost.com	Teddy	Fforde
28	cfribergr	uS6!B7_uAJ	cfribergr@chronoengine.com	Clayborn	Friberg
29	zkeverns	pS5,Dt$mT>Qc	zkeverns@webeden.co.uk	Zaneta	Kevern
30	amilehamt	qU2%zDDGEN0Uw'hk	amilehamt@blinklist.com	Alastair	Mileham
31	cscarlanu	zZ8(7eN$k	cscarlanu@samsung.com	Clair	Scarlan
32	acometsonv	oM8*j"nXKWqo	acometsonv@tripadvisor.com	Ange	Cometson
33	jkenninghamw	pR8(?}tj	jkenninghamw@hexun.com	Jodie	Kenningham
34	nwallbuttonx	bY7?%~dSOis!{@b	nwallbuttonx@umich.edu	Nev	Wallbutton
35	tvanyashiny	rR2<?4@4k	tvanyashiny@elegantthemes.com	Tremain	Vanyashin
36	whorneyz	rT8#53(*F/'n	whorneyz@amazon.com	Wes	Horney
37	dseagrave10	tV3?L,V24	dseagrave10@washingtonpost.com	Derrik	Seagrave
38	mhutchin11	gR0*!&>|(Tr97Fy	mhutchin11@google.com	Melody	Hutchin
39	rbarette12	lA5'@H"t,MY	rbarette12@answers.com	Raynor	Barette
40	jbeveredge13	eQ0'$(23{da,	jbeveredge13@nasa.gov	Jess	Beveredge
41	rfairney14	uU0%\\a7a1)%8kTy	rfairney14@friendfeed.com	Roseline	Fairney
42	ahaswell15	tZ3*Cc#lvQ\\.y	ahaswell15@pen.io	Arty	Haswell
43	soglethorpe16	qX9&zl+b%f	soglethorpe16@tamu.edu	Shalne	Oglethorpe
44	wloudian17	iD5$>}d&JyDP	wloudian17@economist.com	Walt	Loudian
45	byurov18	yN9!hYo=if=i1V9	byurov18@joomla.org	Bobby	Yurov
46	ccossins19	rH8+j5=R7	ccossins19@delicious.com	Catherina	Cossins
47	esemor1a	wN7|k1w~K.o//!#~	esemor1a@ebay.co.uk	Ermengarde	Semor
48	pwilmington1b	iT1*<gUXL	pwilmington1b@alexa.com	Pippy	Wilmington
49	msavatier1c	lY7=%ORaq	msavatier1c@nationalgeographic.com	Murray	Savatier
50	nlindeboom1d	qA5&8yvY,,XlvEl'	nlindeboom1d@amazonaws.com	Nicola	Lindeboom
51	ddust1e	cM3,d>_{	ddust1e@goo.gl	Deny	Dust
52	cluby1f	pZ4?<>S}l~5ih?	cluby1f@ucsd.edu	Carmine	Luby
53	ldable1g	hT0!@CI(B}~@y?K	ldable1g@slate.com	Letti	Dable
54	rpovah1h	sM7~doE>b	rpovah1h@csmonitor.com	Reiko	Povah
55	lyardy1i	dE4|$%'@I\\@	lyardy1i@surveymonkey.com	Lurette	Yardy
56	eviner1j	cR9=msV9h	eviner1j@dion.ne.jp	Eunice	Viner
57	nwitheridge1k	dB5*r>D>wC	nwitheridge1k@deviantart.com	Nicki	Witheridge
58	jtomblett1l	tS2(8y4`	jtomblett1l@wikia.com	Jeralee	Tomblett
59	lyesipov1m	kI3}Z|kG*U/_PK/	lyesipov1m@domainmarket.com	Lazaro	Yesipov
60	llawley1n	qA1'x5ZBh	llawley1n@examiner.com	Leelah	Lawley
61	afreda1o	xY0{2lLf)5C_U3	afreda1o@hao123.com	Aleen	Freda
62	ktheunissen1p	vN6$25&(a?%|b(>C	ktheunissen1p@so-net.ne.jp	Klarrisa	Theunissen
63	dgiovanitti1q	lV6"q2W/_uV1U}"	dgiovanitti1q@google.com	Dulcie	Giovanitti
64	ebasilotta1r	hI1#0dm%!PYL}4Fc	ebasilotta1r@columbia.edu	Eb	Basilotta
65	gpogg1s	yA4!HQ>8+d_6	gpogg1s@senate.gov	Giulio	Pogg
66	ipigden1t	bY8`&NWVaio	ipigden1t@unc.edu	Israel	Pigden
67	tbrower1u	gB4,H<\\#=	tbrower1u@redcross.org	Terence	Brower
68	jthorne1v	lA4%+=QQLO=)b	jthorne1v@yellowpages.com	Jamie	Thorne
69	tslewcock1w	xV8"s63~rm~nedSW	tslewcock1w@buzzfeed.com	Tomasina	Slewcock
70	zcicchitello1x	bV9*GRHra)+m6{i	zcicchitello1x@cnbc.com	Zeke	Cicchitello
71	hstemp1y	zW4~x8'!?29	hstemp1y@exblog.jp	Hayley	Stemp
72	sberney1z	oE4`HmSu2$`	sberney1z@xinhuanet.com	Sarine	Berney
73	tbeton20	kY3!ZQ=$v)=ai)0	tbeton20@vk.com	Teddy	Beton
74	bplevey21	aF9!"QQ`~!a6Z)Bd	bplevey21@ovh.net	Birch	Plevey
75	pmeadows22	kZ7,m)m0db8	pmeadows22@jiathis.com	Pammi	Meadows
76	ccorck23	jY0>7NT=kq{1%T	ccorck23@tamu.edu	Cherri	Corck
77	vgillings24	bY2\\s9)R~1	vgillings24@cisco.com	Vikky	Gillings
78	bkarpe25	gX4$<+'Bk`"R4	bkarpe25@skyrock.com	Bordy	Karpe
79	dmcrae26	vZ2|EZucbtV	dmcrae26@t.co	Dot	McRae
80	crae27	eK9`U!cUH"t|	crae27@state.gov	Constancia	Rae
81	kdalbey28	hJ1?{.=%IQ4dFy,	kdalbey28@e-recht24.de	Killian	Dalbey
82	okhomishin29	bY2!VVQaE#8s*i+8	okhomishin29@nytimes.com	Ortensia	Khomishin
83	dtrimble2a	hR3,0/y9M6G,o	dtrimble2a@prweb.com	Daisy	Trimble
84	eodonohue2b	aT8@H<jg	eodonohue2b@shareasale.com	Etta	O'Donohue
85	tduny2c	lX0$RG)L	tduny2c@house.gov	Turner	Duny
86	bfigurski2d	dU4/qa5,Xb	bfigurski2d@sciencedirect.com	Barbette	Figurski
87	yplumtree2e	fN2,DHBK,\\8k9Y/)	yplumtree2e@cdbaby.com	York	Plumtree
88	rdoogue2f	qR0_tuE.l_jQdST	rdoogue2f@unicef.org	Rene	Doogue
89	gsnoxall2g	oM6{=624)NYPn<	gsnoxall2g@deviantart.com	Griselda	Snoxall
90	sdambrosi2h	tD1,Y?&$wB	sdambrosi2h@jigsy.com	Silvie	D'Ambrosi
91	lgaskin2i	sI3/r0fVq	lgaskin2i@amazon.com	Lolita	Gaskin
92	jmcquie2j	zZ7<X6F<eLgf	jmcquie2j@flavors.me	Josefina	McQuie
93	tstook2k	dO1_Gb&qGAqy\\b?	tstook2k@columbia.edu	Tate	Stook
94	aciotti2l	xR9'U52D6*lDP	aciotti2l@geocities.com	Anders	Ciotti
95	nmeadowcraft2m	sK5|CeI)<97|`>3	nmeadowcraft2m@nydailynews.com	Nadine	Meadowcraft
96	itessier2n	mO0<!m23kqJW3J	itessier2n@ca.gov	Iormina	Tessier
97	xvaugham2o	qG0%#dn$&O)Wl#g	xvaugham2o@telegraph.co.uk	Xever	Vaugham
98	pscamaden2p	uW6{$PSG80	pscamaden2p@boston.com	Pieter	Scamaden
99	wcatcherside2q	bM9|C,MV	wcatcherside2q@liveinternet.ru	Willamina	Catcherside
100	temmett2r	tY1&iD_Ft	temmett2r@cyberchimps.com	Tam	Emmett
\.


                                                                                                                                                                                                 restore.sql                                                                                         0000600 0004000 0002000 00000011771 14537352734 0015410 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE moviedatabase;
--
-- Name: moviedatabase; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE moviedatabase WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Canada.1252';


ALTER DATABASE moviedatabase OWNER TO postgres;

\connect moviedatabase

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies (
    movieid integer NOT NULL,
    title character varying(100) NOT NULL,
    releasedate date,
    genres character varying(100),
    director character varying(100),
    userid integer
);


ALTER TABLE public.movies OWNER TO postgres;

--
-- Name: movies_movieid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movies_movieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.movies_movieid_seq OWNER TO postgres;

--
-- Name: movies_movieid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movies_movieid_seq OWNED BY public.movies.movieid;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    userid integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    firstname character varying(50),
    lastname character varying(50)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_userid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_userid_seq OWNER TO postgres;

--
-- Name: users_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_userid_seq OWNED BY public.users.userid;


--
-- Name: movies movieid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies ALTER COLUMN movieid SET DEFAULT nextval('public.movies_movieid_seq'::regclass);


--
-- Name: users userid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN userid SET DEFAULT nextval('public.users_userid_seq'::regclass);


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies (movieid, title, releasedate, genres, director, userid) FROM stdin;
\.
COPY public.movies (movieid, title, releasedate, genres, director, userid) FROM '$$PATH$$/4850.dat';

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (userid, username, password, email, firstname, lastname) FROM stdin;
\.
COPY public.users (userid, username, password, email, firstname, lastname) FROM '$$PATH$$/4848.dat';

--
-- Name: movies_movieid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movies_movieid_seq', 100, true);


--
-- Name: users_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_userid_seq', 100, true);


--
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (movieid);


--
-- Name: users uc_email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uc_email UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: movies movies_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       