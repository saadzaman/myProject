// tbbtry1.cpp : Defines the entry point for the console application.
//


#include "stdafx.h"
#include "tbb/tbb.h"
#include <stdio.h>
#include <tchar.h>
#include <stdlib.h> 
#include <conio.h>
#include <stdlib.h>
#include <iostream>
#include <list>
#include <string.h>
#include <assert.h>
#include <time.h>       
#include <math.h>
#include "dirent.h"
#include <direct.h>
#include <fstream>
#include "tbb/blocked_range.h"
#include <unordered_map>


using namespace std;
using namespace tbb;

hash<string> H;


class Document
{
public:
	string DocumentName;
	list<size_t> HashOfPhrases;
	int NoOfPhrases;
};


class Result
{

public:
	string DocumentName;
	string DocumentMatchedName;
	double PercentMatched;

};

vector<Document> AllDocuments;
Result *Results;

class MatchWithDocuments {	
public:
	size_t compFile;
void operator( )( const blocked_range<size_t>& r ) const {
	vector<Document> :: iterator it2;
	for (size_t i=r.begin(); i!=r.end( ); ++i)   
		       {
				   if(AllDocuments[compFile].DocumentName != AllDocuments[i].DocumentName)
				   {
					   list<size_t> :: iterator h1;
					   list<size_t> :: iterator h2;
					   int matchedCount = 0; 
					   for( h1=AllDocuments[compFile].HashOfPhrases.begin(); h1!=AllDocuments[compFile].HashOfPhrases.end() ; ++h1)
						{ 
						   
							   for( h2=AllDocuments[i].HashOfPhrases.begin(); h2!=AllDocuments[i].HashOfPhrases.end() ; ++h2)
								 if(*h1 == *h2 )
								 matchedCount++; 
						}
					   Result res ;//= new Result;
					   res.DocumentMatchedName = AllDocuments[i].DocumentName;
					   res.DocumentName = AllDocuments[compFile].DocumentName;
					   res.PercentMatched = (float)matchedCount/AllDocuments[compFile].HashOfPhrases.size() * 100 ;
					   Results[i] = res;
				   }
				}	


}
MatchWithDocuments( size_t compFileParam ) : compFile(compFileParam)
{}
};
class DocumentToMatch {

public:
void operator( )( const blocked_range<size_t>& r ) const {
	vector<Document> :: iterator it2;
	for (size_t i=r.begin(); i!=r.end( ); ++i)
	   parallel_for(blocked_range<size_t>(0,AllDocuments.size(),1), MatchWithDocuments(i) );


}
DocumentToMatch( )
{}
};
class ReadingAndHashing {

public:
void operator( )( const blocked_range<size_t>& r ) const {
	vector<Document> :: iterator it2;
	for (size_t i=r.begin(); i!=r.end( ); ++i)
	{
		//cout<< "Reading " << AllDocuments[i].DocumentName << " " <<endl;
					char *path = new char[200];
					
					strcpy(path,"");
					strcat(path,"Files//");
					strcat(path,AllDocuments[i].DocumentName.c_str());
					strcat(path,"\0");
				   
					// Read File
						FILE* f = fopen(path, "r");
						fseek(f, 0, SEEK_END);
					    size_t size = ftell(f);
					    char* wheres = new char[size];
					    rewind(f);
					    fread(wheres, sizeof(char), size, f);
					    wheres[size-1] = '\0';
					    //Computing Hashs
						//cout<< wheres << endl;
							//Spliting File
							  char * pch;
							  pch = strtok (wheres," ,.-");
							  while (pch != NULL)
							  {
								  //cout<<pch<<endl;
								  AllDocuments[i].HashOfPhrases.push_back(H(pch));
								  AllDocuments[i].NoOfPhrases++;
								  pch = strtok (NULL, " ,.-");
							  }
						
					fclose(f);
					
	}


}
ReadingAndHashing( )
{}
};

int main( )
{ 
  
	task_scheduler_init init(1);
	// Getting Names Of All Files 
	DIR *dir;
	struct dirent *ent;
	
		if ((dir = opendir ("Files")) != NULL) 
		{
		
		  while ((ent = readdir (dir)) != NULL) 
		  {
			if(ent->d_name[0] != '.')
			  {
				  //printf ("%s\n", ent->d_name);
				  Document *newDoc = new Document ;	
				  newDoc->DocumentName = ent->d_name;
				  newDoc->NoOfPhrases = 0;
				  AllDocuments.push_back(*newDoc);
			  }
		   }
	   
		closedir (dir);
		} 
		else 
		{
		
	    cout<<"ERROR in OPENING DIRECTORY";
		
		}

		Results = new Result[AllDocuments.size()];


		// Task for Computing Hashes and Phrase Count 
		 clock_t start, end;
		 start = clock();
		 parallel_for(blocked_range<size_t>(0,AllDocuments.size(),2), ReadingAndHashing() );
		 end   = clock();

		double TimeForHashing = (float)(end -start) / CLOCKS_PER_SEC;
		// Task For Detecting Plagiarism
		
		 start = clock();
		 parallel_for(blocked_range<size_t>(0,AllDocuments.size(),1), DocumentToMatch() );
		 end   = clock();


		 double TimeForMatching =(float) (end - start) / CLOCKS_PER_SEC ;
		cout<< "TimeForHashing =  " << TimeForHashing << " TimeForMatching = " << TimeForMatching << endl << endl;
				
		for(int k=0; k < AllDocuments.size(); k++)
			 cout << "Document " << Results[k].DocumentName << " Matches " << Results[k].PercentMatched << " With " << Results[k].DocumentMatchedName <<  endl;
		  


	system("pause");
}



						