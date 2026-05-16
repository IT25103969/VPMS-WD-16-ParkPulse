package com.vpms.membermanagement.service;

import com.vpms.membermanagement.model.Member;
import com.vpms.membermanagement.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Service
public class MemberService {
    @Autowired
    private MemberRepository memberRepository;

    public List<Member> getAllMembers() {
        return memberRepository.findAll();
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
