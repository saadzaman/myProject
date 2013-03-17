using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ERS.DAL
{
    public  class Managees
    {
           public String EmployeeName { get; set; }   
           public String Designation { get; set; }
           public String Email { get; set; }
           public String EmployeeStatus { get; set; }
           public int EmpID { get; set; }

           public Managees(Employee e)
        {
            EmpID = e.EmpID;
           EmployeeName = e.Name;
           Designation = e.Position.PositionName.ToString();
           Email = e.Email;
           EmployeeStatus = (e.EmployeeStatus.Value == true )?"Active":"UnActive";
        }
    }
}
