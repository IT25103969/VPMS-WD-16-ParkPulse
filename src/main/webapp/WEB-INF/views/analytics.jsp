<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="common/header.jsp" />
<jsp:include page="common/sidebar.jsp" />

<main class="flex-1 overflow-y-auto bg-background" x-data="analyticsData()" x-init="initCharts()">
    <div class="p-8">
        <div class="mb-6">
            <h1 class="text-2xl font-semibold text-foreground">Analytics</h1>
            <p class="text-sm text-muted-foreground">Real-time insights into vehicle allocations and zone utilisation.</p>
        </div>

        <!-- Stat cards -->
        <div class="grid grid-cols-4 gap-4 mb-6">
            <template x-for="s in statCards" :key="s.label">
                <div class="rounded-2xl border border-border p-4 bg-card flex flex-col gap-3">
                    <div class="flex items-start justify-between">
                        <div>
                            <div class="text-xs text-muted-foreground" x-text="s.label"></div>
                            <div class="mt-1 text-xl font-semibold text-foreground" x-text="s.value"></div>
                        </div>
                        <div class="size-9 rounded-xl flex items-center justify-center shrink-0" :class="s.iconBg">
                            <i :data-lucide="s.icon" class="size-4" :class="s.iconColor"></i>
                        </div>
                    </div>
                    <div>
                        <div class="text-xs text-muted-foreground mb-1.5" x-text="s.sub"></div>
                        <div class="h-1 w-full rounded-full bg-muted">
                            <div class="h-1 rounded-full transition-all" :class="s.barColor" :style="{ width: s.bar + '%' }"></div>
                        </div>
                    </div>
                </div>
            </template>
        </div>

        <div class="grid grid-cols-2 gap-6 mb-6">
            <!-- Weekly Traffic Area Chart -->
            <div class="rounded-2xl border border-border bg-card p-6">
                <div class="flex items-start justify-between mb-5">
                    <div>
                        <h2 class="text-xl font-medium text-foreground">Weekly Traffic</h2>
                        <p class="text-xs mt-0.5 text-muted-foreground">Allocations vs. releases · last 7 days</p>
                    </div>
                    <div class="flex items-center gap-3 shrink-0">
                        <span class="flex items-center gap-1.5 text-xs text-muted-foreground">
                            <span class="size-2 rounded-full bg-blue-500 inline-block"></span>Alloc.
                        </span>
                        <span class="flex items-center gap-1.5 text-xs text-muted-foreground">
                            <span class="size-2 rounded-full bg-emerald-500 inline-block"></span>Releases
                        </span>
                    </div>
                </div>
                <div style="height: 200px;">
                    <canvas id="weeklyTrafficChart"></canvas>
                </div>
            </div>

            <!-- Vehicle Breakdown Donut Chart -->
            <div class="rounded-2xl border border-border bg-card p-6">
                <div class="mb-5">
                    <h2 class="text-xl font-medium text-foreground">Vehicle Breakdown</h2>
                    <p class="text-xs mt-0.5 text-muted-foreground">Distribution of parked vehicle types</p>
                </div>
                <div class="flex items-center gap-6">
                    <div class="relative shrink-0" style="width: 180px; height: 180px;">
                        <canvas id="vehicleBreakdownChart"></canvas>
                        <div class="absolute inset-0 flex flex-col items-center justify-center pointer-events-none">
                            <span class="text-2xl font-bold text-foreground" x-text="window.backendData.stats.occupiedSlots"></span>
                            <span class="text-xs text-muted-foreground">parked</span>
                        </div>
                    </div>
                    <div class="flex-1 space-y-2.5">
                        <template x-for="(entry, i) in vehicleTypeData" :key="entry.name">
                            <div class="space-y-1">
                                <div class="flex items-center gap-2">
                                    <span class="size-2 rounded-full shrink-0" :style="{ backgroundColor: colors[i % colors.length] }"></span>
                                    <span class="text-xs flex-1 truncate text-muted-foreground" x-text="entry.name"></span>
                                    <span class="text-xs tabular-nums text-foreground font-medium" x-text="entry.value"></span>
                                    <span class="text-xs tabular-nums w-8 text-right text-muted-foreground" x-text="Math.round(entry.value/(window.backendData.stats.occupiedSlots || 1)*100) + '%'"></span>
                                </div>
                                <div class="h-0.5 rounded-full ml-4 bg-muted">
                                    <div class="h-0.5 rounded-full transition-all" :style="{ width: (entry.value/(window.backendData.stats.occupiedSlots || 1)*100) + '%', backgroundColor: colors[i % colors.length] }"></div>
                                </div>
                            </div>
                        </template>
                    </div>
                </div>
            </div>
        </div>

        <!-- Zone Breakdown Bar Chart -->
        <div class="rounded-2xl border border-border bg-card p-6">
            <div class="flex items-start justify-between mb-5">
                <div>
                    <h2 class="text-xl font-medium text-foreground">Zone Breakdown</h2>
                    <p class="text-xs mt-0.5 text-muted-foreground">Slot status distribution across all zones</p>
                </div>
                <div class="flex items-center gap-4 flex-wrap justify-end shrink-0">
                    <span class="flex items-center gap-1.5 text-xs text-muted-foreground"><span class="size-2 rounded-sm inline-block bg-[#10b981]"></span>Available</span>
                    <span class="flex items-center gap-1.5 text-xs text-muted-foreground"><span class="size-2 rounded-sm inline-block bg-[#ef4444]"></span>Occupied</span>
                    <span class="flex items-center gap-1.5 text-xs text-muted-foreground"><span class="size-2 rounded-sm inline-block bg-[#f59e0b]"></span>Reserved</span>
                    <span class="flex items-center gap-1.5 text-xs text-muted-foreground"><span class="size-2 rounded-sm inline-block bg-[#fb923c]"></span>Maintenance</span>
                </div>
            </div>
            <div style="height: 240px;">
                <canvas id="zoneBreakdownChart"></canvas>
            </div>
        </div>
    </div>
</main>

<jsp:include page="common/footer.jsp" />
