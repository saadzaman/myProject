using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ERS.DAL;
namespace ERS.BAL
{
    public class Director
    {
        ERSRepository ersRep = new ERSRepository();
        public List<LineManagersWithDirector> GetLineManagers(int pDirectorID)
        {
            return ersRep.GetLineManagers(pDirectorID);
        }


        public List<Employee> GetManagees(int LMID)
        {
            return ersRep.GetManageesList(LMID);
        }

        public bool AreReviewPending(int LMID)
        {
            return ersRep.AreReviewsPending(LMID);
        
        }
    }
}
