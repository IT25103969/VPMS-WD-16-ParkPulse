package com.vpms.membermanagement.model;

import java.io.Serializable;

/**
 * Demonstrates Abstraction and Inheritance.
 * This is an abstract base class that holds common properties for all entities.
 */
public abstract class BaseEntity implements Serializable {
    private String id;
    private String joinDate;

    public BaseEntity() {
    }

    public BaseEntity(String id, String joinDate) {
        this.id = id;
        this.joinDate = joinDate;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(String joinDate) {
        this.joinDate = joinDate;
    }
}
