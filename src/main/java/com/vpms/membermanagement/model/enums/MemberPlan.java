package com.vpms.membermanagement.model.enums;

import com.fasterxml.jackson.annotation.JsonCreator;

public enum MemberPlan {
    MONTHLY(1500),
    QUARTERLY(4000),
    ANNUAL(15000);

    private final double price;

    MemberPlan(double price) {
        this.price = price;
    }

    public double getPrice() {
        return price;
    }

    @JsonCreator
    public static MemberPlan fromString(String value) {
        return MemberPlan.valueOf(value.toUpperCase());
    }
}
