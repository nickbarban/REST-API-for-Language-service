package com.barban.dao;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import com.barban.model.Course;

@RepositoryRestResource
public interface CourseDao extends CrudRepository<Course, Integer> {

}
