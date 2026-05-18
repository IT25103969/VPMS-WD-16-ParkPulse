package com.vpms.membermanagement.service;

import com.vpms.membermanagement.exception.ResourceNotFoundException;
import com.vpms.membermanagement.model.Member;
import com.vpms.membermanagement.model.enums.MemberStatus;
import com.vpms.membermanagement.repository.CrudRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vpms.membermanagement.model.MemberStats;
import com.vpms.membermanagement.model.SubscriptionPlan;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Demonstrates Abstraction.
 * This service layer interacts with the Repository through its interface, 
 * illustrating how business logic can be decoupled from the data access implementation.
 */
@Service
public class MemberService {
    
    private static final String PLANS_FILE = "data/membership.txt";

    // Demonstrates Polymorphism: injects the interface instead of the concrete implementation
    @Autowired
    private CrudRepository<Member, String> memberRepository;

    public List<Member> getAllMembers() {
        return memberRepository.findAll();
    }

    public List<SubscriptionPlan> getAvailablePlans() {
        List<Member> allMembers = getAllMembers();
        
        // Extract unique plan names from existing members
        List<String> uniquePlanNames = allMembers.stream()
                .map(Member::getPlan)
                .filter(plan -> plan != null && !plan.trim().isEmpty())
                .distinct()
                .sorted()
                .collect(Collectors.toList());

        // Price lookup for standard plans
        Map<String, Double> priceMap = Map.of(
            "MONTHLY", 1500.0,
            "QUARTERLY", 4000.0,
            "ANNUAL", 15000.0
        );

        List<SubscriptionPlan> plans = uniquePlanNames.stream()
                .map(name -> new SubscriptionPlan(name, priceMap.getOrDefault(name.toUpperCase(), 0.0)))
                .collect(Collectors.toList());

        // If no members exist yet, provide defaults
        if (plans.isEmpty()) {
            plans.add(new SubscriptionPlan("Monthly", 1500));
            plans.add(new SubscriptionPlan("Quarterly", 4000));
            plans.add(new SubscriptionPlan("Annual", 15000));
        }
        
        return plans;
    }

    public MemberStats getMemberStats() {
        List<Member> all = getAllMembers();
        List<SubscriptionPlan> plans = getAvailablePlans();
        Map<String, Double> planPrices = plans.stream()
                .collect(Collectors.toMap(p -> p.getName().toUpperCase(), SubscriptionPlan::getPrice));

        long total = all.size();
        long active = all.stream().filter(m -> m.getStatus() == MemberStatus.ACTIVE).count();
        long inactive = all.stream().filter(m -> m.getStatus() == MemberStatus.INACTIVE).count();
        long suspended = all.stream().filter(m -> m.getStatus() == MemberStatus.SUSPENDED).count();

        LocalDate now = LocalDate.now();
        long newThisMonth = all.stream().filter(m -> {
            if (m.getJoinDate() == null) return false;
            try {
                LocalDate join = LocalDate.parse(m.getJoinDate());
                return join.getMonth() == now.getMonth() && join.getYear() == now.getYear();
            } catch (DateTimeParseException e) {
                return false;
            }
        }).count();

        double revenue = all.stream()
            .filter(m -> m.getStatus() == MemberStatus.ACTIVE)
            .mapToDouble(m -> {
                if (m.getPlan() == null) return 0;
                return planPrices.getOrDefault(m.getPlan().toUpperCase(), 0.0);
            })
            .sum();

        int retention = total > 0 ? (int) Math.round(((double) active / total) * 100) : 0;

        Map<String, Long> distribution = all.stream()
            .collect(Collectors.groupingBy(m -> m.getPlan() == null ? "Unknown" : m.getPlan(), Collectors.counting()));

        return new MemberStats(total, active, inactive, suspended, newThisMonth, revenue, retention, distribution);
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
                             (m.getVehicleModel() != null && m.getVehicleModel().toLowerCase().contains(lowerQuery)) ||
                             (m.getPlan() != null && m.getPlan().toLowerCase().contains(lowerQuery)) ||
                             (m.getStatus() != null && m.getStatus().name().toLowerCase().contains(lowerQuery)))
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
        if (memberRepository.findById(id).isEmpty()) {
            throw new ResourceNotFoundException("Member not found with id: " + id);
        }
        member.setId(id);
        return memberRepository.update(member);
    }

    public void deleteMember(String id) {
        memberRepository.deleteById(id);
    }
}
