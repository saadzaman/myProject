using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ERS.DAL;

namespace ERS.BAL
{
    public class Managees
    {
        ERSRepository ersRep = new ERSRepository();

            public List<DAL.Managees> GetManageesList(int pLMID)
            {
                List<DAL.Managees> ReturnList = new List<DAL.Managees>();
                var c =  ersRep.GetManageesList(pLMID);
                       
                //Got Employee , Converting to Limited Things Required to Show At List 
                        foreach (Employee Managee in c)
                       {
                           ReturnList.Add(new DAL.Managees(Managee));
                       }
                return ReturnList;
            }

            public List<DAL.PeersWithReviews> GetPeerList(int ManageeID)
            {
                return ersRep.GetPeersWithReviewStats(ManageeID);
            }
            public bool CanConsolidate(int EmployeeID)
            {
                return ersRep.CanConsolidate(EmployeeID);
            }

    }
}
