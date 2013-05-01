using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ERS.DAL;
namespace ERS.BAL
{
    public class Admin
    {

        AdminRepository adminrep = new AdminRepository();
        public List<Allocations> GetAllAllocations()
        {
            return adminrep.GetAllAllocations();
        }

        public void InsertCategoryWeightages(List<CategoryWeightage> list)
        {
           adminrep.InsertCategoryWeightage(list);
        }
        
        /// <summary>
        /// Type = "LM", "Director", "Peer"
        /// </summary>
        /// <param name="ID1"></param>
        /// <param name="ID2"></param>
        /// <param name="type"></param>
        public void InsertRelation(int ID1, int ID2, string type)
        {
            if(type == "LM")
                adminrep.InsertLMAllocation(new LMAllocation(){ManageeId= ID1, LMID=ID2, DateOfAllocation=DateTime.Now, IsActive=true}); 
            else if(type == "Director")
                adminrep.InsertDirectorAllocation(new DirectorAllocation(){LMId=ID1, DirectorID=ID2,DateOfAllocation=DateTime.Now,IsActive=true});
            else if(type=="Peer")
                adminrep.InsertPeers(new Peer(){EmpID=ID1, PeerID=ID2, IsActive=true});
            
            
        }
        public List<Position> GetAllPosition()
        {
            return adminrep.GetAllPosition();
        }
        public List<CategoryWithWeightage> getCategoryWeights(int PositionID)
        {
            return adminrep.getCategoryWeights(PositionID);
        }
        public List<Employee> GetAllEmployees()
        {
           return adminrep.GetAllEmployees();
        }

    }
}
