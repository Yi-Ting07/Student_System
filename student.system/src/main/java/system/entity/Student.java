package system.entity;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;

/**
 *  
 */
@Entity
@Table(name = "student")
public class Student {
	
	@Id
	@GeneratedValue(generator = "stu_id", strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(name = "stu_id", sequenceName = "seq_stu_id", allocationSize = 1)
	@Column(name = "stu_id")
	private Integer stuId;
	
	@Column(name = "stu_name", nullable = false)
	@NotBlank
	private String stuName;
	
	@Column(name = "stu_no", unique = true, nullable = false)
	@NotBlank
	private String stuNo;
	
	@Column(name = "stu_gender", nullable = false)
	@NotBlank
	private String stuGender;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "fk_stu_class_id", nullable = false)
	private StuClass stuClass;
	
	@Column(name = "stu_create_date")
	private Date stuCreateDate;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "fk_stu_creater_id")
	private Administrator creater;
	
	@Column(name = "stu_update_date")
	private Date stuUpdateDate;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "fk_stu_updater_id")
	private Administrator updater;

	public Integer getStuId() {
		return stuId;
	}

	public void setStuId(Integer stuId) {
		this.stuId = stuId;
	}

	public String getStuName() {
		return stuName;
	}

	public void setStuName(String stuName) {
		this.stuName = stuName;
	}

	public String getStuNo() {
		return stuNo;
	}

	public void setStuNo(String stuNo) {
		this.stuNo = stuNo;
	}

	public String getStuGender() {
		return stuGender;
	}

	public void setStuGender(String stuGender) {
		this.stuGender = stuGender;
	}

	public StuClass getStuClass() {
		return stuClass;
	}

	public void setStuClass(StuClass stuClass) {
		this.stuClass = stuClass;
	}

	public Date getStuCreateDate() {
		return stuCreateDate;
	}

	public void setStuCreateDate(Date stuCreateDate) {
		this.stuCreateDate = stuCreateDate;
	}

	public Administrator getCreater() {
		return creater;
	}

	public void setCreater(Administrator creater) {
		this.creater = creater;
	}

	public Date getStuUpdateDate() {
		return stuUpdateDate;
	}

	public void setStuUpdateDate(Date stuUpdateDate) {
		this.stuUpdateDate = stuUpdateDate;
	}

	public Administrator getUpdater() {
		return updater;
	}

	public void setUpdater(Administrator updater) {
		this.updater = updater;
	}

	
	




}
