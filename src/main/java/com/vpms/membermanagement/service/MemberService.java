package com.vpms.membermanagement.service;

import com.vpms.membermanagement.model.Member;
import com.vpms.membermanagement.repository.CrudRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

/**
 * Demonstrates Abstraction.
 * This service layer interacts with the Repository through its interface, 
 * illustrating how business logic can be decoupled from the data access implementation.
 */
@Service
public class MemberService {
    
    // Demonstrates Polymorphism: injects the interface instead of the concrete implementation
    @Autowired
    private CrudRepository<Member, String> memberRepository;

    public List<Member> getAllMembers() {
        return memberRepository.findAll();
    }

    public List<Member> searchMembers(String query) {
        if (query == null || query.trim().isEmpty()) {
            return getAllMembers();
        }
        String lowerQuery = query.toLowerCase().trim();
        return memberRepository.findAll().stream()
                .filter(m -> (m.getName() != null && m.getName().toLowerCase().contains(lowerQuery)) ||
                             (m.getEmail() != null && m.getEmail().toLowerCase().contains(lowerQuery)) ||
                             (m.getId() != null && m.getId().toLowerCase().contains(lowerQuery)) ||
                             (m.getLicensePlate() != null && m.getLicensePlate().toLowerCase().contains(lowerQuery)) ||
                             (m.getVehicleModel() != null && m.getVehicleModel().toLowerCase().contains(lowerQuery)))
                .toList();
    }

    public Member createMember(Member member) {
        // Generate a simple ID if not provided
        if (member.getId() == null || member.getId().isEmpty()) {
            member.setId("MBR-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase());
        }
        if (member.getJoinDate() == null || member.getJoinDate().isEmpty()) {
            member.setJoinDate(LocalDate.now().toString());
        }
        return memberRepository.save(member);
    }

    public Member updateMember(String id, Member member) {
        member.setId(id);
        return memberRepository.update(member);
    }

    public void deleteMember(String id) {
        memberRepository.deleteById(id);
    }
}
