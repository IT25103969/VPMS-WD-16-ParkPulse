<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/includes/header.jsp" %>

<script>
    document.addEventListener('alpine:init', () => {
        const app = Alpine.store('app');
        app.activePage = 'membership-analytics';
        document.getElementById('page-title').innerText = 'Membership Analytics';
        document.getElementById('page-subtitle').innerText = 'Insights and trends for your parking membership.';
    });
</script>

<div x-data="analyticsDashboard()" class="px-8 py-6 flex flex-col gap-6">
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <template x-for="stat in summaryStats" :key="stat.label">
            <div class="rounded-xl p-4 border flex flex-col gap-1 transition-colors" :class="$store.app.isDark ? 'bg-[#1e2235] border-white/5' : 'bg-white border-gray-200'">
                <p class="text-xs" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'" x-text="stat.label"></p>
                <p class="text-2xl font-semibold" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'" x-text="stat.value"></p>
            </div>
        </template>
    </div>
</div>

<script>
function analyticsDashboard() {
    return {
        stats: null,
        async init() {
            const response = await fetch('${pageContext.request.contextPath}/api/members/stats');
            if (response.ok) this.stats = await response.json();
        },
        get summaryStats() {
            if (!this.stats) return [];
            return [
                { label: 'Monthly Revenue', value: 'LKR ' + this.stats.monthlyRevenue.toLocaleString() },
                { label: 'Retention Rate', value: this.stats.retentionRate + '%' },
                { label: 'New This Month', value: this.stats.newThisMonth },
                { label: 'Total Members', value: this.stats.totalMembers }
            ];
        }
    };
}
</script>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
