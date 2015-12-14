package com.barban.dao;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import com.barban.model.User;

@RepositoryRestResource
public interface UserDao extends CrudRepository<User, Integer> {

}
