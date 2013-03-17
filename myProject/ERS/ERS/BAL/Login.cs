using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ERS.DAL;


namespace ERS.BAL
{
    public class Login
    {
        ERSRepository ersRep = new ERSRepository();

        public Employee GetUserID(string email)
        {
            return ersRep.GetUserID(email);
        }

        public bool isLM(int EmpID)
        {

            return ersRep.isLM(EmpID);
        
        }
    }
}
