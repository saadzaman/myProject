using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace ERS.DAL
{
    public class AdminRepository : IDisposable
    {
        private ERS_LMTEntities context = new ERS_LMTEntities();
        private bool disposedValue = false;

        public List<Allocations> GetAllAllocations()
        {
            List<Allocations> ReturnList = new List<Allocations>();
            var a = context.LMAllocations.ToList<LMAllocation>();
            var b = context.DirectorAllocations.ToList<DirectorAllocation>();
            var c = context.Peers.ToList<Peer>();

            foreach (var ListItem in a)
            {
                ReturnList.Add(new Allocations(1,ListItem.LMID,ListItem.ManageeId));
            }
           foreach (var ListItem in b)
            {
                ReturnList.Add(new Allocations(2,ListItem.DirectorID,ListItem.LMId));
            }
            foreach (var ListItem in c)
            {
                ReturnList.Add(new Allocations(3,ListItem.EmpID,ListItem.PeerID));
            }
            return ReturnList;
        }
        public List<LMAllocation> GetAllLMAllocation()
        {
            return context.LMAllocations.ToList<LMAllocation>();
        }
        public List<DirectorAllocation> GetAllDirectorAllocation()
        {
            return context.DirectorAllocations.ToList<DirectorAllocation>();
        }
        public List<CategoryWithWeightage> getCategoryWeights(int PositionID)
        {
            List<CategoryWithWeightage> ReturnList = new List<CategoryWithWeightage>();
            var Result = from a in context.ReviewCategories
                         join b in context.CategoryWeightages
                             on a.CategoryID equals b.CategoryID into c
                         from d in
                             (from o in c where o.PositionID == PositionID select o).DefaultIfEmpty()
                         where a.CategoryName != "LineManager" && a.CategoryName != "Director"
                         select new { a, d };

            foreach (var b in Result)
            {
                if (b.d != null)
                    ReturnList.Add(new CategoryWithWeightage(b.a, b.d.Weightage));
                else
                    ReturnList.Add(new CategoryWithWeightage(b.a, 0));
                              
            }
            return ReturnList;


        }
        public List<Position> GetAllPosition()
        {
            return context.Positions.ToList<Position>();
        }

        public void InsertEmployee(Employee employee)
        {

            try
            {
                context.Employees.AddObject(employee);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //Include catch blocks for specific exceptions first,
                //and handle or log the error as appropriate in each.
                //Include a generic catch block like this one last.
                throw ex;
            }
        }
        
        public void InsertLMAllocation(LMAllocation lmallocation)
        {

            try
            {
                context.LMAllocations.AddObject(lmallocation);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //Include catch blocks for specific exceptions first,
                //and handle or log the error as appropriate in each.
                //Include a generic catch block like this one last.
                throw ex;
            }
        }
        public void InsertDirectorAllocation(DirectorAllocation directorallocation)
        {

            try
            {
                context.DirectorAllocations.AddObject(directorallocation);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //Include catch blocks for specific exceptions first,
                //and handle or log the error as appropriate in each.
                //Include a generic catch block like this one last.
                throw ex;
            }
        }
        public void InsertEmployeeRole(EmployeeRole employeerole)
        {

            try
            {
                context.EmployeeRoles.AddObject(employeerole);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //Include catch blocks for specific exceptions first,
                //and handle or log the error as appropriate in each.
                //Include a generic catch block like this one last.
                throw ex;
            }
        }
        public void InsertReviewCategory(ReviewCategory reviewcategory)
        {

            try
            {
                context.ReviewCategories.AddObject(reviewcategory);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //Include catch blocks for specific exceptions first,
                //and handle or log the error as appropriate in each.
                //Include a generic catch block like this one last.
                throw ex;
            }
        }
        public void InsertCategoryWeightage(CategoryWeightage categoryweightage)
        {

            try
            {
                context.CategoryWeightages.AddObject(categoryweightage);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //Include catch blocks for specific exceptions first,
                //and handle or log the error as appropriate in each.
                //Include a generic catch block like this one last.
                throw ex;
            }
        }
        public void InsertCategoryWeightage(List<CategoryWeightage> ParamList)
        {
            try
            {
                foreach (CategoryWeightage categoryweightage in ParamList)
                {
                    CategoryWeightage cw = (from a in context.CategoryWeightages where a.CategoryID == categoryweightage.CategoryID 
                                               && a.PositionID == categoryweightage.PositionID  select a ).DefaultIfEmpty(null).First();

                    if (cw == null)
                    {
                        context.CategoryWeightages.AddObject(categoryweightage);
                        context.SaveChanges();
                    }
                    else
                    {
                        context.CategoryWeightages.Attach(cw);
                        cw.Weightage = categoryweightage.Weightage;
                        context.ApplyCurrentValues("CategoryWeightages", cw);
                        context.SaveChanges();

                    }
                }
                
            }
            catch (Exception ex)
            {
                //Include catch blocks for specific exceptions first,
                //and handle or log the error as appropriate in each.
                //Include a generic catch block like this one last.
                throw ex;
            }
        }
        public void InsertPosition(Position position)
        {

            try
            {
                context.Positions.AddObject(position);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //Include catch blocks for specific exceptions first,
                //and handle or log the error as appropriate in each.
                //Include a generic catch block like this one last.
                throw ex;
            }
        }
        public void InsertPeers(Peer peer)
        {

            try
            {
                context.Peers.AddObject(peer);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //Include catch blocks for specific exceptions first,
                //and handle or log the error as appropriate in each.
                //Include a generic catch block like this one last.
                throw ex;
            }
        }

        public void DeleteEmployee(int employeeid)
        {

            try
            {
                Employee employee = new Employee() { EmpID = employeeid };
                context.Employees.Attach(employee);
                context.Employees.DeleteObject(employee);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //Include catch blocks for specific exceptions first,
                //and handle or log the error as appropriate in each.
                //Include a generic catch block like this one last.
                throw ex;
            }
        }
        public void DeleteLMAllocation(int employeeid, int lmid)
        {

            try
            {
                LMAllocation lmallocation = new LMAllocation() { LMID = lmid, ManageeId = employeeid };
                context.LMAllocations.DeleteObject(lmallocation);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //Include catch blocks for specific exceptions first,
                //and handle or log the error as appropriate in each.
                //Include a generic catch block like this one last.
                throw ex;
            }
        }
        public void DeleteDirectorAllocation(int LMID, int DirectorID)
        {

            try
            {
                DirectorAllocation directorallocation = new DirectorAllocation() { DirectorID=DirectorID, LMId=LMID};
                context.DirectorAllocations.DeleteObject(directorallocation);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //Include catch blocks for specific exceptions first,
                //and handle or log the error as appropriate in each.
                //Include a generic catch block like this one last.
                throw ex;
            }
        }
        public void DeleteEmployeeRole(int EmpID, int RoleID)
        {

            try
            {
                EmployeeRole employeerole = new EmployeeRole() { EmpID=EmpID, RoleID= RoleID};
                context.EmployeeRoles.DeleteObject(employeerole);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //Include catch blocks for specific exceptions first,
                //and handle or log the error as appropriate in each.
                //Include a generic catch block like this one last.
                throw ex;
            }
        }
        public void DeleteReviewCategory(int CategoryID)
        {

            try
            {
                ReviewCategory reviewcategory =new ReviewCategory(){ CategoryID = CategoryID};
                context.ReviewCategories.DeleteObject(reviewcategory);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //Include catch blocks for specific exceptions first,
                //and handle or log the error as appropriate in each.
                //Include a generic catch block like this one last.
                throw ex;
            }
        }
        public void DeleteCategoryWeightage(int categoryid, int positionid)
        {

            try
            {
                CategoryWeightage categoryweightage = (from a in context.CategoryWeightages where a.PositionID == positionid && a.CategoryID == categoryid select a).First();
                context.CategoryWeightages.DeleteObject(categoryweightage);
                context.SaveChanges();
                
            }
            catch (Exception ex)
            {
                //Include catch blocks for specific exceptions first,
                //and handle or log the error as appropriate in each.
                //Include a generic catch block like this one last.
                throw ex;
            }
        }
        public void DeletePosition(int positionid)
        {

            try
            {
                Position position = new Position() { PositionID = positionid };
                context.Positions.DeleteObject(position);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //Include catch blocks for specific exceptions first,
                //and handle or log the error as appropriate in each.
                //Include a generic catch block like this one last.
                throw ex;
            }
        }
        public void DeletePeers(int peerID)
        {

            try
            {
                Peer peer = new Peer() { PeerID = peerID };
                context.Peers.DeleteObject(peer);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //Include catch blocks for specific exceptions first,
                //and handle or log the error as appropriate in each.
                //Include a generic catch block like this one last.
                throw ex;
            }
        }
        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    context.Dispose();
                }
            }
            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public List<Employee> GetAllEmployees()
        {
            return context.Employees.ToList();
        }
    }

}
