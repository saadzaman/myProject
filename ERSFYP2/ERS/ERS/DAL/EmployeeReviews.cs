using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ERS.DAL
{
    public class EmployeeReviews
    {
           public String EmployeeName { get; set; }   
           public String LineManager { get; set; } 
           public DateTime Deadline { get; set; }
           public String Type { get; set; }
           public String Feedback { get; set; }
           public String Status { get; set; }
           public int ReviewID { get; set; }
           public Employee CurrEmployee { get; set; } 
           public Review CurrReview { get; set; } 

           public EmployeeReviews(Employee pCurrEmployee,Review pCurrReview,int pID,String pEmployeeName, String pLineManager, DateTime pDeadline, String pType, String pFeedback,String pStatus)
        {
            ReviewID = pID;
           EmployeeName = pEmployeeName;
           LineManager = pLineManager;
           Deadline = pDeadline;
           Type = pType;
           Status = pStatus ;
           Feedback = pFeedback;
           CurrEmployee = pCurrEmployee;
           CurrReview = pCurrReview;
        }
    }
}
