package com.staffmanagement.service;

import com.staffmanagement.model.Staff;
import com.staffmanagement.dto.StaffStats;

import java.util.List;
import java.util.Optional;

/**
 * Abstraction: Service interface for staff-related operations.
 */
public interface StaffService {
    List<Staff> getAllStaff();
    List<Staff> getFilteredStaff(String query, String status);
    StaffStats getStaffStats();
    Optional<Staff> getStaffById(Long id);
    Staff saveStaff(Staff staff);
    Staff saveStaffWithImage(Staff staff, org.springframework.web.multipart.MultipartFile image);
    void deleteStaff(Long id);
}
