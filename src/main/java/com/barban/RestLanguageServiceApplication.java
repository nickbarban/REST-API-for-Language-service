package com.barban;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Import;
import org.springframework.data.rest.webmvc.config.RepositoryRestMvcConfiguration;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;

@SpringBootApplication // annotation is equivalent to using @Configuration,
						// @EnableAutoConfiguration and @ComponentScan with
						// their default attributes
//@EnableJpaRepositories // activates Spring Data JPA
@Import(RepositoryRestMvcConfiguration.class) // mports a collection of Spring
												// MVC controllers, JSON
												// converters, and other beans
												// needed to provide a RESTful
												// front end.
@EnableWebSecurity
//@PropertySource("application.properties")
public class RestLanguageServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(RestLanguageServiceApplication.class, args);
	}
}
