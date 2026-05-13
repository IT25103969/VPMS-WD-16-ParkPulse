package com.parking.management.service;

import com.parking.management.model.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class MemberService {

    @Autowired
    private FileStorageService fileStorageService;

    @Value("${storage.members-file}")
    private String membersFile;

    public Member createMember(Member member) {
        member.setId(UUID.randomUUID().toString());
        fileStorageService.append(membersFile, member.toFileString());
        return member;
    }

    public List<Member> getAllMembers() {
        return fileStorageService.readAll(membersFile, Member::fromFileString);
    }

    public Member getMemberById(String id) {
        return getAllMembers().stream()
                .filter(m -> m.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    public Member updateMember(String id, Member updatedMember) {
        List<Member> members = getAllMembers();
        boolean found = false;
        for (int i = 0; i < members.size(); i++) {
            if (members.get(i).getId().equals(id)) {
                updatedMember.setId(id);
                members.set(i, updatedMember);
                found = true;
                break;
            }
        }
        if (found) {
            fileStorageService.writeAll(membersFile, members.stream().map(Member::toFileString).collect(Collectors.toList()));
            return updatedMember;
        }
        return null;
    }

    public boolean deleteMember(String id) {
        List<Member> members = getAllMembers();
        List<Member> filtered = members.stream()
                .filter(m -> !m.getId().equals(id))
                .collect(Collectors.toList());
        
        if (filtered.size() < members.size()) {
            fileStorageService.writeAll(membersFile, filtered.stream().map(Member::toFileString).collect(Collectors.toList()));
            return true;
        }
        return false;
    }
}
