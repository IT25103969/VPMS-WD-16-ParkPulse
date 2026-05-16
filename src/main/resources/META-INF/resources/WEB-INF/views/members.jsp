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
                        <th class="text-left px-6 py-3 text-xs uppercase tracking-wider font-medium" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Status</th>
                        <th class="text-center px-6 py-3 text-xs uppercase tracking-wider font-medium" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Actions</th>
                    </tr>
                </thead>
                <tbody class="divide-y" :class="$store.app.isDark ? 'divide-white/5' : 'divide-gray-50'">
                    <template x-for="(m, idx) in members" :key="m.id">
                        <tr class="transition-colors" :class="[$store.app.isDark ? 'hover:bg-white/5' : 'hover:bg-gray-50']">
                            <td class="px-6 py-4 font-mono text-xs" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'" x-text="m.id"></td>
                            <td class="px-6 py-4 font-medium" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'" x-text="m.name"></td>
                            <td class="px-6 py-4">
                                <p :class="$store.app.isDark ? 'text-white' : 'text-gray-700'" x-text="m.email"></p>
                                <p class="text-xs" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'" x-text="m.phone"></p>
                            </td>
                            <td class="px-6 py-4">
                                <span :class="$store.app.isDark ? 'text-white' : 'text-gray-700'" x-text="m.vehicle"></span>
                                <p class="text-xs" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'" x-text="m.licensePlate"></p>
                            </td>
                            <td class="px-6 py-4">
                                <span class="px-2 py-0.5 rounded-full text-xs border" :class="getStatusBadgeClass(m.status)" x-text="m.status"></span>
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex items-center justify-center gap-2">
                                    <button @click="openEditModal(m)" class="p-1.5 rounded-lg border transition-colors" :class="$store.app.isDark ? 'border-white/10 hover:bg-white/5 text-gray-400' : 'border-gray-200 hover:bg-gray-50 text-gray-500'">
                                        <i data-lucide="pencil" class="size-4"></i>
                                    </button>
                                    <button @click="openDeleteModal(m)" class="p-1.5 rounded-lg border transition-colors" :class="$store.app.isDark ? 'border-white/10 hover:bg-white/5 text-red-400' : 'border-gray-200 hover:bg-gray-50 text-red-500'">
                                        <i data-lucide="trash" class="size-4"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </template>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modals -->
    <%@ include file="/WEB-INF/includes/modals.jsp" %>
</div>

<script>
function memberManagement() {
    return {
        search: '',
        members: [],
        apiBase: '${pageContext.request.contextPath}/api/members',
        
        // Modal state
        addOpen: false,
        editOpen: false,
        deleteOpen: false,
        selectedMember: null,
        form: { name: '', email: '', phone: '', vehicle: 'Car', vehicleModel: '', licensePlate: '', plan: 'Monthly', status: 'Active' },
        errors: {},

        init() {
            this.fetchMembers();
            this.$watch('search', () => this.fetchMembers());
        },

        async fetchMembers() {
            try {
                const url = this.search.trim() ? this.apiBase + '?search=' + encodeURIComponent(this.search) : this.apiBase;
                const response = await fetch(url);
                if (response.ok) this.members = await response.json();
            } catch (error) { console.error('Error fetching members:', error); }
        },

        getStatusBadgeClass(status) {
            const map = { Active: "bg-green-500/20 text-green-400 border-green-500/30", Inactive: "bg-gray-500/20 text-gray-400 border-gray-500/30", Suspended: "bg-red-500/20 text-red-400 border-red-500/30" };
            return map[status] || "bg-gray-500/20 text-gray-400 border-gray-500/30";
        },

        openAddModal() {
            this.form = { name: '', email: '', phone: '', vehicle: 'Car', vehicleModel: '', licensePlate: '', plan: 'Monthly', status: 'Active' };
            this.errors = {};
            this.addOpen = true;
        },

        async handleAdd() {
            try {
                const response = await fetch(this.apiBase, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(this.form) });
                if (response.ok) { await this.fetchMembers(); this.addOpen = false; }
            } catch (error) { console.error('Error adding member:', error); }
        },

        openEditModal(m) {
            this.selectedMember = m;
            this.form = { ...m };
            this.editOpen = true;
        },

        async handleEdit() {
            try {
                const response = await fetch(this.apiBase + '/' + this.selectedMember.id, { method: 'PUT', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(this.form) });
                if (response.ok) { await this.fetchMembers(); this.editOpen = false; }
            } catch (error) { console.error('Error updating member:', error); }
        },

        openDeleteModal(m) {
            this.selectedMember = m;
            this.deleteOpen = true;
        },

        async handleDelete() {
            try {
                const response = await fetch(this.apiBase + '/' + this.selectedMember.id, { method: 'DELETE' });
                if (response.ok) { await this.fetchMembers(); this.deleteOpen = false; }
            } catch (error) { console.error('Error deleting member:', error); }
        }
    };
}
</script>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
