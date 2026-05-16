package com.vpms.membermanagement.controller;

import com.vpms.membermanagement.model.Member;
import com.vpms.membermanagement.model.MemberStats;
import com.vpms.membermanagement.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/members")
@CrossOrigin(origins = "*")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @GetMapping
    public List<Member> getAllMembers(@RequestParam(required = false) String search) {
        if (search != null && !search.isEmpty()) return memberService.searchMembers(search);
        return memberService.getAllMembers();
    }

    @GetMapping("/stats")
    public MemberStats getMemberStats() { return memberService.getMemberStats(); }

    @PostMapping
    public Member createMember(@RequestBody Member member) { return memberService.createMember(member); }

    @PutMapping("/{id}")
    public Member updateMember(@PathVariable String id, @RequestBody Member member) { return memberService.updateMember(id, member); }

    @DeleteMapping("/{id}")
    public void deleteMember(@PathVariable String id) { memberService.deleteMember(id); }
}
