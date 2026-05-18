package com.staffmanagement.controller;

import com.staffmanagement.model.Staff;
import com.staffmanagement.service.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/staff")
@CrossOrigin(origins = "*") // In production, restrict this to the actual frontend URL
public class StaffController {
    @Autowired
    private StaffService staffService;

    @GetMapping
    public List<Staff> getAllStaff(
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String status) {
        if (search != null || status != null) {
            return staffService.getFilteredStaff(search, status);
        }
        return staffService.getAllStaff();
    }

    @GetMapping("/stats")
    public com.staffmanagement.dto.StaffStats getStaffStats() {
        return staffService.getStaffStats();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Staff> getStaffById(@PathVariable Long id) {
        return staffService.getStaffById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping(consumes = {"multipart/form-data"})
    public Staff createStaff(
            @ModelAttribute Staff staff,
            @RequestParam(value = "image", required = false) org.springframework.web.multipart.MultipartFile image) {
        return staffService.saveStaffWithImage(staff, image);
    }

    @PutMapping(value = "/{id}", consumes = {"multipart/form-data"})
    public ResponseEntity<Staff> updateStaff(
            @PathVariable Long id,
            @ModelAttribute Staff staff,
            @RequestParam(value = "image", required = false) org.springframework.web.multipart.MultipartFile image) {
        return staffService.getStaffById(id)
                .map(existingStaff -> {
                    staff.setId(id);
                    // Keep existing avatar if no new image is provided
                    if ((image == null || image.isEmpty()) && existingStaff.getAvatar() != null) {
                        staff.setAvatar(existingStaff.getAvatar());
                    }
                    return ResponseEntity.ok(staffService.saveStaffWithImage(staff, image));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteStaff(@PathVariable Long id) {
        staffService.deleteStaff(id);
        return ResponseEntity.noContent().build();
    }
}
