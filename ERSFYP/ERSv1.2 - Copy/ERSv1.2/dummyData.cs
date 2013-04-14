using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ERSv1._2
{

    public class Category
    {
        public String NameId { get; set; }
        // public String NameText { get; set; }
        public String CommentId { get; set; }
        // public String CommentText { get; set; }
        public String RatingId { get; set; }
        /* public String RatingText { get; set; }*/

        public Category(String Name)
        {
            NameId = Name;
            CommentId = Name + "Comment";
            RatingId = Name + "Rating";

        }
    }

    public class dummyData
    {
        public String Name { get; set; }

        public String Comment { get; set; }

        public Double Rating { get; set; }

        public String Status { get; set; }

        public String ID2 { get; set; }
        
        public dummyData(String n,String c,Double r)
        {
            Name = n;
            Comment = c;
            Rating = r;
        }

        public dummyData(String n, String c, Double r, String s , String i)
        {
            Name = n;
            Comment = c;
            Rating = r;
            Status = s;
            ID2 = i;
        }
    }


    public class Review
    {
        public String Employee { get; set; }
        public String ID { get; set; }
        public String LineManager { get; set; }
        public DateTime Deadline { get; set; }
        public String Type { get; set; }
        public String Feedback { get; set; }
        public List<dummyData> myListCheck { get; set; }
        public bool isReady { get; set; }

        public Review(String idp, String Emp, String pLineManager, DateTime pDeadline, String pType, String pFeedback)
        {
            ID = idp;
            Employee = Emp;
            LineManager = pLineManager;
            Deadline = pDeadline;
            Type = pType;
            Feedback = pFeedback;
            myListCheck = new List<dummyData>();
            myListCheck.Add(new dummyData("asdasd dasdasd","b",1,"Pending","1"));

            myListCheck.Add(new dummyData("asdsdsd dsds", "b", 1,"Completed","2"));

            myListCheck.Add(new dummyData("adsd dssd", "b", 1,"Pending","3"));
        }


        public Review(String idp, String Emp, String pLineManager, DateTime pDeadline, String pType, String pFeedback,bool iss)
        {
            ID = idp;
            Employee = Emp;
            LineManager = pLineManager;
            Deadline = pDeadline;
            Type = pType;
            Feedback = pFeedback;
            isReady = iss;
            myListCheck = new List<dummyData>();
            myListCheck.Add(new dummyData("asdasd dasdasd", "b", 1, "Pending", "1"));

            myListCheck.Add(new dummyData("asdsdsd dsds", "b", 1, "Completed", "2"));

            myListCheck.Add(new dummyData("adsd dssd", "b", 1, "Pending", "3"));
        }



    }


   
}