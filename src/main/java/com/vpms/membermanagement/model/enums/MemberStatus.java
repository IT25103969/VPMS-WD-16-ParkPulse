package com.vpms.membermanagement.model.enums;

import com.fasterxml.jackson.annotation.JsonCreator;

public enum MemberStatus {
    ACTIVE,
    INACTIVE,
    SUSPENDED;

    @JsonCreator
    public static MemberStatus fromString(String value) {
        return MemberStatus.valueOf(value.toUpperCase());
    }
}
