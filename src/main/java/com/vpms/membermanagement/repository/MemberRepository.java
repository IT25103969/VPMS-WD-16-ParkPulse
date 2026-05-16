package com.vpms.membermanagement.repository;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vpms.membermanagement.model.Member;
import org.springframework.stereotype.Repository;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Repository
public class MemberRepository {
    private static final String FILE_PATH = "data/members.txt";
    private final ObjectMapper objectMapper = new ObjectMapper();

    public MemberRepository() {
        initFile();
    }

    private void initFile() {
        try {
            File dataDir = new File("data");
            if (!dataDir.exists()) {
                dataDir.mkdirs();
            }
            File file = new File(FILE_PATH);
            if (!file.exists()) {
                file.createNewFile();
                saveAll(new ArrayList<>());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<Member> findAll() {
        try {
            File file = new File(FILE_PATH);
            if (file.length() == 0) return new ArrayList<>();
            return objectMapper.readValue(file, new TypeReference<List<Member>>() {});
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public void saveAll(List<Member> members) {
        try {
            objectMapper.writeValue(new File(FILE_PATH), members);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public Member save(Member member) {
        List<Member> members = findAll();
        members.add(member);
        saveAll(members);
        return member;
    }

    public Optional<Member> findById(String id) {
        return findAll().stream().filter(m -> m.getId().equals(id)).findFirst();
    }

    public void deleteById(String id) {
        List<Member> members = findAll();
        members.removeIf(m -> m.getId().equals(id));
        saveAll(members);
    }

    public Member update(Member updatedMember) {
        List<Member> members = findAll();
        for (int i = 0; i < members.size(); i++) {
            if (members.get(i).getId().equals(updatedMember.getId())) {
                members.set(i, updatedMember);
                break;
            }
        }
        saveAll(members);
        return updatedMember;
    }
}
