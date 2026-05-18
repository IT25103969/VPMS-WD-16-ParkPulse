package com.vpms.membermanagement.repository;

import com.vpms.membermanagement.exception.DatabaseException;
import com.vpms.membermanagement.exception.ResourceNotFoundException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vpms.membermanagement.model.Member;
import org.springframework.stereotype.Repository;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Demonstrates Polymorphism and Encapsulation.
 * This class implements the CrudRepository interface specifically for Member entities.
 */
@Repository
public class MemberRepository implements CrudRepository<Member, String> {
    private static final String FILE_PATH = "data/members.txt";
    private final ObjectMapper objectMapper = new ObjectMapper();

    public MemberRepository() {
        initFile();
    }

    private void initFile() {
        File dataDir = new File("data");
        if (!dataDir.exists()) {
            dataDir.mkdirs();
        }
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            try {
                file.createNewFile();
                saveAll(new ArrayList<>());
            } catch (IOException e) {
                throw new DatabaseException("Failed to initialize data file", e);
            }
        }
    }

    @Override
    public List<Member> findAll() {
        try {
            File file = new File(FILE_PATH);
            if (!file.exists() || file.length() == 0) return new ArrayList<>();
            return objectMapper.readValue(file, new TypeReference<List<Member>>() {});
        } catch (IOException e) {
            throw new DatabaseException("Failed to read members from file", e);
        }
    }

    private void saveAll(List<Member> members) {
        try {
            objectMapper.writeValue(new File(FILE_PATH), members);
        } catch (IOException e) {
            throw new DatabaseException("Failed to write members to file", e);
        }
    }

    @Override
    public Member save(Member member) {
        List<Member> members = findAll();
        members.add(member);
        saveAll(members);
        return member;
    }

    @Override
    public Optional<Member> findById(String id) {
        return findAll().stream().filter(m -> m.getId().equals(id)).findFirst();
    }

    @Override
    public void deleteById(String id) {
        List<Member> members = findAll();
        boolean removed = members.removeIf(m -> m.getId().equals(id));
        if (!removed) {
            throw new ResourceNotFoundException("Member not found with id: " + id);
        }
        saveAll(members);
    }

    @Override
    public Member update(Member updatedMember) {
        List<Member> members = findAll();
        boolean found = false;
        for (int i = 0; i < members.size(); i++) {
            if (members.get(i).getId().equals(updatedMember.getId())) {
                members.set(i, updatedMember);
                found = true;
                break;
            }
        }
        if (!found) {
            throw new ResourceNotFoundException("Member not found with id: " + updatedMember.getId());
        }
        saveAll(members);
        return updatedMember;
    }
}
