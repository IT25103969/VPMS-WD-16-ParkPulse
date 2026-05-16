<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/includes/header.jsp" %>

<script>
    // Update active page for Analytics
    document.addEventListener('alpine:init', () => {
        const app = Alpine.store('app');
        app.activePage = 'membership-analytics';
        document.getElementById('page-title').innerText = 'Membership Analytics';
        document.getElementById('page-subtitle').innerText = 'Insights into member growth, plan distribution, and revenue.';
    });
</script>

<div x-data="membershipAnalytics()" class="px-8 py-6 flex flex-col gap-6">
    <!-- KPI Cards -->
    <div class="grid grid-cols-2 lg:grid-cols-4 gap-4">
        <template x-for="(kpi, i) in kpis" :key="kpi.label">
            <div class="rounded-xl p-4 border flex items-center gap-4 group transition-colors" :class="$store.app.isDark ? 'bg-[#1e2235] border-white/5 hover:border-white/10' : 'bg-white border-gray-200 hover:border-gray-300'">
                <div class="w-11 h-11 rounded-lg flex items-center justify-center shrink-0 transition-transform group-hover:scale-110 duration-300" :class="kpi.bgClass">
                    <template x-if="kpi.icon">
                        <i :data-lucide="kpi.icon" class="size-5" :class="kpi.iconClass"></i>
                    </template>
                    <template x-if="kpi.textIcon">
                        <span class="text-lg leading-none" :class="kpi.iconClass" x-text="kpi.textIcon"></span>
                    </template>
                </div>
                <div class="min-w-0">
                    <p class="text-xs truncate" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'" x-text="kpi.label"></p>
                    <p class="text-xl tabular-nums font-semibold" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'" x-text="kpi.displayValue"></p>
                    <p class="text-xs flex items-center gap-0.5 mt-0.5 text-green-400">
                        <i data-lucide="arrow-up" class="size-2.5"></i>
                        <span x-text="kpi.change"></span> vs last month
                    </p>
                </div>
            </div>
        </template>
    </div>

    <!-- Row: Growth + Plan Distribution -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-4">
        <!-- Member Growth -->
        <div class="lg:col-span-2 rounded-xl border p-5 transition-colors" :class="$store.app.isDark ? 'bg-[#1e2235] border-white/5' : 'bg-white border-gray-200'">
            <div class="flex items-center justify-between mb-4">
                <div>
                    <h3 class="text-sm font-medium" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'">Member Growth</h3>
                    <p class="text-xs mt-0.5" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Last 10 months</p>
                </div>
                <div class="flex items-center gap-1.5 text-xs px-2.5 py-1 rounded-lg" :class="$store.app.isDark ? 'bg-blue-500/10 text-blue-400' : 'bg-blue-50 text-blue-600'">
                    <i data-lucide="activity" class="size-3"></i>
                    +157% total
                </div>
            </div>
            <div id="growthChart" class="w-full h-52"></div>
        </div>

        <!-- Plan Distribution -->
        <div class="rounded-xl border p-5 transition-colors" :class="$store.app.isDark ? 'bg-[#1e2235] border-white/5' : 'bg-white border-gray-200'">
            <h3 class="text-sm font-medium mb-1" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'">Plan Distribution</h3>
            <p class="text-xs mb-3" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Current subscriptions</p>
            <div id="planChart" class="w-full h-40"></div>
            <div class="flex flex-col gap-2.5 mt-4">
                <template x-for="plan in planData" :key="plan.name">
                    <div class="flex items-center justify-between">
                        <span class="flex items-center gap-2">
                            <span class="w-2.5 h-2.5 rounded-full shrink-0" :style="'background:' + plan.color"></span>
                            <span class="text-xs" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-600'" x-text="plan.name"></span>
                        </span>
                        <span class="text-xs tabular-nums font-medium" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'" x-text="plan.value + '%'"></span>
                    </div>
                </template>
            </div>
        </div>
    </div>

    <!-- Row: Revenue + Activity -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-4">
        <!-- Revenue -->
        <div class="lg:col-span-2 rounded-xl border p-5 transition-colors" :class="$store.app.isDark ? 'bg-[#1e2235] border-white/5' : 'bg-white border-gray-200'">
            <div class="flex items-center justify-between mb-4">
                <div>
                    <h3 class="text-sm font-medium" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'">Monthly Revenue</h3>
                    <p class="text-xs mt-0.5" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Full year 2025 · in Rs.</p>
                </div>
                <div class="text-xs px-2.5 py-1 rounded-lg" :class="$store.app.isDark ? 'bg-amber-500/10 text-amber-400' : 'bg-amber-50 text-amber-600'">
                    Peak: Rs. 82,000
                </div>
            </div>
            <div id="revenueChart" class="w-full h-48"></div>
        </div>

        <!-- Recent Activity -->
        <div class="rounded-xl border p-5 flex flex-col transition-colors" :class="$store.app.isDark ? 'bg-[#1e2235] border-white/5' : 'bg-white border-gray-200'">
            <h3 class="text-sm font-medium mb-4" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'">Recent Activity</h3>
            <div class="flex flex-col gap-0 flex-1">
                <template x-for="(act, i) in recentActivity" :key="i">
                    <div class="flex items-start gap-3 py-3" :class="i < recentActivity.length - 1 ? 'border-b' : ''" :class="$store.app.isDark ? 'border-white/5' : 'border-gray-100'">
                        <div class="w-7 h-7 rounded-full shrink-0 flex items-center justify-center text-xs border" :class="$store.app.isDark ? 'bg-blue-600/30 border-blue-500/30 text-blue-400' : 'bg-blue-100 border-blue-200 text-blue-600'" x-text="getInitials(act.name)"></div>
                        <div class="min-w-0 flex-1">
                            <p class="text-xs truncate font-medium" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'" x-text="act.name"></p>
                            <p class="text-xs truncate" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'" x-text="act.action"></p>
                            <p class="text-[10px] mt-0.5" :class="$store.app.isDark ? 'text-gray-600' : 'text-gray-400'" x-text="act.time"></p>
                        </div>
                        <span class="text-[10px] px-1.5 py-0.5 rounded-full shrink-0" :class="getStatusBadgeClass(act.status)" x-text="act.status"></span>
                    </div>
                </template>
            </div>
        </div>
    </div>
</div>

<!-- ApexCharts CDN -->
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>

<script>
function membershipAnalytics() {
    return {
        members: [],
        apiBase: '${pageContext.request.contextPath}/api/members',
        
        growthChartInstance: null,
        planChartInstance: null,
        revenueChartInstance: null,

        get kpis() {
            const total = this.members.length;
            
            const currentMonth = new Date().getMonth();
            const currentYear = new Date().getFullYear();
            const newThisMonth = this.members.filter(m => {
                if(!m.joinDate) return false;
                const d = new Date(m.joinDate);
                return d.getMonth() === currentMonth && d.getFullYear() === currentYear;
            }).length;

            let revenue = 0;
            this.members.forEach(m => {
                if (m.status === 'Active') {
                    if (m.plan === 'Monthly') revenue += 1500;
                    else if (m.plan === 'Quarterly') revenue += 4000;
                    else if (m.plan === 'Annual') revenue += 15000;
                }
            });

            const activeMembers = this.members.filter(m => m.status === 'Active').length;
            const retention = total > 0 ? Math.round((activeMembers / total) * 100) : 0;

            return [
                { label: "Total Members", value: total, displayValue: total.toString(), change: "+12%", icon: "users", bgClass: Alpine.store('app').isDark ? "bg-blue-500/20" : "bg-blue-50", iconClass: Alpine.store('app').isDark ? "text-blue-400" : "text-blue-600" },
                { label: "New This Month", value: newThisMonth, displayValue: newThisMonth.toString(), change: "+8%", icon: "calendar", bgClass: Alpine.store('app').isDark ? "bg-purple-500/20" : "bg-purple-50", iconClass: Alpine.store('app').isDark ? "text-purple-400" : "text-purple-600" },
                { label: "Monthly Revenue", value: revenue, displayValue: "Rs. " + revenue.toLocaleString(), change: "+10.8%", textIcon: "රු", bgClass: Alpine.store('app').isDark ? "bg-amber-500/20" : "bg-amber-50", iconClass: Alpine.store('app').isDark ? "text-amber-400" : "text-amber-600" },
                { label: "Retention Rate", value: retention, displayValue: retention + "%", change: "+2.1%", icon: "trending-up", bgClass: Alpine.store('app').isDark ? "bg-green-500/20" : "bg-green-50", iconClass: Alpine.store('app').isDark ? "text-green-400" : "text-green-600" },
            ];
        },
        
        get planData() {
            const monthly = this.members.filter(m => m.plan === 'Monthly').length;
            const quarterly = this.members.filter(m => m.plan === 'Quarterly').length;
            const annual = this.members.filter(m => m.plan === 'Annual').length;
            const total = monthly + quarterly + annual;
            
            return [
                { name: "Monthly", count: monthly, value: total > 0 ? Math.round((monthly/total)*100) : 0, color: "#3b82f6" },
                { name: "Quarterly", count: quarterly, value: total > 0 ? Math.round((quarterly/total)*100) : 0, color: "#a855f7" },
                { name: "Annual", count: annual, value: total > 0 ? Math.round((annual/total)*100) : 0, color: "#f59e0b" },
            ];
        },

        get recentActivity() {
            return [...this.members]
                .sort((a, b) => new Date(b.joinDate || 0) - new Date(a.joinDate || 0))
                .slice(0, 5)
                .map(m => ({
                    name: m.name,
                    action: "Joined as member",
                    time: m.joinDate,
                    status: m.status
                }));
        },

        getInitials(name) {
            if (!name) return "";
            return name.split(" ").map(n => n[0]).join("").slice(0, 2).toUpperCase();
        },

        getStatusBadgeClass(status) {
            const map = {
                Active: "bg-green-500/20 text-green-400 border border-green-500/30",
                Inactive: "bg-gray-500/20 text-gray-400 border border-gray-500/30",
                Suspended: "bg-red-500/20 text-red-400 border border-red-500/30",
            };
            return map[status] || "bg-gray-500/20 text-gray-400 border border-gray-500/30";
        },

        async init() {
            await this.fetchMembers();
            this.$nextTick(() => {
                this.initCharts();
            });
            // Watch for theme changes to re-init charts
            this.$watch('$store.app.isDark', () => {
                this.initCharts();
            });
        },

        async fetchMembers() {
            try {
                const response = await fetch(this.apiBase);
                if (response.ok) {
                    this.members = await response.json();
                } else {
                    console.error('Failed to fetch members');
                }
            } catch (error) {
                console.error('Error fetching members:', error);
            }
        },

        initCharts() {
            const isDark = Alpine.store('app').isDark;
            const textColor = isDark ? '#9ca3af' : '#6b7280';
            const gridColor = isDark ? 'rgba(255,255,255,0.05)' : 'rgba(0,0,0,0.05)';

            if (this.growthChartInstance) this.growthChartInstance.destroy();
            if (this.planChartInstance) this.planChartInstance.destroy();
            if (this.revenueChartInstance) this.revenueChartInstance.destroy();

            // Growth Chart (Using mock trend but scaling roughly to total members)
            const baseMembers = this.members.length;
            const growthTrend = [Math.floor(baseMembers*0.4), Math.floor(baseMembers*0.5), Math.floor(baseMembers*0.6), Math.floor(baseMembers*0.6), Math.floor(baseMembers*0.7), Math.floor(baseMembers*0.8), Math.floor(baseMembers*0.9), Math.floor(baseMembers*0.95), Math.floor(baseMembers*0.98), baseMembers];
            
            this.growthChartInstance = new ApexCharts(document.querySelector("#growthChart"), {
                series: [{ name: 'Members', data: growthTrend }],
                chart: { type: 'area', height: '100%', toolbar: { show: false }, sparkline: { enabled: false } },
                stroke: { curve: 'smooth', width: 2.5, colors: ['#3b82f6'] },
                fill: { type: 'gradient', gradient: { shadeIntensity: 1, opacityFrom: 0.4, opacityTo: 0 } },
                xaxis: { categories: ['Aug', 'Sep', 'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May'], labels: { style: { colors: textColor, fontSize: '11px' } }, axisBorder: { show: false }, axisTicks: { show: false } },
                yaxis: { labels: { style: { colors: textColor, fontSize: '11px' } } },
                grid: { borderColor: gridColor, strokeDashArray: 4 },
                tooltip: { theme: isDark ? 'dark' : 'light' },
                dataLabels: { enabled: false }
            });
            this.growthChartInstance.render();

            // Plan Chart (Real Data)
            const planCounts = [
                this.planData.find(p => p.name === 'Monthly').count,
                this.planData.find(p => p.name === 'Quarterly').count,
                this.planData.find(p => p.name === 'Annual').count
            ];
            
            // Prevent empty chart crash
            const finalPlanCounts = planCounts.every(c => c === 0) ? [1, 1, 1] : planCounts;

            this.planChartInstance = new ApexCharts(document.querySelector("#planChart"), {
                series: finalPlanCounts,
                chart: { type: 'donut', height: 140 },
                labels: ['Monthly', 'Quarterly', 'Annual'],
                colors: ['#3b82f6', '#a855f7', '#f59e0b'],
                legend: { show: false },
                dataLabels: { enabled: false },
                plotOptions: { pie: { donut: { size: '70%', labels: { show: true, name: { show: true, color: textColor, fontSize: '10px' }, value: { show: true, color: isDark ? '#fff' : '#111', fontSize: '14px' } } } } },
                stroke: { show: false },
                tooltip: { theme: isDark ? 'dark' : 'light' }
            });
            this.planChartInstance.render();

            // Revenue Chart (Using mock trend but scaling to current calculated revenue)
            const currentRevenue = this.kpis[2].value;
            const revTrend = [Math.floor(currentRevenue*0.6), Math.floor(currentRevenue*0.65), Math.floor(currentRevenue*0.7), Math.floor(currentRevenue*0.65), Math.floor(currentRevenue*0.75), Math.floor(currentRevenue*0.8), Math.floor(currentRevenue*0.75), Math.floor(currentRevenue*0.85), Math.floor(currentRevenue*0.9), Math.floor(currentRevenue*0.88), Math.floor(currentRevenue*0.95), currentRevenue];
            
            this.revenueChartInstance = new ApexCharts(document.querySelector("#revenueChart"), {
                series: [{ name: 'Revenue', data: revTrend }],
                chart: { type: 'bar', height: '100%', toolbar: { show: false } },
                plotOptions: { bar: { borderRadius: 4, columnWidth: '60%' } },
                colors: ['#3b82f6'],
                fill: { type: 'gradient', gradient: { shadeIntensity: 1, opacityFrom: 1, opacityTo: 0.7 } },
                xaxis: { categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'], labels: { style: { colors: textColor, fontSize: '10px' } }, axisBorder: { show: false }, axisTicks: { show: false } },
                yaxis: { labels: { style: { colors: textColor, fontSize: '10px' }, formatter: (v) => 'Rs.' + (v / 1000).toFixed(1) + 'k' } },
                grid: { borderColor: gridColor, strokeDashArray: 4, xaxis: { lines: { show: false } } },
                tooltip: { theme: isDark ? 'dark' : 'light', y: { formatter: function (val) { return "Rs. " + val.toLocaleString() } } },
                dataLabels: { enabled: false }
            });
            this.revenueChartInstance.render();
        }
    };
}
</script>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
