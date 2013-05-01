using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ERS.DAL
{
    public class PeersWithReviews
    {
        public int ReviewID { get; set; }
        public String Status { get; set; }
        public String EmployeeName { get; set; }
        public String Designation { get; set; }
        public String Email { get; set; }
        public String EmployeeStatus { get; set; }
        public int PeerID { get; set; }
        public int ImPeerOfID { get; set; }
     

        public PeersWithReviews(int ParamReviewID , String ParamStatus , Employee e ,int ManageeID)
        {
            ReviewID = ParamReviewID;
            Status = ParamStatus;
            PeerID = e.EmpID;
            EmployeeName = e.Name;
            Designation = e.Position.PositionName.ToString();
            Email = e.Email;
            EmployeeStatus = (e.EmployeeStatus.Value == true) ? "Active" : "UnActive";
            ImPeerOfID = ManageeID;
            
        }
    }
}
