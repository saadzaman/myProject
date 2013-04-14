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
        public int AddReview(int EmpID, int LMID, int Reviewee, String feedback)
        {
            return ersRep.AddReview(EmpID, LMID, Reviewee, feedback);
        
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

        public bool InsertReviewInfo(int lCategoryID, String lComments, decimal lRating, int lReviewId)
        {
            ReviewInfo NewRevInfo = new ERS.ReviewInfo() { CategoryID = lCategoryID, Comments = lComments, Rating = (decimal)lRating, ReviewId = lReviewId };
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
        public string GetType(int ReviewID)
        {
            return ersRep.GetType(ReviewID);
        
        }

        public string GetType(int LMID, int EmpID)
        {

            return ersRep.GetType(LMID, EmpID);
        }
       
        public List<EmpWithRevInfo_Cat> GetAllReviewsOf_Peer_GivenCategory(int EmpID, int CatID)
        {

            return ersRep.GetAllReviewsOf_Peer_GivenCategory(EmpID, CatID);
        
        }

        public int GetCategoryID(string CatName)
        {

            return ersRep.GetCategoryID(CatName);
        }
    }
}
