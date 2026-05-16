package com.vpms.membermanagement.model;

import java.util.Map;

/**
 * Data Transfer Object (DTO) for Member Statistics.
 * Demonstrates Encapsulation by providing a structured container for calculated data.
 */
public class MemberStats {
    private long totalMembers;
    private long activeMembers;
    private long inactiveMembers;
    private long suspendedMembers;
    private long newThisMonth;
    private double monthlyRevenue;
    private int retentionRate;
    private Map<String, Long> planDistribution;

    public MemberStats() {
    }

    public MemberStats(long totalMembers, long activeMembers, long inactiveMembers, long suspendedMembers, long newThisMonth, double monthlyRevenue, int retentionRate, Map<String, Long> planDistribution) {
        this.totalMembers = totalMembers;
        this.activeMembers = activeMembers;
        this.inactiveMembers = inactiveMembers;
        this.suspendedMembers = suspendedMembers;
        this.newThisMonth = newThisMonth;
        this.monthlyRevenue = monthlyRevenue;
        this.retentionRate = retentionRate;
        this.planDistribution = planDistribution;
    }

    public long getTotalMembers() { return totalMembers; }
    public void setTotalMembers(long totalMembers) { this.totalMembers = totalMembers; }
    public long getActiveMembers() { return activeMembers; }
    public void setActiveMembers(long activeMembers) { this.activeMembers = activeMembers; }
    public long getInactiveMembers() { return inactiveMembers; }
    public void setInactiveMembers(long inactiveMembers) { this.inactiveMembers = inactiveMembers; }
    public long getSuspendedMembers() { return suspendedMembers; }
    public void setSuspendedMembers(long suspendedMembers) { this.suspendedMembers = suspendedMembers; }
    public long getNewThisMonth() { return newThisMonth; }
    public void setNewThisMonth(long newThisMonth) { this.newThisMonth = newThisMonth; }
    public double getMonthlyRevenue() { return monthlyRevenue; }
    public void setMonthlyRevenue(double monthlyRevenue) { this.monthlyRevenue = monthlyRevenue; }
    public int getRetentionRate() { return retentionRate; }
    public void setRetentionRate(int retentionRate) { this.retentionRate = retentionRate; }
    public Map<String, Long> getPlanDistribution() { return planDistribution; }
    public void setPlanDistribution(Map<String, Long> planDistribution) { this.planDistribution = planDistribution; }
}
