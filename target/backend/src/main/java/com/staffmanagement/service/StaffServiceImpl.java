package com.staffmanagement.service;

import com.staffmanagement.dto.StaffStats;
import com.staffmanagement.model.Staff;
import com.staffmanagement.repository.BaseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Polymorphism & Abstraction: Implementation of the StaffService interface.
 * It depends on the BaseRepository interface (DIP - Dependency Inversion Principle).
 */
@Service
public class StaffServiceImpl implements StaffService {
    
    @Autowired
    private BaseRepository<Staff, Long> staffRepository;

    @Override
    public List<Staff> getAllStaff() {
        return staffRepository.findAll();
    }

    @Override
    public List<Staff> getFilteredStaff(String query, String status) {
        return staffRepository.findAll().stream()
                .filter(s -> {
                    boolean matchesSearch = query == null || query.isEmpty() ||
                            s.getName().toLowerCase().contains(query.toLowerCase()) ||
                            s.getRole().toLowerCase().contains(query.toLowerCase());
                    boolean matchesStatus = status == null || status.equalsIgnoreCase("all") ||
                            s.getStatus().equalsIgnoreCase(status.equals("offduty") ? "Off Duty" : status);
                    return matchesSearch && matchesStatus;
                })
                .collect(Collectors.toList());
    }

    @Override
    public StaffStats getStaffStats() {
        List<Staff> all = staffRepository.findAll();
        long total = all.size();
        long active = all.stream().filter(s -> "Active".equalsIgnoreCase(s.getStatus())).count();
        long offDuty = all.stream().filter(s -> "Off Duty".equalsIgnoreCase(s.getStatus())).count();
        return new StaffStats(total, active, offDuty);
    }

    @Override
    public Optional<Staff> getStaffById(Long id) {
        return staffRepository.findById(id);
    }

    @Override
    public Staff saveStaff(Staff staff) {
        validateStaff(staff);
        return staffRepository.save(staff);
    }

    @Override
    public Staff saveStaffWithImage(Staff staff, org.springframework.web.multipart.MultipartFile image) {
        if (image != null && !image.isEmpty()) {
            try {
                String fileName = java.util.UUID.randomUUID().toString() + "_" + image.getOriginalFilename();
                java.nio.file.Path path = java.nio.file.Paths.get("data/uploads", fileName);
                java.nio.file.Files.copy(image.getInputStream(), path, java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                staff.setAvatar("/uploads/" + fileName);
            } catch (java.io.IOException e) {
                throw new RuntimeException("Could not save image file", e);
            }
        }
        return saveStaff(staff);
    }

    private void validateStaff(Staff staff) {
        if (staff.getName() == null || staff.getName().length() < 3) {
            throw new com.staffmanagement.exception.ValidationException("Name must be at least 3 characters long.");
        }

        if (staff.getEmail() == null || !staff.getEmail().matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            throw new com.staffmanagement.exception.ValidationException("Invalid email format.");
        }

        if (staff.getPhone() == null || !staff.getPhone().matches("^\\+94\\s?\\d{2}\\s?\\d{3}\\s?\\d{4}$")) {
            throw new com.staffmanagement.exception.ValidationException("Phone must be in Sri Lankan format: +94 XX XXX XXXX");
        }

        // Joining Date Validation
        if (staff.getJoinDate() == null || staff.getJoinDate().isEmpty()) {
            throw new com.staffmanagement.exception.ValidationException("Joining date is required.");
        }
        try {
            java.time.LocalDate joinDate = java.time.LocalDate.parse(staff.getJoinDate());
            if (joinDate.isAfter(java.time.LocalDate.now())) {
                throw new com.staffmanagement.exception.ValidationException("Joining date cannot be in the future.");
            }
        } catch (java.time.format.DateTimeParseException e) {
            throw new com.staffmanagement.exception.ValidationException("Invalid date format. Use YYYY-MM-DD.");
        }

        // Vehicle Validation logic:
        // 1. Modern (3 letters): Must start with C (Car) or B (Bike) + 4 digits (CAA-1234, BAL-1234)
        // 2. Vintage/Old (2 letters): 2 letters + 4 digits (CE-1234, 15-1234, etc. - though usually letters now)
        String vNum = staff.getVehicleNumber();
        if (vNum == null) {
            throw new com.staffmanagement.exception.ValidationException("Vehicle number is required.");
        }
        
        // Remove province prefix if present (e.g., "WP ") and normalize
        String cleanVNum = vNum.replaceAll("^[A-Z]{2}\\s+", "").trim().toUpperCase();

        // Pattern for Modern (3 letters starting with C/B) followed by 4 digits
        boolean isModernFormat = cleanVNum.matches("^[CB][A-Z]{2}-\\d{4}$");
        
        // Pattern for Vintage/Old (2 letters/digits) followed by 4 digits
        // Sri Lanka also had numeric-only old plates like 15-1234, but focusing on 2 letters as requested
        boolean isVintageFormat = cleanVNum.matches("^[A-Z0-9]{2}-\\d{4}$");

        if (!isModernFormat && !isVintageFormat) {
            throw new com.staffmanagement.exception.ValidationException(
                "Invalid Vehicle Number. Format: [C/B]XX-1234 (Modern) or XX-1234 (Vintage)"
            );
        }
    }

    @Override
    public void deleteStaff(Long id) {
        staffRepository.deleteById(id);
    }
}
