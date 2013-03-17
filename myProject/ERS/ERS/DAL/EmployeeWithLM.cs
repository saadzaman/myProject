using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ERS.DAL
{
    public class EmployeeWithLM
    {
        public Employee CurrEmployee { get; set; }
        public Employee CurrEmployeeLM { get; set; }

        public EmployeeWithLM(Employee pCurrEmployee, Employee pCurrEmployeeLM)
        {
            CurrEmployee = pCurrEmployee;
            CurrEmployeeLM = pCurrEmployeeLM;
        }
    }

    
}
