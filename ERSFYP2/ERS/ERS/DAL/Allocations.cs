using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ERS.DAL
{
    [Serializable]
    public class Allocations
    {
            public int TypeID = 1;
            public int EmpFirstID = 1;
            public int EmpSecondID = 1;
            public bool changed = false;
            public Allocations(int Type, int EmpId, int EmpId2)
            {
                TypeID = Type;
                EmpFirstID = EmpId;
                EmpSecondID = EmpId2;
                
            }
    }
}
