package com.staffmanagement.dto;

public class StaffStats {
    private long total;
    private long active;
    private long offDuty;

    public StaffStats() {}

    public StaffStats(long total, long active, long offDuty) {
        this.total = total;
        this.active = active;
        this.offDuty = offDuty;
    }

    public long getTotal() { return total; }
    public void setTotal(long total) { this.total = total; }
    public long getActive() { return active; }
    public void setActive(long active) { this.active = active; }
    public long getOffDuty() { return offDuty; }
    public void setOffDuty(long offDuty) { this.offDuty = offDuty; }
}
