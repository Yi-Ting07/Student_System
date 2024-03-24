package system.vo;

import java.util.List;

public class StuQueryPageForm {
	
	private StuQuery query;
	private List<StuSearchResult> stuSearchResultList;
	private String[] deleteStudentIds;

	public StuQuery getQuery() {
		return query;
	}

	public void setQuery(StuQuery query) {
		this.query = query;
	}

	public List<StuSearchResult> getStuSearchResultList() {
		return stuSearchResultList;
	}

	public void setStuSearchResultList(List<StuSearchResult> stuSearchResultList) {
		this.stuSearchResultList = stuSearchResultList;
	}

	public String[] getDeleteStudentIds() {
		return deleteStudentIds;
	}

	public void setDeleteStudentIds(String[] deleteStudentIds) {
		this.deleteStudentIds = deleteStudentIds;
	}
	
	
	
	

}
