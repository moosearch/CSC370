'''
Wesley Chow V00727646
CSC370 
Assignment 4
Dec 4, 2013

Description
	Implements an application server tier for the database hosted by studentdb.csc.uvic.ca.
'''

#!/usr/bin/python

import psycopg2

def main():
	dbconn	= psycopg2.connect(host='studentdb.csc.uvic.ca', user='c370_s06',password='QnkdAuMP')
	cursor =dbconn.cursor()
	cursor.execute("""
	select *
	from Employees
	where salary < 5
	""")
	for row in cursor.fetchall():
		print "%s %s" % (row[0], row[1])
	cursor.close()
	dbconn.close()
	
	
if __name__ == "__main__": main() 