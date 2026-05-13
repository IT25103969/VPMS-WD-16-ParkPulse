<%@ include file="includes/head.jsp" %>
<%@ include file="includes/sidebar.jsp" %>

<main class="flex-1 flex flex-col min-w-0 overflow-hidden">
    <div class="flex-1 flex flex-col min-h-0 overflow-auto animate-fade-in">
        <!-- Header -->
        <div class="px-8 py-5 flex items-center justify-between shrink-0 border-b border-border bg-gradient-to-b from-green-500/5 to-transparent">
            <div class="flex flex-col gap-0.5">
                <div class="flex items-center gap-2 mb-1">
                    <span class="text-xs text-sidebar-foreground/60">ParkPulse</span>
                    <span class="text-xs text-sidebar-foreground/40">/</span>
                    <span class="text-xs text-sidebar-foreground/60">Membership</span>
                    <span class="text-xs text-sidebar-foreground/40">/</span>
                    <span class="text-xs font-semibold text-green-500">Analytics</span>
                </div>
                <h1 class="text-2xl font-bold text-foreground">Membership Analytics</h1>
                <p class="text-sm text-sidebar-foreground/60 mt-0.5">Insights, trends and performance metrics</p>
            </div>

            <!-- Range selector -->
            <div class="flex items-center gap-1 p-1 rounded-xl border border-border bg-green-500/5">
                <button data-range="6M" class="range-btn active px-3 py-1.5 rounded-lg text-xs font-semibold transition-all bg-gradient-to-br from-green-600 to-green-500 text-white shadow-md shadow-green-500/20">6M</button>
                <button data-range="3M" class="range-btn px-3 py-1.5 rounded-lg text-xs font-semibold transition-all text-sidebar-foreground/60 hover:text-green-500">3M</button>
                <button data-range="1M" class="range-btn px-3 py-1.5 rounded-lg text-xs font-semibold transition-all text-sidebar-foreground/60 hover:text-green-500">1M</button>
            </div>
        </div>

        <!-- Content -->
        <div class="px-8 py-6 flex flex-col gap-6">
            <!-- KPI row -->
            <div class="grid grid-cols-4 gap-4">
                <!-- Total Members -->
                <div class="rounded-2xl p-5 flex flex-col gap-3 border border-border bg-card shadow-sm hover:-translate-y-1 transition-all">
                    <div class="flex items-center justify-between">
                        <div class="w-10 h-10 rounded-xl flex items-center justify-center bg-green-500/10 border border-green-500/20 text-green-500">
                            <i data-lucide="users" class="size-5"></i>
                        </div>
                        <span class="flex items-center gap-1 text-xs font-semibold px-2 py-1 rounded-full bg-green-500/10 text-green-500 border border-green-500/25">
                            <i data-lucide="arrow-up" class="size-3"></i>
                            8%
                        </span>
                    </div>
                    <div>
                        <p class="text-xs font-medium text-sidebar-foreground/60 mb-1">Total Members</p>
                        <p class="text-2xl font-bold text-foreground">80</p>
                        <p class="text-xs text-sidebar-foreground/40 mt-1">vs last month</p>
                    </div>
                </div>
                <!-- Active Members -->
                <div class="rounded-2xl p-5 flex flex-col gap-3 border border-border bg-card shadow-sm hover:-translate-y-1 transition-all">
                    <div class="flex items-center justify-between">
                        <div class="w-10 h-10 rounded-xl flex items-center justify-center bg-emerald-500/10 border border-emerald-500/20 text-emerald-500">
                            <i data-lucide="user-check" class="size-5"></i>
                        </div>
                        <span class="flex items-center gap-1 text-xs font-semibold px-2 py-1 rounded-full bg-emerald-500/10 text-emerald-500 border border-emerald-500/25">
                            <i data-lucide="arrow-up" class="size-3"></i>
                            11%
                        </span>
                    </div>
                    <div>
                        <p class="text-xs font-medium text-sidebar-foreground/60 mb-1">Active Members</p>
                        <p class="text-2xl font-bold text-foreground">68</p>
                        <p class="text-xs text-sidebar-foreground/40 mt-1">vs last month</p>
                    </div>
                </div>
                <!-- Retention Rate -->
                <div class="rounded-2xl p-5 flex flex-col gap-3 border border-border bg-card shadow-sm hover:-translate-y-1 transition-all">
                    <div class="flex items-center justify-between">
                        <div class="w-10 h-10 rounded-xl flex items-center justify-center bg-blue-500/10 border border-blue-500/20 text-blue-500">
                            <i data-lucide="trending-up" class="size-5"></i>
                        </div>
                        <span class="flex items-center gap-1 text-xs font-semibold px-2 py-1 rounded-full bg-blue-500/10 text-blue-500 border border-blue-500/25">
                            <i data-lucide="arrow-up" class="size-3"></i>
                            2%
                        </span>
                    </div>
                    <div>
                        <p class="text-xs font-medium text-sidebar-foreground/60 mb-1">Retention Rate</p>
                        <p class="text-2xl font-bold text-foreground">93%</p>
                        <p class="text-xs text-sidebar-foreground/40 mt-1">vs last month</p>
                    </div>
                </div>
                <!-- Monthly Revenue -->
                <div class="rounded-2xl p-5 flex flex-col gap-3 border border-border bg-card shadow-sm hover:-translate-y-1 transition-all">
                    <div class="flex items-center justify-between">
                        <div class="w-10 h-10 rounded-xl flex items-center justify-center bg-amber-500/10 border border-amber-500/20 text-amber-500">
                            <i data-lucide="credit-card" class="size-5"></i>
                        </div>
                        <span class="flex items-center gap-1 text-xs font-semibold px-2 py-1 rounded-full bg-amber-500/10 text-amber-500 border border-amber-500/25">
                            <i data-lucide="arrow-up" class="size-3"></i>
                            7%
                        </span>
                    </div>
                    <div>
                        <p class="text-xs font-medium text-sidebar-foreground/60 mb-1">Monthly Revenue</p>
                        <p class="text-2xl font-bold text-foreground">$5.8K</p>
                        <p class="text-xs text-sidebar-foreground/40 mt-1">vs last month</p>
                    </div>
                </div>
            </div>

            <!-- Main Charts Row -->
            <div class="grid grid-cols-3 gap-4">
                <!-- Member Growth Area Chart -->
                <div class="col-span-2 rounded-2xl p-5 border border-border bg-card shadow-sm">
                    <div class="mb-5">
                        <h3 class="text-sm font-bold text-foreground">Member Growth</h3>
                        <p class="text-xs text-sidebar-foreground/60 mt-0.5">Total, active and inactive members over time</p>
                    </div>
                    <div class="h-[200px] w-full">
                        <canvas id="growthChart"></canvas>
                    </div>
                </div>

                <!-- Plan Distribution Pie Chart -->
                <div class="rounded-2xl p-5 border border-border bg-card shadow-sm">
                    <div class="mb-5">
                        <h3 class="text-sm font-bold text-foreground">Plan Distribution</h3>
                        <p class="text-xs text-sidebar-foreground/60 mt-0.5">Members by subscription tier</p>
                    </div>
                    <div class="h-[150px] w-full mb-4">
                        <canvas id="planChart"></canvas>
                    </div>
                    <div id="plan-legend" class="flex flex-col gap-1.5 mt-2">
                        <!-- Legend will be injected by JS -->
                    </div>
                </div>
            </div>

            <!-- Secondary Charts Row -->
            <div class="grid grid-cols-2 gap-4">
                <!-- Retention Rate Bar Chart -->
                <div class="rounded-2xl p-5 border border-border bg-card shadow-sm">
                    <div class="mb-5">
                        <h3 class="text-sm font-bold text-foreground">Retention Rate</h3>
                        <p class="text-xs text-sidebar-foreground/60 mt-0.5">Monthly member retention %</p>
                    </div>
                    <div class="h-[180px] w-full">
                        <canvas id="retentionChart"></canvas>
                    </div>
                </div>

                <!-- Revenue Trend Area Chart -->
                <div class="rounded-2xl p-5 border border-border bg-card shadow-sm">
                    <div class="mb-5">
                        <h3 class="text-sm font-bold text-foreground">Revenue Trend</h3>
                        <p class="text-xs text-sidebar-foreground/60 mt-0.5">Estimated monthly membership revenue</p>
                    </div>
                    <div class="h-[180px] w-full">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Quick Insights -->
            <div class="rounded-2xl p-5 border border-border bg-card shadow-sm backdrop-blur-xl">
                <h3 class="text-sm font-bold text-foreground mb-4">Quick Insights</h3>
                <div class="grid grid-cols-3 gap-4">
                    <div class="flex items-center gap-3 rounded-xl p-3.5 bg-blue-500/5 border border-blue-500/10">
                        <div class="w-9 h-9 rounded-xl flex items-center justify-center bg-blue-500/10 border border-blue-500/20 text-blue-500">
                            <i data-lucide="calendar" class="size-4"></i>
                        </div>
                        <div>
                            <p class="text-[10px] text-sidebar-foreground/60 uppercase font-bold tracking-wider">Avg. Member Tenure</p>
                            <p class="font-bold text-sm text-foreground">8.4 months</p>
                        </div>
                    </div>
                    <div class="flex items-center gap-3 rounded-xl p-3.5 bg-red-500/5 border border-red-500/10">
                        <div class="w-9 h-9 rounded-xl flex items-center justify-center bg-red-500/10 border border-red-500/20 text-red-500">
                            <i data-lucide="user-x" class="size-4"></i>
                        </div>
                        <div>
                            <p class="text-[10px] text-sidebar-foreground/60 uppercase font-bold tracking-wider">Churn This Month</p>
                            <p class="font-bold text-sm text-foreground">2 members</p>
                        </div>
                    </div>
                    <div class="flex items-center gap-3 rounded-xl p-3.5 bg-emerald-500/5 border border-emerald-500/10">
                        <div class="w-9 h-9 rounded-xl flex items-center justify-center bg-emerald-500/10 border border-emerald-500/20 text-emerald-500">
                            <i data-lucide="user-check" class="size-4"></i>
                        </div>
                        <div>
                            <p class="text-[10px] text-sidebar-foreground/60 uppercase font-bold tracking-wider">New Sign-ups (May)</p>
                            <p class="font-bold text-sm text-foreground">6 members</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script src="js/analytics.js"></script>
<%@ include file="includes/footer.jsp" %>
