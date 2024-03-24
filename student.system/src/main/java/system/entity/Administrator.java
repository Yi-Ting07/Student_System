package system.entity;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;

@Entity
@Table(name = "administrator")
public class Administrator {
	
	@Id
	@GeneratedValue(generator = "admin_id", strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(name = "admin_id", sequenceName = "seq_admin_id", allocationSize = 1)
	@Column(name = "admin_id")
	private Integer adminId;
	
	@Column(name = "admin_name", nullable = false)
	@NotBlank
	private String adminName;
	
	@Column(name = "admin_gender", nullable = false)
	@NotBlank
	private String adminGender;
	
	@Column(name = "admin_account_no", nullable = false)
	@NotBlank
	private String adminAccountNo;
	
	@Column(name = "admin_password", nullable = false)
	@NotBlank
	private String adminPassword;
	
	@OneToMany(mappedBy = "creater", fetch = FetchType.LAZY)
	private List<Student> studentList1;
	
	@OneToMany(mappedBy = "updater", fetch = FetchType.LAZY)
	private List<Student> studentList2;
	
	@OneToMany(mappedBy = "classCreater", fetch = FetchType.LAZY)
	private List<StuClass> classList1;
	
	@OneToMany(mappedBy = "classUpdater", fetch = FetchType.LAZY)
	private List<StuClass> classList2;

	public Integer getAdminId() {
		return adminId;
	}

	public void setAdminId(Integer adminId) {
		this.adminId = adminId;
	}

	public String getAdminName() {
		return adminName;
	}

	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}

	public String getAdminGender() {
		return adminGender;
	}

	public void setAdminGender(String adminGender) {
		this.adminGender = adminGender;
	}

	public String getAdminAccountNo() {
		return adminAccountNo;
	}

	public void setAdminAccountNo(String adminAccountNo) {
		this.adminAccountNo = adminAccountNo;
	}

	public String getAdminPassword() {
		return adminPassword;
	}

	public void setAdminPassword(String adminPassword) {
		this.adminPassword = adminPassword;
	}

	public List<Student> getStudentList1() {
		return studentList1;
	}

	public void setStudentList1(List<Student> studentList1) {
		this.studentList1 = studentList1;
	}

	public List<Student> getStudentList2() {
		return studentList2;
	}

	public void setStudentList2(List<Student> studentList2) {
		this.studentList2 = studentList2;
	}

	public List<StuClass> getClassList1() {
		return classList1;
	}

	public void setClassList1(List<StuClass> classList1) {
		this.classList1 = classList1;
	}

	public List<StuClass> getClassList2() {
		return classList2;
	}

	public void setClassList2(List<StuClass> classList2) {
		this.classList2 = classList2;
	}
	
	
	


	
}
