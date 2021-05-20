import sys
import os
from pathlib import Path

filename = sys.argv[1]
input_file = open(filename, "r")

filehead = Path(filename).with_suffix('')
try:
	os.mkdir(path="8mer_"+str(filehead))
	os.mkdir(path="9mer_"+str(filehead))
	os.mkdir(path="10mer_"+str(filehead))
	os.mkdir(path="11mer_"+str(filehead))
	os.mkdir(path="12mer_"+str(filehead))
except:
	pass

print(filehead)
allele_set = set()
counter = 0


##Get rid of header line
line=input_file.readline()

##The loop
while True:
	line = input_file.readline().split(",")
	#print (line)
	
	if line[1] not in allele_set:
		try:
			newfile1.close()
			newfile2.close()
			newfile3.close()
		except:
			pass
		allele_set.add(line[1])
		#print(os.getcwd())
		newfile1=open(os.getcwd()+"/8mer_"+str(filehead)+'/'+line[1]+".8mer.50."+str(filehead)+".pep", 'w')
		newfile2=open(os.getcwd()+"/8mer_"+str(filehead)+'/'+line[1]+".8mer.500."+str(filehead)+".pep", 'w')
		newfile3=open(os.getcwd()+"/8mer_"+str(filehead)+'/'+line[1]+".8mer.500plus."+str(filehead)+".pep", 'w')

		newfile4=open(os.getcwd()+"/9mer_"+str(filehead)+'/'+line[1]+".9mer.50."+str(filehead)+".pep", 'w')
		newfile5=open(os.getcwd()+"/9mer_"+str(filehead)+'/'+line[1]+".9mer.500."+str(filehead)+".pep", 'w')
		newfile6=open(os.getcwd()+"/9mer_"+str(filehead)+'/'+line[1]+".9mer.500plus."+str(filehead)+".pep", 'w')

		newfile7=open(os.getcwd()+"/10mer_"+str(filehead)+'/'+line[1]+".10mer.50."+str(filehead)+".pep", 'w')
		newfile8=open(os.getcwd()+"/10mer_"+str(filehead)+'/'+line[1]+".10mer.500."+str(filehead)+".pep", 'w')
		newfile9=open(os.getcwd()+"/10mer_"+str(filehead)+'/'+line[1]+".10mer.500plus."+str(filehead)+".pep", 'w')

		newfile10=open(os.getcwd()+"/11mer_"+str(filehead)+'/'+line[1]+".11mer.50."+str(filehead)+".pep", 'w')
		newfile11=open(os.getcwd()+"/11mer_"+str(filehead)+'/'+line[1]+".11mer.500."+str(filehead)+".pep", 'w')
		newfile12=open(os.getcwd()+"/11mer_"+str(filehead)+'/'+line[1]+".11mer.500plus."+str(filehead)+".pep", 'w')

		newfile13=open(os.getcwd()+"/12mer_"+str(filehead)+'/'+line[1]+".12mer.50."+str(filehead)+".pep", 'w')
		newfile14=open(os.getcwd()+"/12mer_"+str(filehead)+'/'+line[1]+".12mer.500."+str(filehead)+".pep", 'w')
		newfile15=open(os.getcwd()+"/12mer_"+str(filehead)+'/'+line[1]+".12mer.500plus."+str(filehead)+".pep", 'w')

		#print(newfile1)
		#print(newfile2)
		#print(newfile3)
	if len(line[0]) == 8:	
		if float(line[2]) <=50:
			newfile1.write(line[0]+'\n')
		elif float(line[2]) <= 500:
			newfile2.write(line[0]+'\n')
		else:
			newfile3.write(line[0]+'\n')
		counter+=1
	elif len(line[0]) == 9:
		if float(line[2]) <=50:
			newfile4.write(line[0]+'\n')
		elif float(line[2]) <= 500:
			newfile5.write(line[0]+'\n')
		else:
			newfile6.write(line[0]+'\n')
		counter+=1
	elif len(line[0]) == 10:
		if float(line[2]) <=50:
			newfile7.write(line[0]+'\n')
		elif float(line[2]) <= 500:
			newfile8.write(line[0]+'\n')
		else:
			newfile9.write(line[0]+'\n')
		counter+=1
	elif len(line[0]) == 11:
		if float(line[2]) <=50:
			newfile10.write(line[0]+'\n')
		elif float(line[2]) <= 500:
			newfile11.write(line[0]+'\n')
		else:
			newfile12.write(line[0]+'\n')
		counter+=1
	elif len(line[0]) == 12:
		if float(line[2]) <=50:
			newfile13.write(line[0]+'\n')
		elif float(line[2]) <= 500:
			newfile14.write(line[0]+'\n')
		else:
			newfile15.write(line[0]+'\n')
		counter+=1

	
	#if counter > 10:
	#	break
	

