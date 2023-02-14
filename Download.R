
#Title: Download
#Author: Jeremie Alexander
#Date: February 15th, 2023
#Description:



#Install rentrez package
install.packages("rentrez")

#Create vector of characters to represent NCBI IDs for each sequence
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")

#Load rentrez package
library(rentrez)

#Download sequence files from the NCBI database nuccore (db = "nuccore"). These records will be represented by the IDs
#in the character vector ncbi_ids (id = ncbi_ids). Finally, imported data will be in fasta format (rettype = 'fasta') 
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")
Bburg

#Split the inputted data into each individual sequence ID 
Sequences = strsplit(Bburg,split = "\n\n")
Sequences

#Convert sequences list item to a dataframe
Sequences=unlist(Sequences)
Sequences

#Use Regex to seperate sequencing data from descriptive headers
header=gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
seq=gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)
Sequences=data.frame(Name=header,Sequence=seq)
Sequences

#Remove the newline characters from the Sequences data frame using Regex
Sequences$Sequence=gsub("\n", "", Sequences$Sequence)
Sequences

#Output this data frame to a file called Sequences.csv
write.csv(Sequences, "~/Documents/BIOL_432/Week_6/Assignment/Rentrez/Sequences.csv", row.names = T)



