package com.vpms.membermanagement.repository;

import java.util.List;
import java.util.Optional;

/**
 * Demonstrates Abstraction and Polymorphism.
 * A generic interface for CRUD operations.
 */
public interface CrudRepository<T, ID> {
    List<T> findAll();
    T save(T entity);
    Optional<T> findById(ID id);
    void deleteById(ID id);
    T update(T entity);
}
