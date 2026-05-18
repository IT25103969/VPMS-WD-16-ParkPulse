package com.vpms.membermanagement.controller;

import com.vpms.membermanagement.model.Member;
import com.vpms.membermanagement.service.MemberService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.vpms.membermanagement.model.MemberStats;
import com.vpms.membermanagement.model.SubscriptionPlan;
import java.util.List;

@RestController
@RequestMapping("/api/members")
@CrossOrigin(origins = "*") 
public class MemberController {

    @Autowired
    private MemberService memberService;

    @GetMapping("/plans")
    public ResponseEntity<List<SubscriptionPlan>> getPlans() {
        return ResponseEntity.ok(memberService.getAvailablePlans());
    }

    @GetMapping
    public ResponseEntity<List<Member>> getAllMembers(@RequestParam(required = false) String search) {
        if (search != null && !search.isEmpty()) {
            return ResponseEntity.ok(memberService.searchMembers(search));
        }
        return ResponseEntity.ok(memberService.getAllMembers());
    }

    @GetMapping("/stats")
    public ResponseEntity<MemberStats> getMemberStats() {
        return ResponseEntity.ok(memberService.getMemberStats());
    }

    @PostMapping
    public ResponseEntity<Member> createMember(@Valid @RequestBody Member member) {
        return new ResponseEntity<>(memberService.createMember(member), HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Member> updateMember(@PathVariable String id, @Valid @RequestBody Member member) {
        return ResponseEntity.ok(memberService.updateMember(id, member));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMember(@PathVariable String id) {
        memberService.deleteMember(id);
        return ResponseEntity.noContent().build();
    }
}
