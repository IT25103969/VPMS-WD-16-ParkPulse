<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>
<div class="flex h-screen overflow-hidden">
    <%@ include file="sidebar.jsp" %>
    
    <main class="flex-1 overflow-y-auto">
        <div class="p-8">
            <div class="mb-6">
                <h1 class="text-primary text-2xl font-semibold">Analytics</h1>
                <p class="text-sm text-muted">Real-time insights into vehicle allocations and zone utilisation.</p>
            </div>

            <c:set var="total" value="${totalSlots}" />
            <c:set var="occ" value="${occupiedSlots}" />
            <c:set var="occRate" value="${total gt 0 ? (occ * 100 / total) : 0}" />

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
                <div class="rounded-2xl border border-border p-4 card-bg flex flex-col gap-3">
                    <div class="flex items-start justify-between">
                        <div><div class="text-xs text-muted">Total Parked</div><div class="mt-1 text-xl text-primary font-semibold">${occ}</div></div>
                        <div class="size-9 rounded-xl flex items-center justify-center shrink-0 bg-blue-50 dark:bg-blue-500/10"><i data-lucide="car" class="size-4 text-blue-500"></i></div>
                    </div>
                    <div><div class="text-xs text-muted mb-1.5">of ${total} slots</div><div class="h-1 w-full rounded-full bg-gray-100 dark:bg-[#1a2540]"><div class="h-1 rounded-full bg-blue-500 transition-all" style="width: ${occRate}%"></div></div></div>
                </div>
                <div class="rounded-2xl border border-border p-4 card-bg flex flex-col gap-3">
                    <div class="flex items-start justify-between">
                        <div><div class="text-xs text-muted">Occupancy Rate</div><div class="mt-1 text-xl text-primary font-semibold">${occupancyRate}</div></div>
                        <div class="size-9 rounded-xl flex items-center justify-center shrink-0 bg-emerald-50 dark:bg-emerald-500/10"><i data-lucide="trending-up" class="size-4 text-emerald-500"></i></div>
                    </div>
                    <div><div class="text-xs text-muted mb-1.5">live utilisation</div><div class="h-1 w-full rounded-full bg-gray-100 dark:bg-[#1a2540]"><div class="h-1 rounded-full bg-emerald-500 transition-all" style="width: ${occRate}%"></div></div></div>
                </div>
                <div class="rounded-2xl border border-border p-4 card-bg flex flex-col gap-3">
                    <div class="flex items-start justify-between">
                        <div><div class="text-xs text-muted">Active Zones</div><div class="mt-1 text-xl text-primary font-semibold">${zones.size()}</div></div>
                        <div class="size-9 rounded-xl flex items-center justify-center shrink-0 bg-purple-50 dark:bg-purple-500/10"><i data-lucide="map-pin" class="size-4 text-purple-500"></i></div>
                    </div>
                    <div><div class="text-xs text-muted mb-1.5">${zones.size()} zones configured</div><div class="h-1 w-full rounded-full bg-gray-100 dark:bg-[#1a2540]"><div class="h-1 rounded-full bg-purple-500 transition-all" style="width: 100%"></div></div></div>
                </div>
                <div class="rounded-2xl border border-border p-4 card-bg flex flex-col gap-3">
                    <div class="flex items-start justify-between">
                        <div><div class="text-xs text-muted">Vehicle Types</div><div class="mt-1 text-xl text-primary font-semibold">5</div></div>
                        <div class="size-9 rounded-xl flex items-center justify-center shrink-0 bg-amber-50 dark:bg-amber-500/10"><i data-lucide="activity" class="size-4 text-amber-500"></i></div>
                    </div>
                    <div><div class="text-xs text-muted mb-1.5">active in facility</div><div class="h-1 w-full rounded-full bg-gray-100 dark:bg-[#1a2540]"><div class="h-1 rounded-full bg-amber-500 transition-all" style="width: 70%"></div></div></div>
                </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
                <div class="rounded-2xl border border-border card-bg p-6">
                    <div class="flex items-start justify-between mb-5">
                        <div><h2 class="text-primary text-xl font-semibold">Weekly Traffic</h2><p class="text-xs mt-0.5 text-muted">Allocations vs. releases · last 7 days</p></div>
                        <div class="flex items-center gap-3 shrink-0"><span class="flex items-center gap-1.5 text-xs text-muted"><span class="size-2 rounded-full bg-blue-500 inline-block"></span>Alloc.</span><span class="flex items-center gap-1.5 text-xs text-muted"><span class="size-2 rounded-full bg-emerald-500 inline-block"></span>Releases</span></div>
                    </div>
                    <div class="h-[230px]"><canvas id="weeklyTrafficChart"></canvas></div>
                </div>
                <div class="rounded-2xl border border-border card-bg p-6">
                    <div class="mb-5"><h2 class="text-primary text-xl font-semibold">Vehicle Breakdown</h2><p class="text-xs mt-0.5 text-muted">Distribution of parked vehicle types</p></div>
                    <div class="flex items-center gap-6 h-[230px]">
                        <div class="relative size-44 shrink-0"><canvas id="vehicleBreakdownChart"></canvas><div class="absolute inset-0 flex flex-col items-center justify-center pointer-events-none"><span class="text-2xl text-primary font-semibold">${occ}</span><span class="text-xs text-muted">parked</span></div></div>
                        <div class="flex-1 space-y-2.5 overflow-y-auto pr-2" id="vehicle-legend"></div>
                    </div>
                </div>
            </div>

            <div class="rounded-2xl border border-border card-bg p-6">
                <div class="flex items-start justify-between mb-5">
                    <div><h2 class="text-primary text-xl font-semibold">Zone Breakdown</h2><p class="text-xs mt-0.5 text-muted">Slot status distribution across all zones</p></div>
                    <div class="flex items-center gap-4 flex-wrap justify-end shrink-0">
                        <span class="flex items-center gap-1.5 text-xs text-muted"><span class="size-2 rounded-sm inline-block bg-[#10b981]"></span>Available</span>
                        <span class="flex items-center gap-1.5 text-xs text-muted"><span class="size-2 rounded-sm inline-block bg-[#ef4444]"></span>Occupied</span>
                        <span class="flex items-center gap-1.5 text-xs text-muted"><span class="size-2 rounded-sm inline-block bg-[#f59e0b]"></span>Reserved</span>
                    </div>
                </div>
                <div class="h-[270px]"><canvas id="zoneBreakdownChart"></canvas></div>
            </div>
        </div>
    </main>
</div>
<%@ include file="modals.jsp" %>
<script>
    const zones = ${zonesJson};
    const slots = ${slotsJson};

    document.addEventListener('DOMContentLoaded', () => {
        lucide.createIcons();
        const isDark = document.documentElement.classList.contains('dark');
        const axisColor = isDark ? '#9ca3af' : '#374151';
        const gridColor = isDark ? '#111827' : '#f3f4f6';

        // Traffic Chart (Static)
        new Chart(document.getElementById('weeklyTrafficChart'), {
            type: 'line',
            data: {
                labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                datasets: [{ label: 'Allocations', data: [45, 52, 38, 65, 48, 72, 58], borderColor: '#3b82f6', backgroundColor: 'rgba(59, 130, 246, 0.1)', fill: true, tension: 0.4 },
                           { label: 'Releases', data: [35, 41, 32, 55, 40, 60, 50], borderColor: '#10b981', backgroundColor: 'rgba(16, 185, 129, 0.05)', fill: true, tension: 0.4 }]
            },
            options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } }, scales: { x: { grid: { display: false }, ticks: { color: axisColor } }, y: { grid: { color: gridColor }, ticks: { color: axisColor } } } }
        });

        // Vehicle Breakdown
        const types = {};
        slots.filter(s => s.status === 'occupied').forEach(s => {
            types[s.vehicle.type] = (types[s.vehicle.type] || 0) + 1;
        });
        const vLabels = Object.keys(types);
        const vData = Object.values(types);
        const vColors = ['#3b82f6', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6', '#ec4899', '#f97316'];

        new Chart(document.getElementById('vehicleBreakdownChart'), {
            type: 'doughnut',
            data: { labels: vLabels, datasets: [{ data: vData, backgroundColor: vColors, borderWidth: 0, cutout: '70%' }] },
            options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } } }
        });

        const legend = document.getElementById('vehicle-legend');
        const vTotal = vData.reduce((a, b) => a + b, 0);
        vLabels.forEach((l, i) => {
            const pct = vTotal > 0 ? Math.round((vData[i] / vTotal) * 100) : 0;
            legend.innerHTML += `<div class="space-y-1"><div class="flex items-center gap-2"><span class="size-2 rounded-full" style="background-color: \${vColors[i]}"></span><span class="text-xs flex-1 text-muted">\${l}</span><span class="text-xs font-medium">\${vData[i]}</span><span class="text-xs w-8 text-right text-muted">\${pct}%</span></div><div class="h-0.5 rounded-full ml-4 bg-gray-100 dark:bg-[#1a2540]"><div class="h-0.5 rounded-full" style="width: \${pct}%; background-color: \${vColors[i]}"></div></div></div>`;
        });

        // Zone Breakdown
        const zLabels = zones.map(z => z.name);
        const avail = zones.map(z => slots.filter(s => s.zoneId === z.id && s.status === 'available').length);
        const occ = zones.map(z => slots.filter(s => s.zoneId === z.id && s.status === 'occupied').length);
        const res = zones.map(z => slots.filter(s => s.zoneId === z.id && (s.status === 'reserved' || s.status === 'maintenance')).length);

        new Chart(document.getElementById('zoneBreakdownChart'), {
            type: 'bar',
            data: { labels: zLabels, datasets: [{ label: 'Available', data: avail, backgroundColor: '#10b981' }, { label: 'Occupied', data: occ, backgroundColor: '#ef4444' }, { label: 'Reserved', data: res, backgroundColor: '#f59e0b' }] },
            options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } }, scales: { x: { stacked: true, grid: { display: false }, ticks: { color: axisColor } }, y: { stacked: true, grid: { color: gridColor }, ticks: { color: axisColor } } } }
        });
    });
</script>
</body>
</html>
