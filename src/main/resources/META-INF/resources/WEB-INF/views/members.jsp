<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/includes/header.jsp" %>

<script>
    // Update active page for Members
    document.addEventListener('alpine:init', () => {
        const app = Alpine.store('app');
        app.activePage = 'members';
        document.getElementById('page-title').innerText = 'Member Management';
        document.getElementById('page-subtitle').innerText = 'Manage parking members, subscriptions and access.';
    });
</script>

<div x-data="memberManagement()" class="px-8 py-6 flex flex-col gap-6" @open-add-modal.window="openAddModal()">
    <!-- Stats -->
    <div class="grid grid-cols-2 lg:grid-cols-4 gap-4">
        <template x-for="stat in stats" :key="stat.label">
            <div class="rounded-xl p-4 border flex items-center gap-4 transition-colors" :class="$store.app.isDark ? 'bg-[#1e2235] border-white/5' : 'bg-white border-gray-200'">
                <div class="w-11 h-11 rounded-lg flex items-center justify-center shrink-0" :class="stat.bgClass">
                    <i :data-lucide="stat.icon" class="size-5" :class="stat.iconClass"></i>
                </div>
                <div>
                    <p class="text-xs" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'" x-text="stat.label"></p>
                    <p class="text-2xl" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'" x-text="stat.value"></p>
                </div>
            </div>
        </template>
    </div>

    <!-- Table Card -->
    <div class="rounded-xl border overflow-hidden transition-colors" :class="$store.app.isDark ? 'bg-[#1e2235] border-white/5' : 'bg-white border-gray-200'">
        <!-- Toolbar -->
        <div class="flex items-center justify-between px-6 py-4 border-b" :class="$store.app.isDark ? 'border-white/10' : 'border-gray-100'">
            <h2 class="font-medium" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'">All Members</h2>
            <div class="flex items-center gap-2 rounded-lg px-3 py-2 border w-64 transition-colors" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10' : 'bg-gray-50 border-gray-200'">
                <i data-lucide="search" class="size-4 shrink-0" :class="$store.app.isDark ? 'text-gray-500' : 'text-gray-400'"></i>
                <input type="text" placeholder="Search members..." x-model="search" class="bg-transparent text-sm outline-none w-full" :class="$store.app.isDark ? 'text-white placeholder-gray-500' : 'text-gray-700 placeholder-gray-400'">
            </div>
        </div>

        <!-- Table -->
        <div class="overflow-x-auto">
            <table class="w-full text-sm">
                <thead>
                    <tr class="border-b transition-colors" :class="$store.app.isDark ? 'border-white/10' : 'border-gray-100'">
                        <th class="text-left px-6 py-3 text-xs uppercase tracking-wider font-medium" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Member ID</th>
                        <th class="text-left px-6 py-3 text-xs uppercase tracking-wider font-medium" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Name</th>
                        <th class="text-left px-6 py-3 text-xs uppercase tracking-wider font-medium" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Contact</th>
                        <th class="text-left px-6 py-3 text-xs uppercase tracking-wider font-medium" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Vehicle</th>
                        <th class="text-left px-6 py-3 text-xs uppercase tracking-wider font-medium" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Plan</th>
                        <th class="text-left px-6 py-3 text-xs uppercase tracking-wider font-medium" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Status</th>
                        <th class="text-left px-6 py-3 text-xs uppercase tracking-wider font-medium" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Join Date</th>
                        <th class="text-center px-6 py-3 text-xs uppercase tracking-wider font-medium" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Actions</th>
                    </tr>
                </thead>
                <tbody class="divide-y" :class="$store.app.isDark ? 'divide-white/5' : 'divide-gray-50'">
                    <template x-for="(m, idx) in filteredMembers" :key="m.id">
                        <tr class="transition-colors" :class="[$store.app.isDark ? 'hover:bg-white/5' : 'hover:bg-gray-50', idx % 2 !== 0 ? ($store.app.isDark ? 'bg-white/[0.02]' : 'bg-gray-50/60') : '']">
                            <td class="px-6 py-4 font-mono text-xs" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'" x-text="m.id"></td>
                            <td class="px-6 py-4">
                                <div class="flex items-center gap-3">
                                    <div class="w-8 h-8 rounded-full border flex items-center justify-center text-xs shrink-0" :class="$store.app.isDark ? 'bg-blue-600/30 border-blue-500/30 text-blue-400' : 'bg-blue-100 border-blue-200 text-blue-600'" x-text="getInitials(m.name)"></div>
                                    <span class="font-medium" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'" x-text="m.name"></span>
                                </div>
                            </td>
                            <td class="px-6 py-4">
                                <p :class="$store.app.isDark ? 'text-white' : 'text-gray-700'" x-text="m.email"></p>
                                <p class="text-xs" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'" x-text="m.phone"></p>
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex items-center gap-1.5">
                                    <i data-lucide="car" class="size-3.5" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'"></i>
                                    <span :class="$store.app.isDark ? 'text-white' : 'text-gray-700'" x-text="m.vehicle"></span>
                                </div>
                                <p class="text-xs pl-5 font-medium" :class="$store.app.isDark ? 'text-blue-400' : 'text-blue-600'" x-text="m.vehicleModel"></p>
                                <p class="text-xs pl-5" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'" x-text="m.licensePlate"></p>
                            </td>
                            <td class="px-6 py-4">
                                <span class="px-2 py-0.5 rounded-full text-xs border" :class="getPlanBadgeClass(m.plan)" x-text="m.plan"></span>
                            </td>
                            <td class="px-6 py-4">
                                <span class="px-2 py-0.5 rounded-full text-xs border" :class="getStatusBadgeClass(m.status)" x-text="m.status"></span>
                            </td>
                            <td class="px-6 py-4 text-xs" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'" x-text="m.joinDate"></td>
                            <td class="px-6 py-4">
                                <div class="flex items-center justify-center gap-2">
                                    <button @click="openEditModal(m)" title="Edit Member" class="px-3 py-1.5 rounded-lg border font-medium text-xs flex items-center gap-1.5 shadow-sm transition-all" :class="$store.app.isDark ? 'bg-blue-500/10 hover:bg-blue-500/20 border-blue-500/30 text-blue-400' : 'bg-white hover:bg-blue-50 border-blue-300 text-blue-600'">
                                        <svg class="w-4 h-4 shrink-0" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M11.5 15H7a4 4 0 0 0-4 4v2"/><path d="M21.378 16.626a1 1 0 0 0-3.004-3.004l-4.01 4.012a2 2 0 0 0-.506.854l-.837 2.87a.5.5 0 0 0 .62.62l2.87-.837a2 2 0 0 0 .854-.506z"/><circle cx="10" cy="7" r="4"/></svg>
                                        <span>Edit</span>
                                    </button>
                                    <button @click="openDeleteModal(m)" title="Delete Member" class="px-3 py-1.5 rounded-lg border font-medium text-xs flex items-center gap-1.5 shadow-sm transition-all" :class="$store.app.isDark ? 'bg-red-500/10 hover:bg-red-500/20 border-red-500/30 text-red-400' : 'bg-white hover:bg-red-50 border-red-300 text-red-600'">
                                        <svg class="w-4 h-4 shrink-0" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><line x1="17" y1="8" x2="23" y2="14"/><line x1="23" y1="8" x2="17" y2="14"/></svg>
                                        <span>Delete</span>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </template>
                    <template x-if="filteredMembers.length === 0">
                        <tr><td colSpan="8" class="text-center py-16" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">No members found.</td></tr>
                    </template>
                </tbody>
            </table>
        </div>

        <div class="px-6 py-3 border-t transition-colors" :class="$store.app.isDark ? 'border-white/10' : 'border-gray-100'">
            <p class="text-xs" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Showing <span x-text="filteredMembers.length"></span> of <span x-text="members.length"></span> members</p>
        </div>
    </div>

    <!-- Modals (Alpine.js handled) -->
    <%@ include file="/WEB-INF/includes/modals.jsp" %>
</div>

<script>
function memberManagement() {
    return {
        search: '',
        members: [],
        statsData: { totalMembers: 0, activeMembers: 0, inactiveMembers: 0, suspendedMembers: 0 },
        apiBase: '${pageContext.request.contextPath}/api/members',
        
        // Modal state
        addOpen: false,
        editOpen: false,
        deleteOpen: false,
        selectedMember: null,
        plans: [],
        form: { name: '', email: '', phone: '', vehicle: 'Car', vehicleModel: '', licensePlate: '', plan: '', status: 'ACTIVE' },
        errors: {},

        init() {
            this.fetchPlans();
            this.fetchMembers();
            this.fetchStats();
            this.$watch('search', () => this.fetchMembers());
        },

        async fetchPlans() {
            try {
                const response = await fetch(this.apiBase + '/plans');
                if (response.ok) {
                    this.plans = await response.json();
                    if (this.plans.length > 0 && !this.form.plan) {
                        this.form.plan = this.plans[0].name;
                    }
                }
            } catch (error) {
                console.error('Error fetching plans:', error);
            }
        },

        async fetchMembers() {
            try {
                const url = this.search.trim() 
                    ? this.apiBase + '?search=' + encodeURIComponent(this.search)
                    : this.apiBase;
                    
                const response = await fetch(url);
                if (response.ok) {
                    this.members = await response.json();
                } else {
                    console.error('Failed to fetch members');
                }
            } catch (error) {
                console.error('Error fetching members:', error);
            }
        },

        async fetchStats() {
            try {
                const response = await fetch(this.apiBase + '/stats');
                if (response.ok) {
                    this.statsData = await response.json();
                }
            } catch (error) {
                console.error('Error fetching stats:', error);
            }
        },

        get filteredMembers() {
            // Now "filteredMembers" just returns the full members list because 
            // the filtering is already done by the backend!
            return this.members;
        },

        get stats() {
            return [
                { label: "Total Members", value: this.statsData.totalMembers, icon: "users", bgClass: Alpine.store('app').isDark ? "bg-blue-500/20" : "bg-blue-50", iconClass: Alpine.store('app').isDark ? "text-blue-400" : "text-blue-600" },
                { label: "Active", value: this.statsData.activeMembers, icon: "user-check", bgClass: Alpine.store('app').isDark ? "bg-green-500/20" : "bg-green-50", iconClass: Alpine.store('app').isDark ? "text-green-400" : "text-green-600" },
                { label: "Inactive", value: this.statsData.inactiveMembers, icon: "user-x", bgClass: Alpine.store('app').isDark ? "bg-gray-500/20" : "bg-gray-100", iconClass: Alpine.store('app').isDark ? "text-gray-400" : "text-gray-500" },
                { label: "Suspended", value: this.statsData.suspendedMembers, icon: "user-x", bgClass: Alpine.store('app').isDark ? "bg-red-500/20" : "bg-red-50", iconClass: Alpine.store('app').isDark ? "text-red-400" : "text-red-500" },
            ];
        },

        getInitials(name) {
            if (!name) return "";
            return name.split(" ").map(n => n[0]).join("").slice(0, 2).toUpperCase();
        },

        getPlanBadgeClass(plan) {
            if (!plan) return "bg-gray-500/20 text-gray-400 border-gray-500/30";
            const p = plan.toUpperCase();
            const map = {
                MONTHLY: "bg-blue-500/20 text-blue-400 border-blue-500/30",
                QUARTERLY: "bg-purple-500/20 text-purple-400 border-purple-500/30",
                ANNUAL: "bg-amber-500/20 text-amber-400 border-amber-500/30",
            };
            return map[p] || "bg-gray-500/20 text-gray-400 border-gray-500/30";
        },

        getStatusBadgeClass(status) {
            const map = {
                ACTIVE: "bg-green-500/20 text-green-400 border-green-500/30",
                INACTIVE: "bg-gray-500/20 text-gray-400 border-gray-500/30",
                SUSPENDED: "bg-red-500/20 text-red-400 border-red-500/30",
            };
            return map[status] || "bg-gray-500/20 text-gray-400 border-gray-500/30";
        },

        openAddModal() {
            this.form = { name: '', email: '', phone: '', vehicle: 'Car', vehicleModel: '', licensePlate: '', plan: this.plans.length > 0 ? this.plans[0].name : '', status: 'ACTIVE' };
            this.errors = {};
            this.addOpen = true;
        },

        async handleAdd() {
            this.errors = this.validate(this.form);
            if (Object.keys(this.errors).length > 0) return;
            
            try {
                const response = await fetch(this.apiBase, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(this.form)
                });
                if (response.ok) {
                    await this.fetchMembers();
                    await this.fetchStats();
                    this.addOpen = false;
                } else {
                    console.error('Failed to add member');
                }
            } catch (error) {
                console.error('Error adding member:', error);
            }
        },

        openEditModal(m) {
            this.selectedMember = m;
            this.form = { ...m };
            this.errors = {};
            this.editOpen = true;
        },

        async handleEdit() {
            this.errors = this.validate(this.form);
            if (Object.keys(this.errors).length > 0) return;
            
            try {
                const response = await fetch(this.apiBase + '/' + this.selectedMember.id, {
                    method: 'PUT',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(this.form)
                });
                if (response.ok) {
                    await this.fetchMembers();
                    await this.fetchStats();
                    this.editOpen = false;
                } else {
                    console.error('Failed to update member');
                }
            } catch (error) {
                console.error('Error updating member:', error);
            }
        },

        openDeleteModal(m) {
            this.selectedMember = m;
            this.deleteOpen = true;
        },

        async handleDelete() {
            try {
                const response = await fetch(this.apiBase + '/' + this.selectedMember.id, {
                    method: 'DELETE'
                });
                if (response.ok) {
                    await this.fetchMembers();
                    await this.fetchStats();
                    this.deleteOpen = false;
                } else {
                    console.error('Failed to delete member');
                }
            } catch (error) {
                console.error('Error deleting member:', error);
            }
        },

        validate(f) {
            const e = {};
            if (!f.name.trim()) e.name = "Required";
            
            if (!f.email.trim()) e.email = "Required";
            else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(f.email)) e.email = "Invalid email";
            
            if (!f.phone.trim()) e.phone = "Required";
            else if (!/^(\+94|0)[0-9]{9}$/.test(f.phone.replace(/\s/g, ''))) e.phone = "Invalid Sri Lankan number";
            
            if (!f.vehicle) e.vehicle = "Required";
            
            if (!f.vehicleModel.trim()) e.vehicleModel = "Required";
            
            if (!f.licensePlate.trim()) e.licensePlate = "Required";
            else if (f.vehicle === 'Car' && !/^[A-Z]{3}-\d{4}$/i.test(f.licensePlate.trim())) {
                e.licensePlate = "Format: 3 letters, hyphen, 4 numbers (e.g. ABC-1234)";
            }
            
            return e;
        }
    };
}
</script>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
