<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ParkPulse - Management System</title>
    <!-- CSS Dependencies -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/3.2.1/anime.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
        
        :root {
            --background: #ffffff;
            --foreground: #030213;
            --card: #ffffff;
            --card-foreground: #030213;
            --primary: #030213;
            --muted: #ececf0;
            --muted-foreground: #717182;
            --accent: #e9ebef;
            --border: rgba(0, 0, 0, 0.1);
            --sidebar: #fbfbfb;
            --sidebar-border: #ececf0;
            --inner-bg: #f9fafb;
        }

        .dark {
            --background: #0b1220;
            --foreground: #fbfbfb;
            --card: #111a2e;
            --card-foreground: #fbfbfb;
            --primary: #fbfbfb;
            --muted: #1a2540;
            --muted-foreground: #9ca3af;
            --accent: #1a2540;
            --border: #1f2a44;
            --sidebar: #111a2e;
            --sidebar-border: #1f2a44;
            --inner-bg: #0b1220;
        }

        body { 
            font-family: 'Inter', sans-serif; 
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .snap-x { scroll-snap-type: x mandatory; }
        .snap-start { scroll-snap-align: start; }
        [scrollbar-width:none] { scrollbar-width: none; }
        ::-webkit-scrollbar { display: none; }

        /* Animation utilities to mimic Framer Motion */
        .fade-in { animation: fadeIn 0.3s ease-in-out; }
        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
        
        .slide-up { animation: slideUp 0.3s ease-out; }
        @keyframes slideUp { from { transform: translateY(10px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }

        .modal-enter { animation: modalEnter 0.3s cubic-bezier(0.16, 1, 0.3, 1); }
        @keyframes modalEnter { from { opacity: 0; transform: translate(-50%, -45%) scale(0.95); } to { opacity: 1; transform: translate(-50%, -50%) scale(1); } }
    </style>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        background: 'var(--background)',
                        foreground: 'var(--foreground)',
                        card: 'var(--card)',
                        'card-foreground': 'var(--card-foreground)',
                        muted: 'var(--muted)',
                        'muted-foreground': 'var(--muted-foreground)',
                        accent: 'var(--accent)',
                        border: 'var(--border)',
                        sidebar: 'var(--sidebar)',
                        'sidebar-border': 'var(--sidebar-border)',
                        inner: 'var(--inner-bg)',
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-background text-foreground overflow-hidden h-screen">
    <div id="app" class="flex h-full w-full">
        <!-- Sidebar -->
        <aside id="sidebar-container" class="w-60 shrink-0 border-r border-sidebar-border bg-sidebar flex flex-col transition-colors duration-300">
            <!-- Content will be injected by JS -->
        </aside>

        <!-- Main Content -->
        <main class="flex-1 overflow-y-auto">
            <div id="view-container" class="h-full">
                <!-- Views will be injected by JS -->
            </div>
        </main>
    </div>

    <!-- Modals -->
    <div id="modal-overlay" class="fixed inset-0 bg-black/60 backdrop-blur-sm z-40 hidden" onclick="closeAllModals()"></div>
    
    <!-- Action Modal -->
    <div id="action-modal" class="fixed top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-full max-w-md rounded-2xl shadow-2xl z-50 border border-border bg-card modal-enter hidden">
        <div id="action-modal-content" class="p-6"></div>
    </div>

    <!-- New Zone Modal -->
    <div id="new-zone-modal" class="fixed top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-full max-w-md rounded-2xl shadow-2xl z-50 border border-border bg-card modal-enter hidden">
        <div class="p-6">
            <div class="flex items-center justify-between mb-6">
                <h2 class="font-bold">Create New Zone</h2>
                <button onclick="closeNewZoneModal()" class="p-2 rounded-lg hover:bg-muted transition-colors">
                    <i data-lucide="x" class="size-5 text-muted-foreground"></i>
                </button>
            </div>
            <div class="space-y-4">
                <div>
                    <label class="block text-sm mb-2 text-muted-foreground font-medium">Zone Name</label>
                    <input type="text" id="newZoneNameInput" placeholder="e.g. Section E" 
                        class="w-full px-4 py-3 rounded-xl border border-border bg-background focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all">
                </div>
                <div>
                    <label class="block text-sm mb-2 text-muted-foreground font-medium">Number of Slots</label>
                    <input type="number" id="newZoneSlotCountInput" value="12" min="1" max="100"
                        class="w-full px-4 py-3 rounded-xl border border-border bg-background focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all">
                </div>
                <div class="flex gap-3 pt-2">
                    <button onclick="closeNewZoneModal()" class="flex-1 py-3 rounded-xl bg-muted text-muted-foreground font-semibold hover:bg-accent transition-all">Cancel</button>
                    <button id="createZoneBtn" onclick="handleCreateZone()" 
                        class="flex-1 py-3 bg-blue-600 hover:bg-blue-700 text-white rounded-xl font-semibold transition-all">Create Zone</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        // --- State Management ---
        let state = {
            zones: [],
            slots: [],
            view: 'dashboard', // dashboard, slots, analytics, entry, vehicles
            previousView: 'dashboard',
            isLight: false,
            parkingExpanded: true,
            activeZoneId: 'A',
            dashActiveZoneIdx: 0,
            selectedSlot: null,
            reserveStep: false,
            dashSearch: '',
            slotSearch: '',
            formData: {
                licensePlate: '',
                type: 'Sedan',
                owner: '',
                phone: '',
                email: ''
            }
        };

        const VEHICLE_TYPES = ['Sedan', 'SUV', 'Hatchback', 'Truck', 'Motorcycle', 'Van'];
        const PIE_COLORS = ['#3b82f6', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6', '#06b6d4'];

        // --- Core Functions ---

        async function init() {
            // Apply initial theme
            if (state.isLight) document.documentElement.classList.remove('dark');
            else document.documentElement.classList.add('dark');

            await fetchData();
            render();
        }

        async function fetchData() {
            try {
                const response = await fetch('/api/data');
                const data = await response.json();
                state.zones = data.zones;
                state.slots = data.slots;
                
                // Set initial active zone if not set
                if (state.zones.length > 0 && !state.activeZoneId) {
                    state.activeZoneId = state.zones[0].id;
                }
            } catch (err) {
                console.error("Failed to fetch data", err);
            }
        }

        function render() {
            renderSidebar();
            renderMainContent();
            lucide.createIcons();
        }

        function setView(view) {
            state.previousView = state.view;
            state.view = view;
            render();
        }

        function toggleTheme() {
            state.isLight = !state.isLight;
            if (state.isLight) document.documentElement.classList.remove('dark');
            else document.documentElement.classList.add('dark');
            render();
        }

        function toggleParkingExpand() {
            state.parkingExpanded = !state.parkingExpanded;
            render();
        }

        // --- Sidebar ---

        function renderSidebar() {
            const isParkingActive = ['dashboard', 'slots', 'analytics', 'vehicles'].includes(state.view);
            const textPrimary = 'text-foreground';
            const textMuted = 'text-muted-foreground';
            const tabIdle = state.isLight ? 'hover:bg-gray-100' : 'hover:bg-[#1a2540]';

            const html = `
                <div class="p-6 flex items-center gap-3">
                    <div class="size-9 bg-blue-600 rounded-xl flex items-center justify-center shadow-lg">
                        <i data-lucide="car" class="size-5 text-white"></i>
                    </div>
                    <span class="font-bold ${textPrimary} text-lg">ParkPulse</span>
                </div>

                <nav class="flex-1 px-3 space-y-1">
                    <div>
                        <button onclick="handleParkingToggle()" 
                            class="w-full flex items-center gap-3 px-4 py-2.5 rounded-lg transition-colors ${isParkingActive ? 'bg-blue-600 text-white shadow-md' : `${textMuted} ${tabIdle}`}">
                            <i data-lucide="parking-square" class="size-4"></i>
                            <span class="text-sm flex-1 text-left font-medium">Parking Slots</span>
                            <i data-lucide="chevron-down" class="size-4 transition-transform ${state.parkingExpanded ? 'rotate-180' : ''}"></i>
                        </button>
                        
                        <div id="parking-sub-items" class="overflow-hidden transition-all duration-300 ${state.parkingExpanded ? 'max-h-60 opacity-100' : 'max-h-0 opacity-0'}">
                            <div class="pl-9 pt-1 space-y-1">
                                <button onclick="setView('slots')" 
                                    class="w-full flex items-center gap-2 px-3 py-2 rounded-lg text-sm transition-colors ${state.view === 'slots' ? (state.isLight ? 'bg-blue-50 text-blue-700 font-semibold' : 'bg-[#1a2540] text-white font-semibold') : `${textMuted} ${tabIdle}`}">
                                    <i data-lucide="parking-square" class="size-3.5"></i>
                                    Slots
                                </button>
                                <button onclick="setView('analytics')" 
                                    class="w-full flex items-center gap-2 px-3 py-2 rounded-lg text-sm transition-colors ${state.view === 'analytics' ? (state.isLight ? 'bg-blue-50 text-blue-700 font-semibold' : 'bg-[#1a2540] text-white font-semibold') : `${textMuted} ${tabIdle}`}">
                                    <i data-lucide="bar-chart-3" class="size-3.5"></i>
                                    Analytics
                                </button>
                                <button onclick="setView('vehicles')" 
                                    class="w-full flex items-center gap-2 px-3 py-2 rounded-lg text-sm transition-colors ${state.view === 'vehicles' ? (state.isLight ? 'bg-blue-50 text-blue-700 font-semibold' : 'bg-[#1a2540] text-white font-semibold') : `${textMuted} ${tabIdle}`}">
                                    <i data-lucide="list" class="size-3.5"></i>
                                    Vehicles
                                </button>
                            </div>
                        </div>
                    </div>
                </nav>

                <div class="p-4 border-t border-sidebar-border space-y-2">
                    <div class="text-[10px] ${textMuted} px-2 font-bold uppercase tracking-widest">Theme Mode</div>
                    <button onclick="toggleTheme()" 
                        class="w-full flex items-center justify-center gap-2 py-2.5 rounded-xl bg-muted text-foreground font-medium hover:bg-accent transition-all">
                        <i data-lucide="${state.isLight ? 'moon' : 'sun'}" class="size-4"></i>
                        <span class="text-sm">Switch to ${state.isLight ? 'Dark' : 'Light'}</span>
                    </button>
                    <button class="w-full flex items-center justify-center gap-2 py-2.5 rounded-xl bg-muted text-foreground font-medium hover:bg-accent transition-all">
                        <i data-lucide="log-out" class="size-4"></i>
                        <span class="text-sm">Sign Out</span>
                    </button>
                </div>
            `;
            document.getElementById('sidebar-container').innerHTML = html;
        }

        function handleParkingToggle() {
            if (state.view !== 'dashboard') {
                setView('dashboard');
                state.parkingExpanded = true;
            } else {
                state.parkingExpanded = !state.parkingExpanded;
            }
            render();
        }

        // --- Main Content Views ---

        function renderMainContent() {
            const container = document.getElementById('view-container');
            
            const viewDiv = document.createElement('div');
            viewDiv.className = 'h-full';

            if (state.view === 'dashboard') viewDiv.innerHTML = getDashboardHTML();
            else if (state.view === 'slots') viewDiv.innerHTML = getSlotsHTML();
            else if (state.view === 'analytics') viewDiv.innerHTML = getAnalyticsHTML();
            else if (state.view === 'vehicles') viewDiv.innerHTML = getVehiclesHTML();
            else if (state.view === 'entry') viewDiv.innerHTML = getEntryHTML();

            container.innerHTML = '';
            container.appendChild(viewDiv);

            anime({
                targets: viewDiv,
                opacity: [0, 1],
                translateY: [15, 0],
                easing: 'easeOutCubic',
                duration: 400
            });

            if (state.view === 'analytics') initCharts();
            if (state.view === 'dashboard') {
                updateDashUI();
                const input = document.getElementById('dashSearchInput');
                if (input) {
                    input.addEventListener('input', (e) => {
                        state.dashSearch = e.target.value;
                        updateDashboardSearch();
                    });
                }
            }
            if (state.view === 'slots') {
                const input = document.getElementById('slotSearchInput');
                if (input) {
                    input.addEventListener('input', (e) => {
                        state.slotSearch = e.target.value;
                        render(); 
                    });
                }
            }
        }

        function calculateStats() {
            const total = state.slots.length;
            const occupied = state.slots.filter(s => s.status === 'occupied').length;
            const reserved = state.slots.filter(s => s.status === 'reserved').length;
            const maintenance = state.slots.filter(s => s.status === 'maintenance').length;
            return {
                total,
                occupied,
                available: total - occupied - reserved - maintenance,
                rate: total ? Math.round((occupied / total) * 100) : 0
            };
        }

        function calculateZoneStats() {
            return state.zones.map(z => {
                const zSlots = state.slots.filter(s => s.zoneId === z.id);
                const occ = zSlots.filter(s => s.status === 'occupied').length;
                return {
                    name: z.name,
                    id: z.id,
                    total: zSlots.length,
                    occupied: occ,
                    available: zSlots.length - occ
                };
            });
        }

        // --- View HTML Generators ---

        function getDashboardHTML() {
            const stats = calculateStats();
            const zoneStats = calculateZoneStats();
            const textPrimary = 'text-foreground';
            const textMuted = 'text-muted-foreground';
            const cardBg = 'bg-card border-border';

            return `
                <div class="p-8">
                    <div class="flex items-center justify-between mb-8 gap-4 flex-wrap">
                        <div>
                            <h1 class="text-3xl font-bold ${textPrimary}">Dashboard</h1>
                            <p class="${textMuted} mt-1">Overview of slots and zones across your facility.</p>
                        </div>
                        <div class="flex items-center gap-3 flex-wrap">
                            <div class="relative">
                                <i data-lucide="search" class="absolute left-4 top-1/2 -translate-y-1/2 size-4 text-muted-foreground pointer-events-none"></i>
                                <input type="text" id="dashSearchInput" value="${state.dashSearch}" placeholder="Search by plate…" 
                                    class="pl-11 pr-4 py-2 bg-background border border-border text-foreground rounded-full focus:outline-none focus:ring-2 focus:ring-blue-500 w-48 text-sm transition-all">
                            </div>
                            <button onclick="handleNewEntry()" class="flex items-center gap-2 px-5 py-2.5 bg-blue-600 hover:bg-blue-700 text-white rounded-full transition-all shadow-lg font-medium">
                                <i data-lucide="plus" class="size-4"></i>
                                <span class="text-sm">New Entry</span>
                            </button>
                        </div>
                    </div>

                    <div id="dashSearchResults" class="hidden slide-up mb-8 rounded-2xl border border-border bg-card p-6"></div>

                    <div class="grid grid-cols-4 gap-6 mb-8">
                        <div class="rounded-2xl border ${cardBg} p-5 shadow-sm">
                            <div class="text-xs font-bold text-muted-foreground uppercase tracking-widest">Total Slots</div>
                            <div class="text-2xl font-bold ${textPrimary} mt-1">${stats.total}</div>
                        </div>
                        <div class="rounded-2xl border ${cardBg} p-5 shadow-sm">
                            <div class="text-xs font-bold text-muted-foreground uppercase tracking-widest">Available</div>
                            <div class="text-2xl font-bold text-emerald-500 mt-1">${stats.available}</div>
                        </div>
                        <div class="rounded-2xl border ${cardBg} p-5 shadow-sm">
                            <div class="text-xs font-bold text-muted-foreground uppercase tracking-widest">Occupied</div>
                            <div class="text-2xl font-bold text-red-500 mt-1">${stats.occupied}</div>
                        </div>
                        <div class="rounded-2xl border ${cardBg} p-5 shadow-sm">
                            <div class="text-xs font-bold text-muted-foreground uppercase tracking-widest">Occupancy</div>
                            <div class="text-2xl font-bold text-blue-500 mt-1">${stats.rate}%</div>
                        </div>
                    </div>

                    <div class="rounded-[2rem] border ${cardBg} p-8 mb-8 shadow-sm">
                        <h2 class="text-xl font-bold ${textPrimary} mb-6">Zones Overview</h2>
                        <div class="grid grid-cols-4 gap-6">
                            ${zoneStats.map(z => {
                                const pct = z.total ? Math.round((z.occupied / z.total) * 100) : 0;
                                return `
                                    <button onclick="state.activeZoneId='${z.id}'; setView('slots');" 
                                        class="rounded-2xl border border-border p-5 text-left bg-background hover:border-blue-500 transition-all group">
                                        <div class="flex items-center justify-between mb-3">
                                            <div class="flex items-center gap-2">
                                                <i data-lucide="map-pin" class="size-4 text-blue-500"></i>
                                                <span class="text-sm font-semibold ${textPrimary}">${z.name}</span>
                                            </div>
                                            <span class="text-xs font-bold text-muted-foreground">${pct}%</span>
                                        </div>
                                        <div class="h-2 rounded-full bg-muted overflow-hidden mb-3">
                                            <div class="h-full bg-gradient-to-r from-blue-500 to-blue-600 transition-all duration-500" style="width: ${pct}%"></div>
                                        </div>
                                        <div class="flex justify-between text-[10px] font-bold uppercase tracking-wider">
                                            <span class="text-emerald-500">${z.available} Free</span>
                                            <span class="text-red-500">${z.occupied} Occ</span>
                                        </div>
                                    </button>
                                `;
                            }).join('')}
                        </div>
                    </div>

                    <div class="rounded-[2rem] border ${cardBg} p-8 shadow-sm">
                        <div class="flex items-center justify-between mb-8">
                            <h2 class="text-xl font-bold ${textPrimary}">Live Slot Map</h2>
                            <button onclick="setView('slots')" class="text-sm font-semibold text-blue-500 hover:text-blue-400 transition-colors">Manage →</button>
                        </div>
                        
                        <div class="flex gap-4 text-[10px] font-bold uppercase tracking-widest mb-6 flex-wrap">
                            <div class="flex items-center gap-2"><span class="size-3 rounded-sm bg-emerald-500"></span><span class="${textMuted}">Available</span></div>
                            <div class="flex items-center gap-2"><span class="size-3 rounded-sm bg-red-500"></span><span class="${textMuted}">Occupied</span></div>
                            <div class="flex items-center gap-2"><span class="size-3 rounded-sm bg-amber-400"></span><span class="${textMuted}">Reserved</span></div>
                            <div class="flex items-center gap-2"><span class="size-3 rounded-sm bg-orange-400"></span><span class="${textMuted}">Maintenance</span></div>
                        </div>

                        <div id="dashZoneHeader" class="flex items-center justify-between mb-4">
                            <!-- Injected by updateDashUI -->
                        </div>

                        <div class="relative overflow-hidden rounded-2xl">
                            <div id="dashScrollContainer" class="flex overflow-x-auto snap-x snap-mandatory [scrollbar-width:none] -mx-0" onscroll="handleDashScroll(this)">
                                ${state.zones.map((z, idx) => `
                                    <div class="w-full shrink-0 snap-start transition-all duration-500 ${idx === state.dashActiveZoneIdx ? 'opacity-100 scale-100' : 'opacity-20 scale-95 pointer-events-none'}">
                                        <div class="grid grid-cols-6 gap-3 p-1">
                                            ${state.slots.filter(s => s.zoneId === z.id).map(s => `
                                                <button onclick="handleSlotClick('${s.id}')" 
                                                    class="h-16 rounded-xl text-white font-bold text-xs transition-all hover:scale-105 shadow-md ${getSlotGradient(s.status)}">
                                                    ${s.number}
                                                </button>
                                            `).join('')}
                                        </div>
                                    </div>
                                `).join('')}
                            </div>
                        </div>
                    </div>
                </div>
            `;
        }

        function updateDashUI() {
            const header = document.getElementById('dashZoneHeader');
            if (!header || state.view !== 'dashboard') return;

            const zone = state.zones[state.dashActiveZoneIdx];
            const zoneSlots = state.slots.filter(s => s.zoneId === zone?.id);
            const textPrimary = 'text-foreground';
            const textMuted = 'text-muted-foreground';

            header.innerHTML = `
                <div class="flex items-center gap-2">
                    <i data-lucide="map-pin" class="size-4 text-blue-500"></i>
                    <span class="text-sm font-bold ${textPrimary}">${zone?.name || ''}</span>
                    <span class="text-xs ${textMuted}">· ${zoneSlots.length} slots</span>
                </div>
                <div class="flex items-center gap-3">
                    <div class="flex gap-1.5 mr-2">
                        ${state.zones.map((_, i) => `
                            <button onclick="scrollToZone(${i})" class="transition-all ${i === state.dashActiveZoneIdx ? 'size-2 bg-blue-500 rounded-full' : 'size-1.5 bg-muted rounded-full hover:bg-muted-foreground'}"></button>
                        `).join('')}
                    </div>
                    <button onclick="scrollToZone(Math.max(0, state.dashActiveZoneIdx - 1))" class="p-2 rounded-lg hover:bg-muted transition-colors" ${state.dashActiveZoneIdx === 0 ? 'disabled style="opacity:0.3"' : ''}>
                        <i data-lucide="chevron-left" class="size-4"></i>
                    </button>
                    <button onclick="scrollToZone(Math.min(state.zones.length - 1, state.dashActiveZoneIdx + 1))" class="p-2 rounded-lg hover:bg-muted transition-colors" ${state.dashActiveZoneIdx === state.zones.length - 1 ? 'disabled style="opacity:0.3"' : ''}>
                        <i data-lucide="chevron-right" class="size-4"></i>
                    </button>
                </div>
            `;

            // Fix: update visibility/interactivity of zone containers
            const containers = document.querySelectorAll('#dashScrollContainer > div');
            containers.forEach((container, idx) => {
                if (idx === state.dashActiveZoneIdx) {
                    container.classList.remove('opacity-20', 'scale-95', 'pointer-events-none');
                    container.classList.add('opacity-100', 'scale-100');
                } else {
                    container.classList.add('opacity-20', 'scale-95', 'pointer-events-none');
                    container.classList.remove('opacity-100', 'scale-100');
                }
            });

            lucide.createIcons();
        }

        function getSlotsHTML() {
            const query = state.slotSearch.trim().toLowerCase();
            const isSearching = query.length > 0;
            const searchResults = isSearching ? state.slots.filter(s => s.vehicle && s.vehicle.licensePlate.toLowerCase().includes(query)) : [];
            const displaySlots = isSearching ? searchResults : state.slots.filter(s => s.zoneId === state.activeZoneId);
            const textPrimary = 'text-foreground';
            const textMuted = 'text-muted-foreground';
            const cardBg = 'bg-card border-border';
            const tabIdle = state.isLight ? 'bg-gray-100 text-gray-700 hover:bg-gray-200' : 'bg-[#1a2540] text-gray-300 hover:bg-[#243154]';

            return `
                <div class="p-8">
                    <div class="flex items-center justify-between mb-8 gap-4 flex-wrap">
                        <div>
                            <h1 class="text-3xl font-bold ${textPrimary}">Parking Slots</h1>
                        </div>
                        <div class="flex items-center gap-3">
                            <div class="relative">
                                <i data-lucide="search" class="absolute left-4 top-1/2 -translate-y-1/2 size-4 text-muted-foreground pointer-events-none"></i>
                                <input type="text" id="slotSearchInput" value="${state.slotSearch}" placeholder="Search by plate…" 
                                    class="pl-11 pr-4 py-2 bg-background border border-border text-foreground rounded-full w-48 text-sm">
                            </div>
                            <button onclick="openNewZoneModal()" class="px-5 py-2.5 bg-blue-600 text-white rounded-full font-medium shadow-lg hover:bg-blue-700 transition-all">New Zone</button>
                        </div>
                    </div>

                    <div class="rounded-[2rem] border ${cardBg} p-8 shadow-sm">
                        <div class="flex gap-2 mb-8 overflow-x-auto pb-2">
                            ${state.zones.map(z => `
                                <button onclick="setActiveZone('${z.id}')" 
                                    class="px-5 py-2 rounded-xl text-sm font-bold transition-all shrink-0 ${state.activeZoneId === z.id ? 'bg-blue-600 text-white' : tabIdle}">
                                    ${z.name}
                                </button>
                            `).join('')}
                        </div>
                        <div class="grid grid-cols-6 gap-6">
                            ${displaySlots.map(s => `
                                <button onclick="handleSlotClick('${s.id}')" 
                                    class="h-28 rounded-3xl flex flex-col items-center justify-center text-white gap-1 transition-all hover:scale-105 shadow-xl ${getSlotGradient(s.status)}">
                                    ${getSlotIcon(s.status)}
                                    <span class="text-xs font-bold tracking-wider">${s.number}</span>
                                </button>
                            `).join('')}
                        </div>
                    </div>
                </div>
            `;
        }

        function getAnalyticsHTML() {
            const stats = calculateStats();
            const textPrimary = 'text-foreground';
            const textMuted = 'text-muted-foreground';
            const cardBg = 'bg-card border-border';
            const parkedVehicles = state.slots.filter(s => s.status === 'occupied');

            return `
                <div class="p-8">
                    <div class="mb-8">
                        <h1 class="text-3xl font-bold ${textPrimary}">Analytics</h1>
                        <p class="${textMuted} mt-1">Insights into vehicle allocations and zone usage.</p>
                    </div>

                    <div class="grid grid-cols-4 gap-6 mb-8">
                        <div class="rounded-2xl border ${cardBg} p-5 flex items-center gap-4 shadow-sm">
                            <div class="size-12 rounded-2xl bg-blue-600/10 flex items-center justify-center shrink-0"><i data-lucide="car" class="size-6 text-blue-500"></i></div>
                            <div><div class="text-[10px] font-bold text-muted-foreground uppercase tracking-widest">Occupied</div><div class="text-xl font-bold ${textPrimary}">${stats.occupied}</div></div>
                        </div>
                        <div class="rounded-2xl border ${cardBg} p-5 flex items-center gap-4 shadow-sm">
                            <div class="size-12 rounded-2xl bg-emerald-500/10 flex items-center justify-center shrink-0"><i data-lucide="trending-up" class="size-6 text-emerald-500"></i></div>
                            <div><div class="text-[10px] font-bold text-muted-foreground uppercase tracking-widest">Occupancy</div><div class="text-xl font-bold ${textPrimary}">${stats.rate}%</div></div>
                        </div>
                        <div class="rounded-2xl border ${cardBg} p-5 flex items-center gap-4 shadow-sm">
                            <div class="size-12 rounded-2xl bg-purple-500/10 flex items-center justify-center shrink-0"><i data-lucide="map-pin" class="size-6 text-purple-500"></i></div>
                            <div><div class="text-[10px] font-bold text-muted-foreground uppercase tracking-widest">Active Zones</div><div class="text-xl font-bold ${textPrimary}">${state.zones.length}</div></div>
                        </div>
                        <div class="rounded-2xl border ${cardBg} p-5 flex items-center gap-4 shadow-sm">
                            <div class="size-12 rounded-2xl bg-orange-500/10 flex items-center justify-center shrink-0"><i data-lucide="activity" class="size-6 text-orange-500"></i></div>
                            <div><div class="text-[10px] font-bold text-muted-foreground uppercase tracking-widest">Vehicles</div><div class="text-xl font-bold ${textPrimary}">${parkedVehicles.length}</div></div>
                        </div>
                    </div>

                    <div class="grid grid-cols-2 gap-8 mb-8">
                        <div class="rounded-[2rem] border ${cardBg} p-8 shadow-sm">
                            <h2 class="text-xl font-bold ${textPrimary} mb-8">Weekly Allocations</h2>
                            <div class="h-80"><canvas id="weeklyChart"></canvas></div>
                        </div>
                        <div class="rounded-[2rem] border ${cardBg} p-8 shadow-sm">
                            <h2 class="text-xl font-bold ${textPrimary} mb-8">Vehicle Types</h2>
                            <div class="h-80 flex items-center justify-center"><canvas id="vehiclePieChart"></canvas></div>
                        </div>
                    </div>

                    <div class="rounded-[2rem] border ${cardBg} p-8 mb-8 shadow-sm">
                        <h2 class="text-xl font-bold ${textPrimary} mb-8">Zone Occupancy</h2>
                        <div class="h-96"><canvas id="zoneBarChart"></canvas></div>
                    </div>

                    <div class="rounded-[2rem] border ${cardBg} p-8 shadow-sm">
                        <div class="flex items-center justify-between mb-8">
                            <h2 class="text-xl font-bold ${textPrimary}">Currently Parked Vehicles</h2>
                            <button onclick="setView('vehicles')" class="text-sm font-semibold text-blue-500 hover:text-blue-400">View All →</button>
                        </div>
                        ${renderVehicleTable(parkedVehicles.slice(0, 5))}
                    </div>
                </div>
            `;
        }

        function getVehiclesHTML() {
            const textPrimary = 'text-foreground';
            const textMuted = 'text-muted-foreground';
            const cardBg = 'bg-card border-border';
            const parkedSlots = state.slots.filter(s => s.status === 'occupied');

            return `
                <div class="p-8">
                    <div class="mb-8 text-left">
                        <h1 class="text-3xl font-bold ${textPrimary}">Parked Vehicles</h1>
                        <p class="${textMuted} mt-1">Full detailed registry of every vehicle currently in the facility.</p>
                    </div>

                    <div class="rounded-[2rem] border ${cardBg} p-8 shadow-sm min-h-[500px]">
                        <div class="flex items-center justify-between mb-8">
                            <div class="flex items-center gap-3">
                                <h2 class="text-xl font-bold ${textPrimary}">Live Registry</h2>
                                <span class="text-xs px-2.5 py-1 rounded-full font-bold bg-blue-600/20 text-blue-500">${parkedSlots.length} Vehicles</span>
                            </div>
                        </div>
                        ${parkedSlots.length === 0 ? `
                            <div class="flex flex-col items-center justify-center py-20 text-muted-foreground opacity-30">
                                <i data-lucide="car" class="size-16 mb-4"></i>
                                <p class="text-lg font-bold">No vehicles currently parked</p>
                            </div>
                        ` : renderVehicleTable(parkedSlots)}
                    </div>
                </div>
            `;
        }

        function renderVehicleTable(slots) {
            const textPrimary = 'text-foreground';
            const textMuted = 'text-muted-foreground';
            
            return `
                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead>
                            <tr class="text-left border-b border-border">
                                <th class="pb-4 text-[10px] font-bold text-muted-foreground uppercase tracking-widest">Slot</th>
                                <th class="pb-4 text-[10px] font-bold text-muted-foreground uppercase tracking-widest">License Plate</th>
                                <th class="pb-4 text-[10px] font-bold text-muted-foreground uppercase tracking-widest">Type</th>
                                <th class="pb-4 text-[10px] font-bold text-muted-foreground uppercase tracking-widest">Owner</th>
                                <th class="pb-4 text-[10px] font-bold text-muted-foreground uppercase tracking-widest">Entry Time</th>
                                <th class="pb-4 text-right text-[10px] font-bold text-muted-foreground uppercase tracking-widest">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-border/50">
                            ${slots.map(s => {
                                const v = s.vehicle || {};
                                return `
                                    <tr class="group hover:bg-muted/30 transition-colors">
                                        <td class="py-4 font-bold ${textPrimary}">${s.number}</td>
                                        <td class="py-4 font-mono font-bold text-blue-500">${v.licensePlate || 'N/A'}</td>
                                        <td class="py-4 text-sm font-semibold ${textPrimary}">${v.type || 'N/A'}</td>
                                        <td class="py-4 text-sm font-semibold ${textPrimary}">${v.owner || 'N/A'}</td>
                                        <td class="py-4 text-sm ${textMuted}">${v.entryTime || 'N/A'}</td>
                                        <td class="py-4 text-right">
                                            <button onclick="handleVehicleAction('${s.id}')" 
                                                class="px-4 py-1.5 rounded-lg bg-red-600/10 text-red-500 text-xs font-bold hover:bg-red-600 hover:text-white transition-all">
                                                Release
                                            </button>
                                        </td>
                                    </tr>
                                `;
                            }).join('')}
                        </tbody>
                    </table>
                </div>
            `;
        }

        function getEntryHTML() {
            const cardBg = 'bg-card border-border';
            const textMuted = 'text-muted-foreground';
            return `
                <div class="p-8 h-full overflow-y-auto">
                    <div class="max-w-3xl mx-auto py-10">
                        <div class="rounded-[2.5rem] border ${cardBg} overflow-hidden shadow-2xl slide-up">
                            <div class="bg-gradient-to-br from-blue-600 to-blue-800 p-10 flex items-center gap-6">
                                <div class="size-16 bg-white/20 backdrop-blur-md rounded-[2rem] flex items-center justify-center border border-white/20"><i data-lucide="log-in" class="size-8 text-white"></i></div>
                                <div><h1 class="text-3xl font-bold text-white">Enter Vehicle Details</h1><p class="text-blue-100 mt-1 font-medium">Assigning to Slot <span class="text-white font-bold">${state.selectedSlot?.number || '---'}</span></p></div>
                            </div>
                            <form id="entryForm" onsubmit="handleSubmitEntry(event)" class="p-10 space-y-8">
                                <div class="grid grid-cols-2 gap-8">
                                    <div class="space-y-3">
                                        <label class="block text-xs font-bold ${textMuted} uppercase tracking-[0.2em]">License Plate</label>
                                        <input type="text" name="licensePlate" required placeholder="ABC-1234" class="w-full px-4 py-4 rounded-2xl border border-border bg-background font-semibold">
                                    </div>
                                    <div class="space-y-3">
                                        <label class="block text-xs font-bold ${textMuted} uppercase tracking-[0.2em]">Vehicle Type</label>
                                        <select name="type" class="w-full px-4 py-4 rounded-2xl border border-border bg-background font-semibold appearance-none">
                                            ${VEHICLE_TYPES.map(t => `<option>${t}</option>`).join('')}
                                        </select>
                                    </div>
                                </div>
                                <div class="space-y-3"><label class="block text-xs font-bold ${textMuted} uppercase tracking-[0.2em]">Owner Name</label><input type="text" name="owner" required placeholder="John Doe" class="w-full px-4 py-4 rounded-2xl border border-border bg-background font-semibold"></div>
                                <div class="grid grid-cols-2 gap-8">
                                    <div class="space-y-3"><label class="block text-xs font-bold ${textMuted} uppercase tracking-[0.2em]">Phone Number</label><input type="tel" name="phone" required placeholder="+1 234-567-8900" class="w-full px-4 py-4 rounded-2xl border border-border bg-background font-semibold"></div>
                                    <div class="space-y-3"><label class="block text-xs font-bold ${textMuted} uppercase tracking-[0.2em]">Email Address</label><input type="email" name="email" required placeholder="owner@example.com" class="w-full px-4 py-4 rounded-2xl border border-border bg-background font-semibold"></div>
                                </div>
                                <div class="flex gap-4 pt-6"><button type="button" onclick="handleCancelEntry()" class="flex-1 py-4 rounded-2xl bg-muted font-bold hover:bg-accent transition-all">Cancel</button><button type="submit" class="flex-1 py-4 bg-blue-600 text-white rounded-2xl font-bold shadow-xl">Confirm Entry</button></div>
                            </form>
                        </div>
                    </div>
                </div>
            `;
        }

        // --- Interaction Handlers ---

        function handleVehicleAction(slotId) {
            state.selectedSlot = state.slots.find(s => s.id === slotId);
            performAction('release');
        }

        function scrollToZone(idx) {
            const container = document.getElementById('dashScrollContainer');
            if (container) {
                const width = container.offsetWidth;
                anime({
                    targets: container,
                    scrollLeft: idx * width,
                    duration: 600,
                    easing: 'easeOutQuart'
                });
            }
            state.dashActiveZoneIdx = idx;
            updateDashUI();
        }

        function handleDashScroll(el) {
            const index = Math.round(el.scrollLeft / el.offsetWidth);
            if (state.dashActiveZoneIdx !== index) {
                state.dashActiveZoneIdx = index;
                updateDashUI();
            }
        }

        function setActiveZone(zoneId) {
            state.activeZoneId = zoneId;
            render();
        }

        function handleSlotClick(slotId) {
            state.selectedSlot = state.slots.find(s => s.id === slotId);
            state.reserveStep = false;
            openActionModal();
        }

        function openActionModal() {
            document.getElementById('modal-overlay').classList.remove('hidden');
            const modal = document.getElementById('action-modal');
            modal.classList.remove('hidden');
            renderActionModal();
        }

        function closeAllModals() {
            document.getElementById('modal-overlay').classList.add('hidden');
            document.getElementById('action-modal').classList.add('hidden');
            document.getElementById('new-zone-modal').classList.add('hidden');
            state.selectedSlot = null;
            state.reserveStep = false;
        }

        function renderActionModal() {
            const slot = state.selectedSlot;
            const content = document.getElementById('action-modal-content');
            const textPrimary = 'text-foreground';
            const textMuted = 'text-muted-foreground';
            const tabIdle = state.isLight ? 'bg-gray-100 text-gray-700 hover:bg-gray-200' : 'bg-[#1a2540] text-gray-300 hover:bg-[#243154]';

            let html = `
                <div class="flex items-center justify-between mb-6">
                    <div>
                        <h2 class="text-xl font-bold ${textPrimary}">${state.reserveStep ? 'Reserve Slot' : 'Slot'} ${slot.number}</h2>
                        <p class="text-sm ${textMuted} font-semibold uppercase tracking-widest">${slot.status}</p>
                    </div>
                    <button onclick="closeAllModals()" class="p-2 rounded-lg hover:bg-muted transition-colors"><i data-lucide="x" class="size-5"></i></button>
                </div>
            `;

            if (!state.reserveStep && slot.vehicle) {
                html += `
                    <div class="mb-6 p-5 rounded-2xl bg-muted border border-border space-y-3 text-left">
                        <div class="flex items-center gap-3"><i data-lucide="car" class="size-4 text-blue-500"></i><span class="text-sm font-bold ${textPrimary}">${slot.vehicle.licensePlate}</span></div>
                        <div class="flex items-center gap-3"><i data-lucide="user" class="size-4 text-emerald-500"></i><span class="text-sm font-semibold ${textPrimary}">${slot.vehicle.owner}</span></div>
                    </div>
                `;
            }

            html += `<div class="space-y-3">`;
            if (state.reserveStep) {
                html += `
                    <button onclick="performAction('reserve', {reservedBy: 'staff'})" class="w-full flex items-center gap-4 p-4 rounded-2xl border-2 border-border hover:border-blue-500 transition-all text-left">
                        <div class="size-10 rounded-xl bg-blue-600/10 flex items-center justify-center"><i data-lucide="shield-check" class="size-5 text-blue-500"></i></div>
                        <div><div class="text-sm font-bold ${textPrimary}">Staff</div></div>
                    </button>
                    <button onclick="state.reserveStep=false; renderActionModal();" class="w-full py-4 rounded-2xl ${tabIdle} font-bold mt-2">← Back</button>
                `;
            } else if (slot.status === 'available') {
                html += `
                    <button onclick="handleEnterVehicle()" class="w-full py-4 bg-blue-600 text-white rounded-2xl font-bold">Enter Vehicle</button>
                    <button onclick="state.reserveStep=true; renderActionModal();" class="w-full py-4 bg-amber-500 text-white rounded-2xl font-bold">Reserve</button>
                `;
            } else if (slot.status === 'occupied') {
                html += `<button onclick="performAction('release')" class="w-full py-4 bg-red-600 text-white rounded-2xl font-bold">Release Vehicle</button>`;
            } else {
                html += `<button onclick="performAction('clear')" class="w-full py-4 bg-emerald-600 text-white rounded-2xl font-bold">Clear Status</button>`;
            }
            html += `<button onclick="closeAllModals()" class="w-full py-4 rounded-2xl ${tabIdle} font-bold mt-2">Cancel</button></div>`;
            content.innerHTML = html;
            lucide.createIcons();
        }

        async function performAction(action, extra = {}) {
            if (!state.selectedSlot) return;
            const payload = { action, slotId: state.selectedSlot.id, ...extra };
            try {
                const response = await fetch('/api/action', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(payload)
                });
                const data = await response.json();
                if (data.success) {
                    state.zones = data.zones;
                    state.slots = data.slots;
                    closeAllModals();
                    render();
                }
            } catch (err) { alert("Action failed: " + err); }
        }

        function handleEnterVehicle() {
            document.getElementById('modal-overlay').classList.add('hidden');
            document.getElementById('action-modal').classList.add('hidden');
            setView('entry');
        }

        function handleCancelEntry() {
            setView(state.previousView);
            state.selectedSlot = null;
        }

        async function handleSubmitEntry(event) {
            event.preventDefault();
            if (!state.selectedSlot) return;
            const formData = new FormData(event.target);
            const vehicle = Object.fromEntries(formData.entries());
            try {
                const response = await fetch('/api/action', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ action: 'enter', slotId: state.selectedSlot.id, vehicle })
                });
                const data = await response.json();
                if (data.success) {
                    state.zones = data.zones;
                    state.slots = data.slots;
                    state.selectedSlot = null;
                    setView('dashboard');
                }
            } catch (err) { alert("Entry failed: " + err); }
        }

        function handleNewEntry() {
            const firstAvailable = state.slots.find(s => s.status === 'available');
            if (firstAvailable) { state.selectedSlot = firstAvailable; setView('entry'); }
            else { alert('No available slots found!'); }
        }

        async function handleCreateZone() {
            const name = document.getElementById('newZoneNameInput').value.trim();
            const slotCount = parseInt(document.getElementById('newZoneSlotCountInput').value) || 12;
            if (!name) return;
            try {
                const response = await fetch('/api/zones/create', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ name, slotCount })
                });
                const data = await response.json();
                if (data.success) {
                    state.zones = data.zones;
                    state.slots = data.slots;
                    state.activeZoneId = state.zones[state.zones.length - 1].id;
                    closeNewZoneModal();
                    render();
                }
            } catch (err) { alert("Failed: " + err); }
        }

        function getSlotGradient(status) {
            switch(status) {
                case 'occupied': return 'bg-gradient-to-br from-red-500 to-red-600';
                case 'reserved': return 'bg-gradient-to-br from-amber-400 to-amber-500';
                case 'maintenance': return 'bg-gradient-to-br from-orange-500 to-orange-600';
                default: return 'bg-gradient-to-br from-emerald-500 to-emerald-600';
            }
        }

        function getSlotIcon(status) {
            switch(status) {
                case 'occupied': return '<i data-lucide="car" class="size-6"></i>';
                case 'reserved': return '<i data-lucide="bookmark" class="size-6"></i>';
                case 'maintenance': return '<i data-lucide="wrench" class="size-6"></i>';
                default: return '<span class="text-xl font-bold">P</span>';
            }
        }

        function updateDashboardSearch() {
            const container = document.getElementById('dashSearchResults');
            if (!state.dashSearch.trim()) { container.classList.add('hidden'); return; }
            const query = state.dashSearch.trim().toLowerCase();
            const results = state.slots.filter(s => s.vehicle && s.vehicle.licensePlate.toLowerCase().includes(query));
            let html = `<div class="flex items-center gap-2 mb-4 font-bold text-sm">Search Results: ${results.length} matches <button onclick="state.dashSearch='';render();" class="ml-auto text-red-500">Clear</button></div>`;
            if (results.length === 0) { html += `<p class="text-sm text-muted-foreground">No matches found.</p>`; }
            else { html += `<div class="space-y-2">${results.map(s => `<button onclick="handleSlotClick('${s.id}')" class="w-full p-4 border border-border rounded-xl flex justify-between"><span>${s.vehicle.licensePlate}</span><span class="text-muted-foreground">${s.number}</span></button>`).join('')}</div>`; }
            container.innerHTML = html;
            container.classList.remove('hidden');
            lucide.createIcons();
        }

        let charts = {};
        function initCharts() {
            const axisColor = state.isLight ? '#6b7280' : '#9ca3af';
            const gridColor = state.isLight ? '#e5e7eb' : '#1f2a44';
            const commonOptions = { responsive: true, maintainAspectRatio: false, scales: { x: { ticks: { color: axisColor } }, y: { grid: { color: gridColor }, ticks: { color: axisColor } } } };

            const weeklyCtx = document.getElementById('weeklyChart');
            if (weeklyCtx) {
                if (charts.weekly) charts.weekly.destroy();
                charts.weekly = new Chart(weeklyCtx, { type: 'line', data: { labels: ['M','T','W','T','F','S','S'], datasets: [{ label: 'Allocations', data: [45,59,80,81,56,55,40], borderColor: '#3b82f6', fill: true }] }, options: commonOptions });
            }

            const pieCtx = document.getElementById('vehiclePieChart');
            if (pieCtx) {
                const counts = {};
                state.slots.forEach(s => { if (s.vehicle) counts[s.vehicle.type] = (counts[s.vehicle.type] || 0) + 1; });
                if (charts.pie) charts.pie.destroy();
                charts.pie = new Chart(pieCtx, { type: 'doughnut', data: { labels: Object.keys(counts), datasets: [{ data: Object.values(counts), backgroundColor: PIE_COLORS }] } });
            }

            const barCtx = document.getElementById('zoneBarChart');
            if (barCtx) {
                const stats = calculateZoneStats();
                if (charts.bar) charts.bar.destroy();
                charts.bar = new Chart(barCtx, { type: 'bar', data: { labels: stats.map(z=>z.name), datasets: [{ label: 'Occ', data: stats.map(z=>z.occupied), backgroundColor: '#ef4444' },{ label: 'Free', data: stats.map(z=>z.available), backgroundColor: '#10b981' }] }, options: { ...commonOptions, scales: { x: { stacked: true }, y: { stacked: true } } } });
            }
        }

        init();
    </script>
</body>
</html>
