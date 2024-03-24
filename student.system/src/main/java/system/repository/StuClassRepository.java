package system.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import system.entity.StuClass;

@Repository
public interface StuClassRepository extends JpaRepository<StuClass, Integer>{

}
