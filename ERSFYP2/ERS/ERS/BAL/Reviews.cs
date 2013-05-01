using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ERS.DAL;
namespace ERS.BAL
{
    public class Reviews
    {
        ERSRepository ersRep = new ERSRepository();


        public List<EmployeeReviews>  GetReviewsList( int EmpID )
        {
            return ersRep.GetMyReviews(EmpID);
        }

        public bool RejectReview(int ReviewID ,int RejectedBy)
        {

            return ersRep.RejectReview(ReviewID ,RejectedBy);
        
        }

        public bool RejectReview(int ReviewID ,string Feedback , int RejectedBy)
        {
            if (Feedback.Length != 0)
                return ersRep.RejectReview(ReviewID, Feedback, RejectedBy);
            else
                return ersRep.RejectReview(ReviewID, RejectedBy);

        }
        public List<ReviewCategory> GetCategories()
        {
            return ersRep.GetCategories();
        }

        public List<ReviewCategory> GetAllCategories()
        {
            return ersRep.GetAllCategories();
        }


        public EmployeeWithLM GetEmployee(int EmpID)
        {
            return ersRep.GetEmployee(EmpID);
        }

        public EmployeeWithLM GetEmployeeFromReview(int ReviewID)
        {
            return ersRep.GetEmployeeFromReview(ReviewID);
        }
        public bool isLMOfReview(int UserID, int ReviewID)
        {
            return ersRep.isLMOfReview(UserID, ReviewID);
        
        }
        public int AddReview(int EmpID, int LMID, int Reviewee, String feedback , String Type)
        {
            return ersRep.AddReview(EmpID, LMID, Reviewee, feedback , Type);
        
        }
        public int CreateReviewForConsolidate(int EmpID, int LMID)
        {
            return ersRep.CreateReviewForConsolidate(EmpID, LMID);
        }

        public bool isEmpOfReview(int UserID, int ReviewID)
        {

            return ersRep.isEmpOfReview(UserID, ReviewID);
        }
        public bool FillReviews( int ReviewID , List<ReviewInfo> Infoes , string Type )
        {


            if (ersRep.InsertMultipleReviewInfo(Infoes))
            {
                if (Type == "Completed")
                ersRep.UpdateReviewStatus(ReviewID,"Completed");
                else if (Type == "Consolidated")
                ersRep.UpdateReviewStatus(ReviewID, "Consolidated");
                else
                ersRep.UpdateReviewStatus(ReviewID,"Drafted");
                return true;
            } return false;
        }

        public int GetReviewID(int LMID, int ReviewerID, int EmpID)
        {
            return ersRep.GetReviewID(LMID, ReviewerID, EmpID);
        
        }

        public int GetAReviewID(int ReviewID)
        {
            return ersRep.GetAReviewID(ReviewID);

        }

        public bool InsertReviewInfo(int lCategoryID, String lComments, decimal lRating, int lReviewId)
        {

            ReviewInfo NewRevInfo = new ERS.ReviewInfo() { CategoryID = lCategoryID, Comments = lComments, Rating = (decimal)lRating, ReviewId = GetAReviewID(lReviewId) };
            return ersRep.InsertReviewInfo(NewRevInfo); 
        }
        public ReviewInfo GetReviewInfo(int pReviewID, int pCategoryID)
        {

            return ersRep.GetReviewInfo(pReviewID, pCategoryID);
        }

        public bool isDraft(int ReviewID)
        {

            return ersRep.isReviewDraft(ReviewID);
        
        }
        public string GetStatus(int ReviewID)
        {
            return ersRep.GetStatus(ReviewID);
        
        }

        public string GetStatus(int LMID, int EmpID)
        {

            return ersRep.GetStatus(LMID, EmpID);
        }

        public string GetType(int ReviewID)
        {

            return ersRep.GetType(ReviewID);
        }
       
        public List<EmpWithRevInfo_Cat> GetAllReviewsOf_Peer_GivenCategory(int EmpID, int CatID)
        {

            return ersRep.GetAllReviewsOf_Peer_GivenCategory(EmpID, CatID);
        
        }

        public int GetCategoryID(string CatName)
        {

            return ersRep.GetCategoryID(CatName);
        }

        public int GetLatestReviewID(int LMID, int EmpID)
        {
            return ersRep.GetLatestReviewID(LMID, EmpID);
        
        }

        public bool isLMSConsolidation(int ReviewID)
        {

            return ersRep.isLMSConsolidation(ReviewID);


        }
            public List<Employee> GetAllEmployees()
        {

            return ersRep.GetAllEmployees();
        
        }
    }
}
