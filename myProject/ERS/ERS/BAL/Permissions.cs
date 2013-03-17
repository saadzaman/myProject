using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ERS.DAL;

namespace ERS.BAL
{
    public class Permissions
    {
        ERSRepository ersRep = new ERSRepository();


        public bool Insert(int RoleID, int FeatureID)
        {
            Permission pm = new Permission();
            pm.FeatureID = FeatureID;
            pm.RoleID = RoleID;
            return ersRep.InsertPermission(pm);
        }
    }
}
