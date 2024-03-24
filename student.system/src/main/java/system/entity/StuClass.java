package system.entity;

import java.util.Date;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;

@Entity
@Table(name = "stu_class")
public class StuClass {
	
	@Id
	@GeneratedValue(generator = "sc_id", strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(name = "sc_id", sequenceName = "seq_sc_id", allocationSize = 1)
	@Column(name = "sc_id")
	private Integer scId;
	
	@Column(name = "sc_class_name", nullable = false)
	@NotBlank
	private String scClassName;
	
	@Column(name = "sc_teacher", nullable = false)
	@NotBlank
	private String scTeacher;
	
	@Column(name = "sc_create_date")
	private Date scCreateDate;
	
	@ManyToOne
	@JoinColumn(name = "fk_sc_creater_id")
	private Administrator classCreater;
	
	@Column(name = "sc_update_date")
	private Date scUpdateDate;
	
	@ManyToOne
	@JoinColumn(name = "fk_sc_updater_id")
	private Administrator classUpdater;
	
	@OneToMany(mappedBy = "stuClass", fetch = FetchType.LAZY)
	private List<Student> studentList;

	public Integer getScId() {
		return scId;
	}

	public void setScId(Integer scId) {
		this.scId = scId;
	}

	public String getScClassName() {
		return scClassName;
	}

	public void setScClassName(String scClassName) {
		this.scClassName = scClassName;
	}

	public String getScTeacher() {
		return scTeacher;
	}

	public void setScTeacher(String scTeacher) {
		this.scTeacher = scTeacher;
	}
	
	public Date getScCreateDate() {
		return scCreateDate;
	}

	public void setScCreateDate(Date scCreateDate) {
		this.scCreateDate = scCreateDate;
	}

	public Administrator getClassCreater() {
		return classCreater;
	}

	public void setClassCreater(Administrator classCreater) {
		this.classCreater = classCreater;
	}

	public Date getScUpdateDate() {
		return scUpdateDate;
	}

	public void setScUpdateDate(Date scUpdateDate) {
		this.scUpdateDate = scUpdateDate;
	}

	public Administrator getClassUpdater() {
		return classUpdater;
	}

	public void setClassUpdater(Administrator classUpdater) {
		this.classUpdater = classUpdater;
	}

	public List<Student> getStudentList() {
		return studentList;
	}

	public void setStudentList(List<Student> studentList) {
		this.studentList = studentList;
	}

	
	
	
	
	

}
