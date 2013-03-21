// tbbtry1.cpp : Defines the entry point for the console application.
//

#include "stdafx.h" /*
#include "tbb/tbb.h"
#include <iostream>
#include <list>
#include <string.h>
#include <assert.h>
#include "dirent.h"
#include <direct.h>
#include <fstream>
#include <time.h>       
#include <math.h>       


using namespace std;
using namespace tbb;
 #include <unordered_map>

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
int varLoop = 0;
int main( )
{ 
   //task_scheduler_init init(task_scheduler_init::automatic);
   // first_task& f1 = *new(tbb::task::allocate_root()) first_task( );
   // tbb::task::spawn_root_and_wait(f1);
	//system("pause");
	
	list<Document> AllDocuments;
	Result *Results;
	// Getting Names Of All Files 
	DIR *dir;
	struct dirent *ent;
	
		if ((dir = opendir ("Files")) != NULL) 
		{
		
		  while ((ent = readdir (dir)) != NULL) 
		  {
			if(ent->d_name[0] != '.')
			  {
				//  printf ("%s\n", ent->d_name);
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
		clock_t start, end;
		start = clock();
		// Task for Computing Hashes and Phrase Count 
		list<Document>::iterator it;
		list<Document>::iterator it2;

		 for (it=AllDocuments.begin(); it!=AllDocuments.end(); ++it)
			    {
				//	cout<< "Reading " << it->DocumentName << " " <<endl;
					char *path = new char[200];
					
					strcpy(path,"");
					strcat(path,"Files//");
					strcat(path,it->DocumentName.c_str());
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
								//  cout<<pch<<endl;
								  it->HashOfPhrases.push_back(H(pch));
								  it->NoOfPhrases++;
								pch = strtok (NULL, " ,.-");
							  }
						
					fclose(f);
						

		 }
		 end = clock();
		  double TimeForHashing =(float) (end - start) / CLOCKS_PER_SEC ;
		 
		 start = clock();

		// Task For Detecting Plagiarism
		  for (it=AllDocuments.begin() ; it!=AllDocuments.end(); ++it)
		{	for (it2=AllDocuments.begin() ; it2!=AllDocuments.end(); ++it2)	    
		       {
				   if(it != it2)
				{  list<size_t> :: iterator h1;
				   list<size_t> :: iterator h2;
				   int matchedCount = 0; 
				   for( h1=it->HashOfPhrases.begin(); h1!=it->HashOfPhrases.end() ; ++h1)
					{ 
						   
						   for( h2=it2->HashOfPhrases.begin(); h2!=it2->HashOfPhrases.end() ; ++h2)
							 if(*h1 == *h2 )
							 matchedCount++; 
					}
				    Result res ;//= new Result;
					   res.DocumentMatchedName = it2->DocumentName;
					   res.DocumentName = it->DocumentName;
					   res.PercentMatched = (float)matchedCount/it->HashOfPhrases.size() * 100 ;
					   Results[varLoop] = res;
					  
				}	//   cout<< "Document " << it->DocumentName <<" Matches "<< (float)matchedCount/it->HashOfPhrases.size() * 100 << "% with Document "<< it2->DocumentName <<endl;
		       }		
			 varLoop++;
	}
		  
	end = clock();
		 double TimeForMatching =(float) (end - start) / CLOCKS_PER_SEC ;
		cout<< "TimeForHashing =  " << TimeForHashing << " TimeForMatching = " << TimeForMatching << endl << endl;
				
		for(int k=0; k < AllDocuments.size(); k++)
			 cout << "Document " << Results[k].DocumentName << " Matches " << Results[k].PercentMatched << " With " << Results[k].DocumentMatchedName <<  endl;
		  
	system("pause");
}

						*/