package com.vpms.membermanagement.service;

import com.vpms.membermanagement.model.Member;
import com.vpms.membermanagement.model.MemberStats;
import com.vpms.membermanagement.repository.CrudRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class MemberService {
    
    @Autowired
    private CrudRepository<Member, String> memberRepository;

    public List<Member> getAllMembers() { return memberRepository.findAll(); }

    public MemberStats getMemberStats() {
        List<Member> all = getAllMembers();
        long total = all.size();
        long active = all.stream().filter(m -> "Active".equalsIgnoreCase(m.getStatus())).count();
        long inactive = all.stream().filter(m -> "Inactive".equalsIgnoreCase(m.getStatus())).count();
        long suspended = all.stream().filter(m -> "Suspended".equalsIgnoreCase(m.getStatus())).count();

        LocalDate now = LocalDate.now();
        long newThisMonth = all.stream().filter(m -> {
            if (m.getJoinDate() == null) return false;
            try {
                LocalDate join = LocalDate.parse(m.getJoinDate());
                return join.getMonth() == now.getMonth() && join.getYear() == now.getYear();
            } catch (Exception e) { return false; }
        }).count();

        double revenue = all.stream()
            .filter(m -> "Active".equalsIgnoreCase(m.getStatus()))
            .mapToDouble(m -> {
                if ("Monthly".equalsIgnoreCase(m.getPlan())) return 1500;
                if ("Quarterly".equalsIgnoreCase(m.getPlan())) return 4000;
                if ("Annual".equalsIgnoreCase(m.getPlan())) return 15000;
                return 0;
            }).sum();

        int retention = total > 0 ? (int) Math.round(((double) active / total) * 100) : 0;
        Map<String, Long> distribution = all.stream()
            .collect(Collectors.groupingBy(m -> m.getPlan() == null ? "Unknown" : m.getPlan(), Collectors.counting()));

        return new MemberStats(total, active, inactive, suspended, newThisMonth, revenue, retention, distribution);
    }

    public List<Member> searchMembers(String query) {
        if (query == null || query.trim().isEmpty()) return getAllMembers();
        String lowerQuery = query.toLowerCase().trim();
        return memberRepository.findAll().stream()
                .filter(m -> (m.getName() != null && m.getName().toLowerCase().contains(lowerQuery)) ||
                             (m.getEmail() != null && m.getEmail().toLowerCase().contains(lowerQuery)) ||
                             (m.getId() != null && m.getId().toLowerCase().contains(lowerQuery)))
                .toList();
    }

    public Member createMember(Member member) {
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

    public void deleteMember(String id) { memberRepository.deleteById(id); }
}
