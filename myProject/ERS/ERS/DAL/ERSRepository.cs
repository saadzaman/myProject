using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace ERS.DAL
{
    public  class ERSRepository : IDisposable
    {
        private ERS_LMTEntities context = new ERS_LMTEntities();

        public ReviewInfo GetReviewInfo(int pReviewID, int pCategoryID)
        {

            return (from a in context.ReviewInfoes
                    where (a.ReviewId == pReviewID && a.CategoryID == pCategoryID)
                    select a).ToList<ReviewInfo>()[0];

        
        }

        public int GetUserID(string email)
        {
            int result = (from a in context.Employees
                         where a.Email == email
                         select a.EmpID).FirstOrDefault();
            return result;
        }
        public List<EmployeeReviews> GetMyReviews(int ParamEmpId)
        {
            List<EmployeeReviews> ReturnList = new List<EmployeeReviews>();
            var Result = from a in context.Reviews
                         where a.ReviewerID == ParamEmpId
                         select new
                         {
                             ID = a.ReviewId,
                             EmployeeName = a.Employee.Name,
                             LineManager = a.Employee1.Name,
                             Deadline = a.Date,
                             Type = a.ReviewType.TypeName,
                             Feedback = a.feedback,
                             Status = a.Status,
                             Employee = a.Employee,
                             Review = a
                         };
            //IMPROVE THIS BHAND LATER

            foreach (var b in Result)
            {

                ReturnList.Add(new EmployeeReviews(b.Employee, b.Review ,b.ID, b.EmployeeName, b.LineManager, (DateTime)b.Deadline, b.Type, b.Feedback, (Int32)b.Status));
            }

            return ReturnList;

        }
     

       public  bool InsertReview(Review ParamReview)
        {

            try
            {
               
                ParamReview.ReviewId = GenerateReviewID();
                context.Reviews.AddObject(ParamReview);
                context.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                
                //Include catch blocks for specific exceptions first,
                //and handle or log the error as appropriate in each.
                //Include a generic catch block like this one last.
                throw ex;
                return false;
            }


        }

       public bool InsertFeature(Feature ParamFeature)
       {
           try
           {
               context.Features.AddObject(ParamFeature);
               context.SaveChanges();
               return true;
           }
           catch (Exception)
           {

               //Include catch blocks for specific exceptions first,
               //and handle or log the error as appropriate in each.
               //Include a generic catch block like this one last.
               return false;
           }
       }

       public bool InsertPermission(Permission ParamPermission)
       {
           try
           {
               context.Permissions.AddObject(ParamPermission);
               context.SaveChanges();
               return true;
           }
           catch (Exception)
           {

               //Include catch blocks for specific exceptions first,
               //and handle or log the error as appropriate in each.
               //Include a generic catch block like this one last.
               return false;
           }
       }
       public bool isAllowed(int FeatureID, int EmployeeID)
       {
           var q = (from c in context.Permissions
                    join d in
                        ((from a in context.Employees
                          join b in context.EmployeeRoles on a.EmpID equals b.EmpID
                          where a.EmpID == EmployeeID
                          select new { RoleID = b.RoleID }).Distinct()) on c.RoleID equals d.RoleID
                    where c.FeatureID == FeatureID
                    select c.Feature).Count();
           if (q > 0)
               return true;
           else
           {
               return false;
           }
          
       }

       public bool CanConsolidate(int EmployeeID)
       {
           return (from a in context.Reviews
                   where a.EmpID == EmployeeID && a.Status == 1
                   select a).Count() == (from b in context.Peers where b.EmpID == EmployeeID select b).Count();
       }

       public bool UpdateReviewStatus(int ReviewID)
       {
           try
           {
               Review Orignal = (from a in context.Reviews where a.ReviewId == ReviewID select a).ToList<Review>()[0];
               context.Reviews.Attach(Orignal);
               Orignal.Status = 1;
               context.ApplyCurrentValues("Reviews", Orignal);
               context.SaveChanges();
               return true;
           }
           catch (Exception ex)
           {
               //Include catch blocks for specific exceptions first,
               //and handle or log the error as appropriate in each.
               //Include a generic catch block like this one last.
               throw ex;
               return false;
           }

       }

       public List<Employee> GetManageesList(int LMID)
       {
           return (from a in context.LMAllocations
                  where a.LMID == LMID
                  select a.Employee1).ToList<Employee>();
       
       }


       public List<PeersWithReviews> GetPeersWithReviewStats(int pManageeID)
       {

           List<PeersWithReviews> ReturnList = new List<PeersWithReviews>();
           var Result = from a in context.Peers
                        where a.EmpID == pManageeID
                        join b in context.Reviews on a.PeerID equals b.ReviewerID into b_join
                        from b in b_join.DefaultIfEmpty()
                        select new
                        {
                            Employee = a.Employee1,
                            ReviewId = (System.Int32?)b.ReviewId,
                            ReviewStatus = (System.Int32?)b.Status
                        };

           foreach (var b in Result)
           {
               if(b.ReviewId !=null)
               ReturnList.Add(new PeersWithReviews((Int32)b.ReviewId, b.ReviewStatus.ToString(), b.Employee , pManageeID));
               else
                   ReturnList.Add(new PeersWithReviews(0, "0", b.Employee ,pManageeID));

           }

           return ReturnList;

       }

       public List<EmpWithRevInfo_Cat> GetAllReviewsOf_Peer_GivenCategory(int EmpID, int CatID)
       {
           List<EmpWithRevInfo_Cat> ReturnList = new List<EmpWithRevInfo_Cat>();
           var Result = from a in context.ReviewInfoes
                        where a.CategoryID == CatID
                        join b in context.Reviews on a.ReviewId equals b.ReviewId
                        where b.EmpID == EmpID
                        select a;

           foreach (var b in Result)
           {

               ReturnList.Add(new EmpWithRevInfo_Cat(b,b.Review.Employee2));
           }

           return ReturnList;
       }

       private Int32 GenerateReviewID()
       {
           Int32 maxDepartmentID = 0;
           var department = (from d in context.Reviews
                             orderby d.ReviewId descending
                             select d).FirstOrDefault();
           if (department != null)
           {
               maxDepartmentID = department.ReviewId + 1;
           }
           return maxDepartmentID;
       }



       public List<ReviewCategory> GetCategories()
       {
           return (from a in context.ReviewCategories select a).ToList<ReviewCategory>();
       }

       public EmployeeWithLM GetEmployee(int pEmpID)
       {

           var a = (from b in context.Employees
                    join c in context.LMAllocations on b.EmpID equals c.ManageeId
                    where b.EmpID == pEmpID
                    select new
                    {
                        Employee = b,
                        LineManager = c.Employee
                    });
           foreach (var va in a )
                  return new EmployeeWithLM(va.Employee, va.LineManager);
           return null;
               
       }



       public bool InsertMultipleReviewInfo(List<ReviewInfo> Infoes)
       {

           try
           {
               foreach (ReviewInfo r in Infoes)
               {
                  
                   if (context.ReviewInfoes.Any(e => (e.ReviewId == r.ReviewId && e.CategoryID == r.CategoryID) ))
                   {
                       context.ReviewInfoes.Attach(r);
                       context.ObjectStateManager.ChangeObjectState(r, EntityState.Modified);
                   }
                   else
                   {
                       context.ReviewInfoes.AddObject(r);
                   }

                           
               }
               context.SaveChanges();
               return true;
           }
           catch (Exception ex)
           {

               //Include catch blocks for specific exceptions first,
               //and handle or log the error as appropriate in each.
               //Include a generic catch block like this one last.
               throw ex;
               return false;
           }

       
       }




       private bool disposedValue = false;

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

       
    }

}
