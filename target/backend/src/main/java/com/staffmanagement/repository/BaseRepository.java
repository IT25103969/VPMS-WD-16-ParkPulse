package com.staffmanagement.repository;

import java.util.List;
import java.util.Optional;

/**
 * Abstraction & Polymorphism: Generic repository interface renamed to BaseRepository 
 * to avoid conflict with Spring's @Repository annotation.
 */
public interface BaseRepository<T, ID> {
    List<T> findAll();
    Optional<T> findById(ID id);
    T save(T entity);
    void deleteById(ID id);
}
