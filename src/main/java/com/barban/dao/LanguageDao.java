package com.barban.dao;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import com.barban.model.Language;

@RepositoryRestResource
public interface LanguageDao extends CrudRepository<Language, Integer> {

}
