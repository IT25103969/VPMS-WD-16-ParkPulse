package com.parkpulse.service;

import com.parkpulse.model.Staff;
import com.parkpulse.repository.StaffRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class StaffService {

    @Autowired
    private StaffRepository staffRepository;

    public List<Staff> getAllStaff() {
        return staffRepository.findAll();
    }

    public List<Staff> searchStaff(String query) {
        if (query == null || query.isEmpty()) {
            return getAllStaff();
        }
        return staffRepository.findByNameContainingIgnoreCaseOrRoleContainingIgnoreCase(query, query);
    }

    public Optional<Staff> getStaffById(Long id) {
        return staffRepository.findById(id);
    }

    public Staff saveStaff(Staff staff) {
        return staffRepository.save(staff);
    }

    public void deleteStaff(Long id) {
        staffRepository.deleteById(id);
    }

    public long getActiveCount() {
        return staffRepository.findAll().stream().filter(s -> "Active".equalsIgnoreCase(s.getStatus())).count();
    }

    public long getOffDutyCount() {
        return staffRepository.findAll().stream().filter(s -> "Off Duty".equalsIgnoreCase(s.getStatus())).count();
    }
}
