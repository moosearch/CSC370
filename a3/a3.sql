--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: campaign; Type: TABLE; Schema: public; Owner: c370_s06; Tablespace: 
--

CREATE TABLE campaign (
    campaignid integer NOT NULL,
    campaignname text NOT NULL,
    datestart date NOT NULL,
    dateend date NOT NULL,
    city text,
    cost real
);


ALTER TABLE public.campaign OWNER TO c370_s06;

--
-- Name: campaign_campaignid_seq; Type: SEQUENCE; Schema: public; Owner: c370_s06
--

CREATE SEQUENCE campaign_campaignid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campaign_campaignid_seq OWNER TO c370_s06;

--
-- Name: campaign_campaignid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: c370_s06
--

ALTER SEQUENCE campaign_campaignid_seq OWNED BY campaign.campaignid;


--
-- Name: candonateto; Type: TABLE; Schema: public; Owner: c370_s06; Tablespace: 
--

CREATE TABLE candonateto (
    memberid integer NOT NULL,
    fundid integer NOT NULL
);


ALTER TABLE public.candonateto OWNER TO c370_s06;

--
-- Name: contributesto; Type: TABLE; Schema: public; Owner: c370_s06; Tablespace: 
--

CREATE TABLE contributesto (
    donorid integer NOT NULL,
    fundid integer NOT NULL
);


ALTER TABLE public.contributesto OWNER TO c370_s06;

--
-- Name: donor; Type: TABLE; Schema: public; Owner: c370_s06; Tablespace: 
--

CREATE TABLE donor (
    donorid integer NOT NULL,
    cumamtdonated real,
    firstname text,
    lastname text,
    orgname text,
    address text NOT NULL,
    city text NOT NULL,
    postalcode character(6),
    CONSTRAINT donor_postalcode_check CHECK ((postalcode ~ '[a-zA-Z][0-9][a-zA-Z][0-9][a-zA-Z][0-9]'::text))
);


ALTER TABLE public.donor OWNER TO c370_s06;

--
-- Name: donor_donorid_seq; Type: SEQUENCE; Schema: public; Owner: c370_s06
--

CREATE SEQUENCE donor_donorid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.donor_donorid_seq OWNER TO c370_s06;

--
-- Name: donor_donorid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: c370_s06
--

ALTER SEQUENCE donor_donorid_seq OWNED BY donor.donorid;


--
-- Name: employee; Type: TABLE; Schema: public; Owner: c370_s06; Tablespace: 
--

CREATE TABLE employee (
    memid integer NOT NULL,
    monthlysalary real NOT NULL,
    occupation text NOT NULL
);


ALTER TABLE public.employee OWNER TO c370_s06;

--
-- Name: event; Type: TABLE; Schema: public; Owner: c370_s06; Tablespace: 
--

CREATE TABLE event (
    eventid integer NOT NULL,
    campaignid integer,
    eventname text NOT NULL,
    city text NOT NULL,
    amtraised real,
    datestart date NOT NULL,
    dateend date
);


ALTER TABLE public.event OWNER TO c370_s06;

--
-- Name: event_eventid_seq; Type: SEQUENCE; Schema: public; Owner: c370_s06
--

CREATE SEQUENCE event_eventid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_eventid_seq OWNER TO c370_s06;

--
-- Name: event_eventid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: c370_s06
--

ALTER SEQUENCE event_eventid_seq OWNED BY event.eventid;


--
-- Name: expense; Type: TABLE; Schema: public; Owner: c370_s06; Tablespace: 
--

CREATE TABLE expense (
    expenseid integer NOT NULL,
    expensetype text,
    amt real,
    transdate date,
    CONSTRAINT expense_expensetype_check CHECK (((lower(expensetype) = 'campaign'::text) OR (lower(expensetype) = 'employee'::text)))
);


ALTER TABLE public.expense OWNER TO c370_s06;

--
-- Name: expense_expenseid_seq; Type: SEQUENCE; Schema: public; Owner: c370_s06
--

CREATE SEQUENCE expense_expenseid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expense_expenseid_seq OWNER TO c370_s06;

--
-- Name: expense_expenseid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: c370_s06
--

ALTER SEQUENCE expense_expenseid_seq OWNED BY expense.expenseid;


--
-- Name: funds; Type: TABLE; Schema: public; Owner: c370_s06; Tablespace: 
--

CREATE TABLE funds (
    fundid integer NOT NULL,
    fundtype text,
    amt real,
    datereceived date,
    CONSTRAINT funds_fundtype_check CHECK ((((lower(fundtype) = 'donor'::text) OR (lower(fundtype) = 'supporter'::text)) OR (lower(fundtype) = 'event'::text)))
);


ALTER TABLE public.funds OWNER TO c370_s06;

--
-- Name: funds_fundid_seq; Type: SEQUENCE; Schema: public; Owner: c370_s06
--

CREATE SEQUENCE funds_fundid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.funds_fundid_seq OWNER TO c370_s06;

--
-- Name: funds_fundid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: c370_s06
--

ALTER SEQUENCE funds_fundid_seq OWNED BY funds.fundid;


--
-- Name: level1volunteer; Type: TABLE; Schema: public; Owner: c370_s06; Tablespace: 
--

CREATE TABLE level1volunteer (
    mid integer NOT NULL
);


ALTER TABLE public.level1volunteer OWNER TO c370_s06;

--
-- Name: level2volunteer; Type: TABLE; Schema: public; Owner: c370_s06; Tablespace: 
--

CREATE TABLE level2volunteer (
    mid integer NOT NULL
);


ALTER TABLE public.level2volunteer OWNER TO c370_s06;

--
-- Name: members; Type: TABLE; Schema: public; Owner: c370_s06; Tablespace: 
--

CREATE TABLE members (
    memberid integer NOT NULL,
    firstname text NOT NULL,
    lastname text NOT NULL,
    address text NOT NULL,
    city text NOT NULL,
    postalcode character(6) NOT NULL,
    phonenumber character(12),
    datejoined date,
    CONSTRAINT members_phonenumber_check CHECK ((phonenumber ~ '^[0-9][0-9][0-9](-?)[0-9][0-9][0-9](-?)[0-9][0-9][0-9][0-9]'::text))
);


ALTER TABLE public.members OWNER TO c370_s06;

--
-- Name: members_memberid_seq; Type: SEQUENCE; Schema: public; Owner: c370_s06
--

CREATE SEQUENCE members_memberid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.members_memberid_seq OWNER TO c370_s06;

--
-- Name: members_memberid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: c370_s06
--

ALTER SEQUENCE members_memberid_seq OWNED BY members.memberid;


--
-- Name: partakesin; Type: TABLE; Schema: public; Owner: c370_s06; Tablespace: 
--

CREATE TABLE partakesin (
    campaignid integer NOT NULL,
    volunteerid integer NOT NULL
);


ALTER TABLE public.partakesin OWNER TO c370_s06;

--
-- Name: partof; Type: TABLE; Schema: public; Owner: c370_s06; Tablespace: 
--

CREATE TABLE partof (
    expenseid integer NOT NULL,
    employeeid integer NOT NULL
);


ALTER TABLE public.partof OWNER TO c370_s06;

--
-- Name: plaguedby; Type: TABLE; Schema: public; Owner: c370_s06; Tablespace: 
--

CREATE TABLE plaguedby (
    campaignid integer NOT NULL,
    expenseid integer NOT NULL
);


ALTER TABLE public.plaguedby OWNER TO c370_s06;

--
-- Name: q1; Type: VIEW; Schema: public; Owner: c370_s06
--

CREATE VIEW q1 AS
    SELECT members.firstname, members.lastname FROM members WHERE (members.memberid IN (SELECT employee.memid FROM employee WHERE (employee.monthlysalary >= (500)::double precision)));


ALTER TABLE public.q1 OWNER TO c370_s06;

--
-- Name: q2; Type: VIEW; Schema: public; Owner: c370_s06
--

CREATE VIEW q2 AS
    SELECT sum(pf.amt) AS sum FROM (SELECT funds.fundid, funds.fundtype, funds.amt, funds.datereceived FROM funds WHERE (funds.fundtype = 'supporter'::text)) pf;


ALTER TABLE public.q2 OWNER TO c370_s06;

--
-- Name: q3; Type: VIEW; Schema: public; Owner: c370_s06
--

CREATE VIEW q3 AS
    SELECT count(event.eventid) AS count, sum(event.amtraised) AS sum FROM event;


ALTER TABLE public.q3 OWNER TO c370_s06;

--
-- Name: q4; Type: VIEW; Schema: public; Owner: c370_s06
--

CREATE VIEW q4 AS
    SELECT e1.eventname FROM event e1 WHERE (EXISTS (SELECT event.eventid, event.campaignid, event.eventname, event.city, event.amtraised, event.datestart, event.dateend FROM event WHERE ((event.city = e1.city) AND (event.campaignid <> e1.campaignid))));


ALTER TABLE public.q4 OWNER TO c370_s06;

--
-- Name: q5; Type: VIEW; Schema: public; Owner: c370_s06
--

CREATE VIEW q5 AS
    SELECT members.firstname, members.lastname FROM members WHERE (members.memberid IN (SELECT employee.memid FROM employee));


ALTER TABLE public.q5 OWNER TO c370_s06;

--
-- Name: supporter; Type: TABLE; Schema: public; Owner: c370_s06; Tablespace: 
--

CREATE TABLE supporter (
    memid integer NOT NULL,
    cumamtdonated real DEFAULT 0
);


ALTER TABLE public.supporter OWNER TO c370_s06;

--
-- Name: q6; Type: VIEW; Schema: public; Owner: c370_s06
--

CREATE VIEW q6 AS
    SELECT members.firstname, members.lastname FROM (members JOIN (SELECT supporter.memid FROM supporter WHERE (supporter.cumamtdonated >= ALL (SELECT supporter.cumamtdonated FROM supporter))) fp ON ((fp.memid = members.memberid)));


ALTER TABLE public.q6 OWNER TO c370_s06;

--
-- Name: q7; Type: VIEW; Schema: public; Owner: c370_s06
--

CREATE VIEW q7 AS
    SELECT funds.fundid, funds.amt, funds.datereceived FROM funds WHERE (funds.datereceived > '2013-04-01'::date) INTERSECT SELECT funds.fundid, funds.amt, funds.datereceived FROM funds WHERE (funds.datereceived < '2013-06-30'::date);


ALTER TABLE public.q7 OWNER TO c370_s06;

--
-- Name: q8; Type: VIEW; Schema: public; Owner: c370_s06
--

CREATE VIEW q8 AS
    SELECT employee.occupation, count(*) AS numberofemployees FROM employee WHERE (employee.monthlysalary >= (500)::double precision) GROUP BY employee.occupation;


ALTER TABLE public.q8 OWNER TO c370_s06;

--
-- Name: q9; Type: VIEW; Schema: public; Owner: c370_s06
--

CREATE VIEW q9 AS
    SELECT (temp1.sum - temp2.sum) FROM (SELECT sum(funds.amt) AS sum FROM funds) temp1, (SELECT sum(expense.amt) AS sum FROM expense) temp2;


ALTER TABLE public.q9 OWNER TO c370_s06;

--
-- Name: q10; Type: VIEW; Schema: public; Owner: c370_s06
--

CREATE VIEW q10 AS
    SELECT avg(employee.monthlysalary) AS avgmonthlysalary FROM employee;


ALTER TABLE public.q10 OWNER TO c370_s06;

--
-- Name: raises; Type: TABLE; Schema: public; Owner: c370_s06; Tablespace: 
--

CREATE TABLE raises (
    eventid integer NOT NULL,
    fundid integer NOT NULL
);


ALTER TABLE public.raises OWNER TO c370_s06;

--
-- Name: volunteer; Type: TABLE; Schema: public; Owner: c370_s06; Tablespace: 
--

CREATE TABLE volunteer (
    memid integer NOT NULL,
    numofcampaigns integer NOT NULL
);


ALTER TABLE public.volunteer OWNER TO c370_s06;

--
-- Name: campaignid; Type: DEFAULT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY campaign ALTER COLUMN campaignid SET DEFAULT nextval('campaign_campaignid_seq'::regclass);


--
-- Name: donorid; Type: DEFAULT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY donor ALTER COLUMN donorid SET DEFAULT nextval('donor_donorid_seq'::regclass);


--
-- Name: eventid; Type: DEFAULT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY event ALTER COLUMN eventid SET DEFAULT nextval('event_eventid_seq'::regclass);


--
-- Name: expenseid; Type: DEFAULT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY expense ALTER COLUMN expenseid SET DEFAULT nextval('expense_expenseid_seq'::regclass);


--
-- Name: fundid; Type: DEFAULT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY funds ALTER COLUMN fundid SET DEFAULT nextval('funds_fundid_seq'::regclass);


--
-- Name: memberid; Type: DEFAULT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY members ALTER COLUMN memberid SET DEFAULT nextval('members_memberid_seq'::regclass);


--
-- Data for Name: campaign; Type: TABLE DATA; Schema: public; Owner: c370_s06
--

COPY campaign (campaignid, campaignname, datestart, dateend, city, cost) FROM stdin;
1	Fight the Evil Oil Corporations	2013-01-01	2013-03-01	Victoria	10000
2	Promote Natural Forest Growth	2013-02-01	2013-04-01	Victoria	9999
3	Operation Green Attack	2013-09-01	2013-10-01	Vancouver	21337
\.


--
-- Name: campaign_campaignid_seq; Type: SEQUENCE SET; Schema: public; Owner: c370_s06
--

SELECT pg_catalog.setval('campaign_campaignid_seq', 3, true);


--
-- Data for Name: candonateto; Type: TABLE DATA; Schema: public; Owner: c370_s06
--

COPY candonateto (memberid, fundid) FROM stdin;
7	8
7	9
8	10
8	11
8	12
\.


--
-- Data for Name: contributesto; Type: TABLE DATA; Schema: public; Owner: c370_s06
--

COPY contributesto (donorid, fundid) FROM stdin;
1	1
1	2
1	3
1	4
1	5
2	6
4	7
\.


--
-- Data for Name: donor; Type: TABLE DATA; Schema: public; Owner: c370_s06
--

COPY donor (donorid, cumamtdonated, firstname, lastname, orgname, address, city, postalcode) FROM stdin;
1	5000	\N	\N	Alex Lanbeck's Charity Foundation	720 Blaze Avenue	Victoria	V9A3A2
2	2500	\N	\N	A Charity For Poor Children	123 Fruitcake Street	Victoria	V9A3H8
4	1000	\N	\N	Save the smelly cats	6969 Garden Road	Vancouver	V8F4D3
\.


--
-- Name: donor_donorid_seq; Type: SEQUENCE SET; Schema: public; Owner: c370_s06
--

SELECT pg_catalog.setval('donor_donorid_seq', 4, true);


--
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: c370_s06
--

COPY employee (memid, monthlysalary, occupation) FROM stdin;
2	500	Top Director
3	400	Assistant Director
4	600	Strategist
\.


--
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: c370_s06
--

COPY event (eventid, campaignid, eventname, city, amtraised, datestart, dateend) FROM stdin;
1	1	Hazardous Effects of Oil Mining	Victoria	420	2013-01-14	2013-01-18
2	1	The History of Oil Mining	Victoria	420	2013-01-17	2013-01-20
3	1	The Truth About Oil Mining	Victoria	40	2013-01-26	2013-01-29
4	1	Oil Mining and You	Esquimalt	4	2013-02-18	2013-02-21
5	2	What are trees?	Esquimalt	40	2013-02-18	2013-02-21
6	2	The anatomy of trees	Oak Bay	20	2013-02-28	2013-03-06
7	2	The slowly dwindling species	Esquimalt	1026	2013-03-11	2013-03-13
8	3	How green can you be?	Surrey	1337	2013-09-11	2013-09-13
9	3	Are you in the red?	Surrey	220.130005	2013-09-16	2013-09-20
10	3	How to talk about green culture	Burnaby	220.130005	2013-09-20	2013-09-22
11	3	The culture behind 420	Vancouver	54321	2013-09-29	2013-09-30
\.


--
-- Name: event_eventid_seq; Type: SEQUENCE SET; Schema: public; Owner: c370_s06
--

SELECT pg_catalog.setval('event_eventid_seq', 11, true);


--
-- Data for Name: expense; Type: TABLE DATA; Schema: public; Owner: c370_s06
--

COPY expense (expenseid, expensetype, amt, transdate) FROM stdin;
1	campaign	5000	2012-12-25
2	campaign	5000	2013-01-15
3	campaign	4000	2013-02-01
4	campaign	3000	2013-02-23
5	campaign	1999	2013-03-10
6	campaign	3000	2013-09-01
7	campaign	7000	2013-09-21
8	campaign	10000	2013-09-22
9	campaign	1337	2013-09-28
10	employee	500	2013-02-01
11	employee	500	2013-03-01
12	employee	500	2013-04-01
13	employee	500	2013-05-01
14	employee	500	2013-06-01
15	employee	500	2013-07-01
16	employee	400	2013-02-01
17	employee	400	2013-03-01
18	employee	400	2013-04-01
19	employee	400	2013-05-01
20	employee	600	2013-02-01
21	employee	600	2013-03-01
22	employee	600	2013-04-01
23	employee	600	2013-05-01
\.


--
-- Name: expense_expenseid_seq; Type: SEQUENCE SET; Schema: public; Owner: c370_s06
--

SELECT pg_catalog.setval('expense_expenseid_seq', 23, true);


--
-- Data for Name: funds; Type: TABLE DATA; Schema: public; Owner: c370_s06
--

COPY funds (fundid, fundtype, amt, datereceived) FROM stdin;
1	donor	1000	2013-01-10
2	donor	1000	2013-02-10
3	donor	1000	2013-03-10
4	donor	1000	2013-04-10
5	donor	1000	2013-06-10
6	donor	2500	2013-03-29
7	donor	1000	2013-09-23
8	supporter	100	2013-02-06
9	supporter	100	2013-04-06
10	supporter	200	2013-06-06
11	supporter	200	2013-07-01
12	supporter	100	2013-08-31
13	event	420	2013-01-19
14	event	420	2013-01-20
15	event	40	2013-01-30
16	event	4	2013-02-21
17	event	20	2013-03-06
18	event	1026	2013-03-14
19	event	1337	2013-09-14
20	event	220.130005	2013-09-21
21	event	220.130005	2013-09-23
22	event	54321	2013-10-01
\.


--
-- Name: funds_fundid_seq; Type: SEQUENCE SET; Schema: public; Owner: c370_s06
--

SELECT pg_catalog.setval('funds_fundid_seq', 22, true);


--
-- Data for Name: level1volunteer; Type: TABLE DATA; Schema: public; Owner: c370_s06
--

COPY level1volunteer (mid) FROM stdin;
6
\.


--
-- Data for Name: level2volunteer; Type: TABLE DATA; Schema: public; Owner: c370_s06
--

COPY level2volunteer (mid) FROM stdin;
5
\.


--
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: c370_s06
--

COPY members (memberid, firstname, lastname, address, city, postalcode, phonenumber, datejoined) FROM stdin;
2	John	Hancock	420 High Avenue	Victoria	V9A4H8	250-934-3056	2013-01-02
3	Roger	Brown	1337 Low Avenue	Victoria	V9A8J0	250-546-3572	2013-01-02
4	Joe	Nagasaki	6930 Douglas Street	Victoria	V9A1G7	250-728-1283	2013-01-02
5	Ashley	Adair	163 Pine Street	Victoria	V9A6L4	250-627-8938	2013-01-02
6	Sandra	Humpsalot	737 Vanilla Avenue	Victoria	V9A7L2	250-254-3825	2013-02-02
7	Jackie	Virgin	241 Cherry Avenue	Vancouver	M5R263	604-244-7272	2013-02-02
8	Shing	Nujabes	123 Fake Street	Vancouver	M5R263	604-334-1422	2013-01-16
\.


--
-- Name: members_memberid_seq; Type: SEQUENCE SET; Schema: public; Owner: c370_s06
--

SELECT pg_catalog.setval('members_memberid_seq', 8, true);


--
-- Data for Name: partakesin; Type: TABLE DATA; Schema: public; Owner: c370_s06
--

COPY partakesin (campaignid, volunteerid) FROM stdin;
\.


--
-- Data for Name: partof; Type: TABLE DATA; Schema: public; Owner: c370_s06
--

COPY partof (expenseid, employeeid) FROM stdin;
10	2
11	2
12	2
13	2
14	2
15	2
16	3
17	3
18	3
19	3
20	4
21	4
22	4
23	4
\.


--
-- Data for Name: plaguedby; Type: TABLE DATA; Schema: public; Owner: c370_s06
--

COPY plaguedby (campaignid, expenseid) FROM stdin;
1	1
1	2
2	3
2	4
2	5
3	6
3	7
3	8
3	9
\.


--
-- Data for Name: raises; Type: TABLE DATA; Schema: public; Owner: c370_s06
--

COPY raises (eventid, fundid) FROM stdin;
1	13
2	14
3	15
4	16
6	17
7	18
8	19
9	20
10	21
11	22
\.


--
-- Data for Name: supporter; Type: TABLE DATA; Schema: public; Owner: c370_s06
--

COPY supporter (memid, cumamtdonated) FROM stdin;
7	200
8	500
\.


--
-- Data for Name: volunteer; Type: TABLE DATA; Schema: public; Owner: c370_s06
--

COPY volunteer (memid, numofcampaigns) FROM stdin;
5	3
6	2
\.


--
-- Name: campaign_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s06; Tablespace: 
--

ALTER TABLE ONLY campaign
    ADD CONSTRAINT campaign_pkey PRIMARY KEY (campaignid);


--
-- Name: candonateto_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s06; Tablespace: 
--

ALTER TABLE ONLY candonateto
    ADD CONSTRAINT candonateto_pkey PRIMARY KEY (memberid, fundid);


--
-- Name: contributesto_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s06; Tablespace: 
--

ALTER TABLE ONLY contributesto
    ADD CONSTRAINT contributesto_pkey PRIMARY KEY (donorid, fundid);


--
-- Name: donor_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s06; Tablespace: 
--

ALTER TABLE ONLY donor
    ADD CONSTRAINT donor_pkey PRIMARY KEY (donorid);


--
-- Name: employee_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s06; Tablespace: 
--

ALTER TABLE ONLY employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (memid);


--
-- Name: event_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s06; Tablespace: 
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_pkey PRIMARY KEY (eventid);


--
-- Name: expense_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s06; Tablespace: 
--

ALTER TABLE ONLY expense
    ADD CONSTRAINT expense_pkey PRIMARY KEY (expenseid);


--
-- Name: funds_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s06; Tablespace: 
--

ALTER TABLE ONLY funds
    ADD CONSTRAINT funds_pkey PRIMARY KEY (fundid);


--
-- Name: level1volunteer_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s06; Tablespace: 
--

ALTER TABLE ONLY level1volunteer
    ADD CONSTRAINT level1volunteer_pkey PRIMARY KEY (mid);


--
-- Name: level2volunteer_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s06; Tablespace: 
--

ALTER TABLE ONLY level2volunteer
    ADD CONSTRAINT level2volunteer_pkey PRIMARY KEY (mid);


--
-- Name: members_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s06; Tablespace: 
--

ALTER TABLE ONLY members
    ADD CONSTRAINT members_pkey PRIMARY KEY (memberid);


--
-- Name: partakesin_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s06; Tablespace: 
--

ALTER TABLE ONLY partakesin
    ADD CONSTRAINT partakesin_pkey PRIMARY KEY (campaignid, volunteerid);


--
-- Name: partof_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s06; Tablespace: 
--

ALTER TABLE ONLY partof
    ADD CONSTRAINT partof_pkey PRIMARY KEY (expenseid, employeeid);


--
-- Name: plaguedby_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s06; Tablespace: 
--

ALTER TABLE ONLY plaguedby
    ADD CONSTRAINT plaguedby_pkey PRIMARY KEY (campaignid, expenseid);


--
-- Name: raises_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s06; Tablespace: 
--

ALTER TABLE ONLY raises
    ADD CONSTRAINT raises_pkey PRIMARY KEY (eventid, fundid);


--
-- Name: supporter_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s06; Tablespace: 
--

ALTER TABLE ONLY supporter
    ADD CONSTRAINT supporter_pkey PRIMARY KEY (memid);


--
-- Name: volunteer_pkey; Type: CONSTRAINT; Schema: public; Owner: c370_s06; Tablespace: 
--

ALTER TABLE ONLY volunteer
    ADD CONSTRAINT volunteer_pkey PRIMARY KEY (memid);


--
-- Name: candonateto_fundid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY candonateto
    ADD CONSTRAINT candonateto_fundid_fkey FOREIGN KEY (fundid) REFERENCES funds(fundid);


--
-- Name: candonateto_memberid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY candonateto
    ADD CONSTRAINT candonateto_memberid_fkey FOREIGN KEY (memberid) REFERENCES members(memberid);


--
-- Name: contributesto_donorid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY contributesto
    ADD CONSTRAINT contributesto_donorid_fkey FOREIGN KEY (donorid) REFERENCES donor(donorid);


--
-- Name: contributesto_fundid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY contributesto
    ADD CONSTRAINT contributesto_fundid_fkey FOREIGN KEY (fundid) REFERENCES funds(fundid);


--
-- Name: employee_memid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY employee
    ADD CONSTRAINT employee_memid_fkey FOREIGN KEY (memid) REFERENCES members(memberid);


--
-- Name: event_campaignid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_campaignid_fkey FOREIGN KEY (campaignid) REFERENCES campaign(campaignid);


--
-- Name: level1volunteer_mid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY level1volunteer
    ADD CONSTRAINT level1volunteer_mid_fkey FOREIGN KEY (mid) REFERENCES volunteer(memid);


--
-- Name: level2volunteer_mid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY level2volunteer
    ADD CONSTRAINT level2volunteer_mid_fkey FOREIGN KEY (mid) REFERENCES volunteer(memid);


--
-- Name: partakesin_campaignid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY partakesin
    ADD CONSTRAINT partakesin_campaignid_fkey FOREIGN KEY (campaignid) REFERENCES campaign(campaignid);


--
-- Name: partakesin_volunteerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY partakesin
    ADD CONSTRAINT partakesin_volunteerid_fkey FOREIGN KEY (volunteerid) REFERENCES members(memberid);


--
-- Name: partof_employeeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY partof
    ADD CONSTRAINT partof_employeeid_fkey FOREIGN KEY (employeeid) REFERENCES members(memberid);


--
-- Name: partof_expenseid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY partof
    ADD CONSTRAINT partof_expenseid_fkey FOREIGN KEY (expenseid) REFERENCES expense(expenseid);


--
-- Name: plaguedby_campaignid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY plaguedby
    ADD CONSTRAINT plaguedby_campaignid_fkey FOREIGN KEY (campaignid) REFERENCES campaign(campaignid);


--
-- Name: plaguedby_expenseid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY plaguedby
    ADD CONSTRAINT plaguedby_expenseid_fkey FOREIGN KEY (expenseid) REFERENCES expense(expenseid);


--
-- Name: raises_eventid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY raises
    ADD CONSTRAINT raises_eventid_fkey FOREIGN KEY (eventid) REFERENCES event(eventid);


--
-- Name: raises_fundid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY raises
    ADD CONSTRAINT raises_fundid_fkey FOREIGN KEY (fundid) REFERENCES funds(fundid);


--
-- Name: supporter_memid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY supporter
    ADD CONSTRAINT supporter_memid_fkey FOREIGN KEY (memid) REFERENCES members(memberid);


--
-- Name: volunteer_memid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: c370_s06
--

ALTER TABLE ONLY volunteer
    ADD CONSTRAINT volunteer_memid_fkey FOREIGN KEY (memid) REFERENCES members(memberid);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

