package com.staffmanagement.model;

import java.io.Serializable;

/**
 * Encapsulation & Inheritance: Base class for all entities with a unique ID.
 */
public abstract class BaseEntity implements Serializable {
    private Long id;

    public BaseEntity() {}

    public BaseEntity(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}
