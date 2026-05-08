<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ParkPulse - Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
        body { font-family: 'Inter', sans-serif; }
        .snap-x { scroll-snap-type: x mandatory; }
        .snap-start { scroll-snap-align: start; }
        [scrollbar-width:none] { scrollbar-width: none; }
        ::-webkit-scrollbar { display: none; }
    </style>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        background: '#0b1220',
                        sidebar: '#111a2e',
                        card: '#111a2e',
                        border: '#1f2a44',
                        inner: '#0b1220',
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-[#0b1220] text-white">
    <div id="app" class="h-screen flex overflow-hidden">
        <!-- Sidebar -->
        <aside class="w-64 shrink-0 border-r border-[#1f2a44] bg-[#111a2e] flex flex-col">
            <div class="p-6 flex items-center gap-3">
                <div class="size-9 bg-blue-600 rounded-xl flex items-center justify-center shadow-lg">
                    <i data-lucide="car" class="size-5 text-white"></i>
                </div>
                <span class="text-xl font-bold text-white">ParkPulse</span>
            </div>

            <nav class="flex-1 px-4 py-6 space-y-2">
                <!-- Top Level Parking Slot (Acts as Dashboard) -->
                <div>
                    <button onclick="toggleParkingExpand(); setView('dashboard')" class="nav-item w-full flex items-center justify-between px-4 py-3 rounded-xl transition-colors hover:bg-white/5 text-gray-400 group" id="nav-dashboard">
                        <div class="flex items-center gap-3">
                            <i data-lucide="parking-square" class="size-5"></i>
                            <span class="font-medium">Parking Slots</span>
                        </div>
                        <i data-lucide="chevron-down" id="parking-chevron" class="size-4 transition-transform duration-200"></i>
                    </button>
                    
                    <!-- Expanded Sub-items -->
                    <div id="parking-sub-items" class="mt-1 ml-4 pl-4 border-l border-[#1f2a44] space-y-1 hidden">
                        <button onclick="setView('dashboard')" class="nav-sub-item w-full flex items-center gap-3 px-4 py-2 rounded-lg text-sm transition-colors hover:bg-white/5 text-gray-500" id="nav-dashboard-view">
                            <i data-lucide="bar-chart-3" class="size-4"></i>
                            <span>Dashboard</span>
                        </button>
                        <button onclick="setView('slots')" class="nav-sub-item w-full flex items-center gap-3 px-4 py-2 rounded-lg text-sm transition-colors hover:bg-white/5 text-gray-500" id="nav-slots">
                            <i data-lucide="map-pin" class="size-4"></i>
                            <span>Slot Map</span>
                        </button>
                        <button onclick="setView('analytics')" class="nav-sub-item w-full flex items-center gap-3 px-4 py-2 rounded-lg text-sm transition-colors hover:bg-white/5 text-gray-500" id="nav-analytics">
                            <i data-lucide="activity" class="size-4"></i>
                            <span>Analytics</span>
                        </button>
                        <!-- Selected Slot Detail Section (Dynamic) -->
                        <div id="selected-slot-nav" class="hidden mt-3 pt-3 border-t border-[#1f2a44]">
                            <button onclick="setView('slot-detail')" class="nav-sub-item w-full flex items-center gap-3 px-4 py-2 rounded-lg text-sm transition-colors bg-blue-600/20 text-blue-400 hover:bg-blue-600/30" id="nav-selected-slot">
                                <i data-lucide="info" class="size-4"></i>
                                <span id="selected-slot-label">Slot Details</span>
                            </button>
                        </div>
                    </div>
                </div>
            </nav>

            <div class="p-6 border-t border-[#1f2a44]">
                <div class="flex items-center gap-3 px-4 py-3 bg-[#0b1220] rounded-xl border border-[#1f2a44]">
                    <div class="size-8 rounded-full bg-blue-600/20 flex items-center justify-center">
                        <i data-lucide="user" class="size-4 text-blue-500"></i>
                    </div>
                    <div class="flex-1 min-w-0">
                        <div class="text-sm font-medium text-white truncate">Admin User</div>
                        <div class="text-[10px] text-gray-500 uppercase tracking-wider">Super Admin</div>
                    </div>
                </div>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="flex-1 overflow-y-auto bg-[#0b1220]">
            <div id="view-dashboard" class="view hidden"></div>
            <div id="view-slots" class="view hidden"></div>
            <div id="view-analytics" class="view hidden"></div>
            <div id="view-entry" class="view hidden"></div>
            <div id="view-slot-detail" class="view hidden"></div>
            <div id="view-success" class="view hidden"></div>
        </main>
    </div>

    <!-- Modals -->
    <div id="slot-modal" class="fixed inset-0 z-50 flex items-center justify-center hidden">
        <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" onclick="closeModal()"></div>
        <div class="relative w-full max-w-md bg-[#111a2e] border border-[#1f2a44] rounded-3xl shadow-2xl p-6 overflow-hidden">
            <div id="modal-content"></div>
        </div>
    </div>

    <script>
        let currentView = 'dashboard';
        let zones = [];
        let slots = [];
        let selectedSlot = null;
        let activeZoneId = 'A';
        let dashActiveZoneIdx = 0;

        async function fetchData() {
            const response = await fetch('/api/data');
            const data = await response.json();
            zones = data.zones;
            slots = data.slots;
            renderView();
        }

        function setView(view) {
            currentView = view;
            renderView();
        }

        function renderView() {
            document.querySelectorAll('.view').forEach(v => v.classList.add('hidden'));
            document.querySelectorAll('.nav-item').forEach(v => v.classList.replace('bg-blue-600', 'hover:bg-white/5'));
            document.querySelectorAll('.nav-item').forEach(v => v.classList.replace('text-white', 'text-gray-400'));
            
            const activeNav = document.getElementById('nav-' + currentView);
            if (activeNav) {
                activeNav.classList.replace('hover:bg-white/5', 'bg-blue-600');
                activeNav.classList.replace('text-gray-400', 'text-white');
            }

            const viewContainer = document.getElementById('view-' + currentView);
            viewContainer.classList.remove('hidden');

            if (currentView === 'dashboard') renderDashboard();
            else if (currentView === 'slots') renderSlots();
            else if (currentView === 'analytics') renderAnalytics();
            else if (currentView === 'entry') renderEntry();
            else if (currentView === 'slot-detail') renderSlotDetail();
            else if (currentView === 'success') renderSuccess();

            lucide.createIcons();
        }

        function renderSuccess() {
            let html = \`
                <div class="p-8 h-full flex items-center justify-center">
                    <div class="max-w-md w-full bg-[#111a2e] border border-[#1f2a44] rounded-[2rem] p-10 text-center shadow-2xl">
                        <div class="size-20 bg-emerald-500/20 rounded-full flex items-center justify-center mx-auto mb-6">
                            <i data-lucide="check-circle-2" class="size-10 text-emerald-500"></i>
                        </div>
                        <h1 class="text-3xl font-bold text-white mb-2">Success!</h1>
                        <p class="text-gray-400 mb-8">The vehicle has been successfully registered and assigned to Slot \${selectedSlot.number}.</p>
                        
                        <div class="bg-[#0b1220] border border-[#1f2a44] rounded-2xl p-6 mb-8 text-left">
                            <div class="flex justify-between mb-2">
                                <span class="text-gray-500 text-sm font-bold uppercase">Plate</span>
                                <span class="text-white font-bold">\${selectedSlot.vehicle ? selectedSlot.vehicle.licensePlate : '---'}</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-500 text-sm font-bold uppercase">Slot</span>
                                <span class="text-blue-500 font-bold">\${selectedSlot.number}</span>
                            </div>
                        </div>

                        <button onclick="setView('dashboard')" class="w-full py-4 bg-blue-600 hover:bg-blue-700 text-white rounded-2xl font-bold transition-all shadow-lg shadow-blue-600/20">
                            Back to Dashboard
                        </button>
                    </div>
                </div>
            \`;
            document.getElementById('view-success').innerHTML = html;
        }

        function renderDashboard() {
            const stats = calculateStats();
            const zoneStats = calculateZoneStats();
            
            let html = \`
                <div class="p-8">
                    <div class="flex items-center justify-between mb-8 gap-4">
                        <div>
                            <h1 class="text-3xl font-bold text-white">Dashboard</h1>
                            <p class="text-gray-400 mt-1">Real-time overview of your parking facility</p>
                        </div>
                        <div class="flex items-center gap-3">
                            <!-- Search Bar for Vehicle Number Plate -->
                            <div class="relative">
                                <i data-lucide="search" class="absolute left-4 top-1/2 -translate-y-1/2 size-5 text-gray-500"></i>
                                <input type="text" id="dashboardSearch" placeholder="Search by plate…" 
                                    class="pl-12 pr-4 py-2 bg-[#111a2e] border border-[#1f2a44] text-white rounded-full focus:outline-none focus:ring-2 focus:ring-blue-600 focus:border-transparent w-64 transition-all"
                                    onkeyup="filterSearchResults(this.value)">
                            </div>
                            <button onclick="handleNewEntry()" class="flex items-center gap-2 px-6 py-3 bg-blue-600 hover:bg-blue-700 text-white rounded-full transition-all shadow-lg hover:scale-105 active:scale-95 whitespace-nowrap">
                                <i data-lucide="plus" class="size-5"></i>
                                <span class="font-medium">New Entry</span>
                            </button>
                        </div>
                    </div>

                    <!-- Search Results Section (Hidden by default) -->
                    <div id="searchResultsContainer" class="hidden mb-8 bg-[#111a2e] border border-[#1f2a44] p-6 rounded-2xl">
                        <div class="flex items-center gap-2 mb-4">
                            <i data-lucide="search" class="size-5 text-blue-500"></i>
                            <h3 class="text-lg font-bold text-white">Search Results</h3>
                            <span id="resultCount" class="text-sm text-gray-400 ml-auto">0 matches</span>
                        </div>
                        <div id="searchResults" class="space-y-2"></div>
                    </div>

                    <!-- Quick Stats -->
                    <div class="grid grid-cols-4 gap-6 mb-8">
                        <div class="bg-[#111a2e] border border-[#1f2a44] p-5 rounded-3xl">
                            <div class="text-gray-400 text-sm font-medium">Total Slots</div>
                            <div class="text-2xl font-bold text-white mt-1">\${stats.total}</div>
                        </div>
                        <div class="bg-[#111a2e] border border-[#1f2a44] p-5 rounded-3xl">
                            <div class="text-gray-400 text-sm font-medium">Available</div>
                            <div class="text-2xl font-bold text-emerald-500 mt-1">\${stats.available}</div>
                        </div>
                        <div class="bg-[#111a2e] border border-[#1f2a44] p-5 rounded-3xl">
                            <div class="text-gray-400 text-sm font-medium">Occupied</div>
                            <div class="text-2xl font-bold text-red-500 mt-1">\${stats.occupied}</div>
                        </div>
                        <div class="bg-[#111a2e] border border-[#1f2a44] p-5 rounded-3xl">
                            <div class="text-gray-400 text-sm font-medium">Occupancy</div>
                            <div class="text-2xl font-bold text-blue-500 mt-1">\${stats.rate}%</div>
                        </div>
                    </div>

                    <!-- Zones Overview -->
                    <div class="bg-[#111a2e] border border-[#1f2a44] p-8 rounded-[2rem] mb-8">
                        <h2 class="text-xl font-bold text-white mb-6">Zones Overview</h2>
                        <div class="grid grid-cols-4 gap-6">
                            \${zoneStats.map(z => \`
                                <div class="bg-[#0b1220] border border-[#1f2a44] p-5 rounded-2xl">
                                    <div class="flex justify-between items-center mb-4">
                                        <div class="flex items-center gap-2">
                                            <i data-lucide="map-pin" class="size-4 text-blue-500"></i>
                                            <span class="font-semibold text-white">\${z.name}</span>
                                        </div>
                                        <span class="text-xs font-bold text-gray-500">\${z.occupied}/\${z.total}</span>
                                    </div>
                                    <div class="h-2 bg-[#1a2540] rounded-full overflow-hidden mb-3">
                                        <div class="h-full bg-blue-600" style="width: \${(z.occupied/z.total)*100}%"></div>
                                    </div>
                                    <div class="flex justify-between text-[10px] font-bold uppercase tracking-wider">
                                        <span class="text-emerald-500">\${z.available} Free</span>
                                        <span class="text-red-500">\${z.occupied} Occ</span>
                                    </div>
                                </div>
                            \`).join('')}
                        </div>
                    </div>

                    <!-- Visual Map -->
                    <div class="bg-[#111a2e] border border-[#1f2a44] p-8 rounded-[2rem]">
                        <div class="flex items-center justify-between mb-8">
                            <h2 class="text-xl font-bold text-white">Live Slot Map</h2>
                            <div class="flex items-center gap-6">
                                <div class="flex items-center gap-2">
                                    <span class="size-3 rounded-full bg-emerald-500"></span>
                                    <span class="text-xs font-medium text-gray-400">Available</span>
                                </div>
                                <div class="flex items-center gap-2">
                                    <span class="size-3 rounded-full bg-red-500"></span>
                                    <span class="text-xs font-medium text-gray-400">Occupied</span>
                                </div>
                                <div class="flex items-center gap-2">
                                    <span class="size-3 rounded-full bg-amber-400"></span>
                                    <span class="text-xs font-medium text-gray-400">Reserved</span>
                                </div>
                            </div>
                        </div>

                        <div class="flex items-center gap-4 mb-6">
                            \${zones.map((z, idx) => \`
                                <button onclick="scrollToZone(\${idx})" class="px-4 py-2 rounded-xl text-sm font-medium transition-all \${dashActiveZoneIdx === idx ? 'bg-blue-600 text-white' : 'bg-[#1a2540] text-gray-400 hover:bg-[#243154]'}">
                                    \${z.name}
                                </button>
                            \`).join('')}
                        </div>

                        <div id="dash-scroll" class="flex overflow-x-auto snap-x snap-mandatory [scrollbar-width:none]">
                            \${zones.map(z => \`
                                <div class="min-w-full snap-start grid grid-cols-6 gap-3 pr-4">
                                    \${slots.filter(s => s.zoneId === z.id).map(s => \`
                                        <button onclick="handleSlotClick('\${s.id}')" class="h-16 rounded-2xl text-white font-bold transition-transform hover:scale-105 \${getSlotColor(s.status)}">
                                            \${s.number}
                                        </button>
                                    \`).join('')}
                                </div>
                            \`).join('')}
                        </div>
                    </div>
                </div>
            \`;
            document.getElementById('view-dashboard').innerHTML = html;
        }

        function renderSlots() {
            const zoneSlots = slots.filter(s => s.zoneId === activeZoneId);
            let html = \`
                <div class="p-8">
                    <div class="flex items-center justify-between mb-8">
                        <div>
                            <h1 class="text-3xl font-bold text-white">Parking Slots</h1>
                            <p class="text-gray-400 mt-1">Manage individual slot statuses and information</p>
                        </div>
                    </div>

                    <div class="bg-[#111a2e] border border-[#1f2a44] p-8 rounded-[2rem]">
                        <div class="flex gap-2 mb-8 bg-[#0b1220] p-1.5 rounded-2xl w-fit">
                            \${zones.map(z => \`
                                <button onclick="activeZoneId='\${z.id}'; renderSlots();" class="px-6 py-2.5 rounded-xl text-sm font-semibold transition-all \${activeZoneId === z.id ? 'bg-blue-600 text-white shadow-lg' : 'text-gray-500 hover:text-gray-300'}">
                                    \${z.name}
                                </button>
                            \`).join('')}
                        </div>

                        <div class="grid grid-cols-6 gap-6">
                            \${zoneSlots.map(s => \`
                                <button onclick="handleSlotClick('\${s.id}')" class="h-32 rounded-[2rem] flex flex-col items-center justify-center text-white gap-2 transition-all hover:scale-105 shadow-xl \${getSlotColor(s.status)}">
                                    \${getSlotIcon(s.status)}
                                    <span class="text-sm font-bold">\${s.number}</span>
                                    <span class="text-[10px] font-bold uppercase opacity-80">\${s.status}</span>
                                </button>
                            \`).join('')}
                        </div>
                    </div>
                </div>
            \`;
            document.getElementById('view-slots').innerHTML = html;
        }

        function renderAnalytics() {
            let html = \`
                <div class="p-8">
                    <div class="mb-8">
                        <h1 class="text-3xl font-bold text-white">Analytics</h1>
                        <p class="text-gray-400 mt-1">Visual data and performance metrics</p>
                    </div>

                    <div class="grid grid-cols-2 gap-8">
                        <div class="bg-[#111a2e] border border-[#1f2a44] p-8 rounded-[2rem]">
                            <h3 class="text-lg font-bold text-white mb-6">Occupancy Trend</h3>
                            <canvas id="occupancyChart"></canvas>
                        </div>
                        <div class="bg-[#111a2e] border border-[#1f2a44] p-8 rounded-[2rem]">
                            <h3 class="text-lg font-bold text-white mb-6">Vehicle Types</h3>
                            <canvas id="vehicleTypeChart"></canvas>
                        </div>
                    </div>
                </div>
            \`;
            document.getElementById('view-analytics').innerHTML = html;
            setTimeout(initCharts, 0);
        }

        function renderEntry() {
            let html = \`
                <div class="p-8">
                    <div class="max-w-2xl mx-auto">
                        <div class="bg-[#111a2e] border border-[#1f2a44] rounded-[2rem] overflow-hidden shadow-2xl">
                            <div class="bg-blue-600 p-8">
                                <h1 class="text-2xl font-bold text-white">New Vehicle Entry</h1>
                                <p class="text-blue-100 mt-1">Assigning to Slot \${selectedSlot.number}</p>
                            </div>
                            <form onsubmit="submitEntry(event)" class="p-8 space-y-6">
                                <div class="grid grid-cols-2 gap-6">
                                    <div class="space-y-2">
                                        <label class="text-xs font-bold text-gray-400 uppercase tracking-widest">License Plate</label>
                                        <input type="text" name="licensePlate" required placeholder="ABC-1234" class="w-full bg-[#0b1220] border border-[#1f2a44] rounded-2xl px-5 py-4 focus:ring-2 focus:ring-blue-600 outline-none text-white">
                                    </div>
                                    <div class="space-y-2">
                                        <label class="text-xs font-bold text-gray-400 uppercase tracking-widest">Vehicle Type</label>
                                        <select name="type" class="w-full bg-[#0b1220] border border-[#1f2a44] rounded-2xl px-5 py-4 focus:ring-2 focus:ring-blue-600 outline-none text-white appearance-none">
                                            <option>Sedan</option><option>SUV</option><option>Hatchback</option><option>Truck</option><option>Motorcycle</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="space-y-2">
                                    <label class="text-xs font-bold text-gray-400 uppercase tracking-widest">Owner Name</label>
                                    <input type="text" name="owner" required placeholder="John Doe" class="w-full bg-[#0b1220] border border-[#1f2a44] rounded-2xl px-5 py-4 focus:ring-2 focus:ring-blue-600 outline-none text-white">
                                </div>
                                <div class="grid grid-cols-2 gap-6">
                                    <div class="space-y-2">
                                        <label class="text-xs font-bold text-gray-400 uppercase tracking-widest">Phone</label>
                                        <input type="tel" name="phone" required placeholder="+1 234-567-8900" class="w-full bg-[#0b1220] border border-[#1f2a44] rounded-2xl px-5 py-4 focus:ring-2 focus:ring-blue-600 outline-none text-white">
                                    </div>
                                    <div class="space-y-2">
                                        <label class="text-xs font-bold text-gray-400 uppercase tracking-widest">Email</label>
                                        <input type="email" name="email" required placeholder="owner@example.com" class="w-full bg-[#0b1220] border border-[#1f2a44] rounded-2xl px-5 py-4 focus:ring-2 focus:ring-blue-600 outline-none text-white">
                                    </div>
                                </div>
                                <div class="flex gap-4 pt-4">
                                    <button type="button" onclick="setView('dashboard')" class="flex-1 py-4 rounded-2xl bg-[#1a2540] text-gray-300 font-bold hover:bg-[#243154] transition-all">Cancel</button>
                                    <button type="submit" class="flex-1 py-4 rounded-2xl bg-blue-600 text-white font-bold hover:bg-blue-700 shadow-lg shadow-blue-600/20 transition-all">Confirm Entry</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            \`;
            document.getElementById('view-entry').innerHTML = html;
        }

        function renderSlotDetail() {
            if (!selectedSlot) {
                setView('dashboard');
                return;
            }

            const stats = calculateStats();
            const zoneStats = calculateZoneStats();
            
            const zone = zones.find(z => z.id === selectedSlot.zoneId);
            const zoneName = zone ? zone.name : selectedSlot.zoneId;
            
            let html = \`
                <div class="p-8">
                    <div class="flex items-center gap-4 mb-8">
                        <button onclick="closeSlotDetail()" class="p-2 hover:bg-[#1a2540] rounded-lg transition-colors">
                            <i data-lucide="arrow-left" class="size-6 text-gray-400 hover:text-white"></i>
                        </button>
                        <div>
                            <h1 class="text-3xl font-bold text-white">Slot \${selectedSlot.number}</h1>
                            <p class="text-gray-400 mt-1">\${zoneName} • Status: <span class="text-blue-400 font-semibold uppercase">\${selectedSlot.status}</span></p>
                        </div>
                    </div>

                    <div class="grid grid-cols-3 gap-8">
                        <div class="col-span-2 space-y-6">
                            <div class="bg-[#111a2e] border border-[#1f2a44] p-8 rounded-[2rem]">
                                <h2 class="text-xl font-bold text-white mb-6">Vehicle Information</h2>
                                \${selectedSlot.vehicle ? \`
                                    <div class="space-y-5">
                                        <div class="flex items-center gap-4 p-5 bg-[#0b1220] rounded-2xl">
                                            <i data-lucide="car" class="size-8 text-blue-500"></i>
                                            <div class="flex-1">
                                                <div class="text-sm font-bold text-gray-500 uppercase tracking-widest">License Plate</div>
                                                <div class="text-xl font-bold text-white">\${selectedSlot.vehicle.licensePlate}</div>
                                            </div>
                                        </div>
                                        <div class="grid grid-cols-2 gap-4">
                                            <div class="flex items-center gap-4 p-5 bg-[#0b1220] rounded-2xl">
                                                <i data-lucide="tag" class="size-8 text-emerald-500"></i>
                                                <div>
                                                    <div class="text-sm font-bold text-gray-500 uppercase tracking-widest">Vehicle Type</div>
                                                    <div class="text-lg font-bold text-white">\${selectedSlot.vehicle.type}</div>
                                                </div>
                                            </div>
                                            <div class="flex items-center gap-4 p-5 bg-[#0b1220] rounded-2xl">
                                                <i data-lucide="clock" class="size-8 text-orange-500"></i>
                                                <div>
                                                    <div class="text-sm font-bold text-gray-500 uppercase tracking-widest">Entry Time</div>
                                                    <div class="text-lg font-bold text-white">\${selectedSlot.vehicle.entryTime}</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="grid grid-cols-2 gap-4">
                                            <div class="flex items-center gap-4 p-5 bg-[#0b1220] rounded-2xl">
                                                <i data-lucide="user" class="size-8 text-purple-500"></i>
                                                <div>
                                                    <div class="text-sm font-bold text-gray-500 uppercase tracking-widest">Owner</div>
                                                    <div class="text-lg font-bold text-white">\${selectedSlot.vehicle.owner}</div>
                                                </div>
                                            </div>
                                            <div class="flex items-center gap-4 p-5 bg-[#0b1220] rounded-2xl">
                                                <i data-lucide="phone" class="size-8 text-cyan-500"></i>
                                                <div>
                                                    <div class="text-sm font-bold text-gray-500 uppercase tracking-widest">Phone</div>
                                                    <div class="text-lg font-bold text-white">\${selectedSlot.vehicle.phone}</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="flex items-center gap-4 p-5 bg-[#0b1220] rounded-2xl">
                                            <i data-lucide="mail" class="size-8 text-rose-500"></i>
                                            <div class="flex-1">
                                                <div class="text-sm font-bold text-gray-500 uppercase tracking-widest">Email</div>
                                                <div class="text-lg font-bold text-white break-all">\${selectedSlot.vehicle.email}</div>
                                            </div>
                                        </div>
                                        <div class="grid grid-cols-1 gap-4 pt-4">
                                            <button onclick="performAction('release')" class="w-full py-4 bg-red-600 hover:bg-red-700 text-white rounded-2xl font-bold transition-all shadow-lg shadow-red-600/20">
                                                <i data-lucide="log-out" class="inline size-5 mr-2"></i>Release Vehicle
                                            </button>
                                        </div>
                                    </div>
                                \` : \`
                                    <div class="text-center py-12">
                                        <i data-lucide="inbox" class="size-16 mx-auto text-gray-600 mb-4"></i>
                                        <p class="text-gray-400 mb-6">No vehicle parked in this slot</p>
                                        <button onclick="closeSlotDetail(); setView('entry')" class="px-6 py-3 bg-blue-600 hover:bg-blue-700 text-white rounded-2xl font-bold transition-all">
                                            <i data-lucide="plus" class="inline size-5 mr-2"></i>Park a Vehicle
                                        </button>
                                    </div>
                                \`}
                            </div>
                        </div>

                        <div class="space-y-6">
                            <div class="bg-[#111a2e] border border-[#1f2a44] p-6 rounded-[2rem]">
                                <h3 class="text-lg font-bold text-white mb-4">Facility Overview</h3>
                                <div class="space-y-3">
                                    <div class="bg-[#0b1220] p-4 rounded-xl">
                                        <div class="text-xs text-gray-500 font-bold uppercase tracking-widest">Total Slots</div>
                                        <div class="text-2xl font-bold text-white mt-1">\${stats.total}</div>
                                    </div>
                                    <div class="bg-[#0b1220] p-4 rounded-xl">
                                        <div class="text-xs text-gray-500 font-bold uppercase tracking-widest">Available</div>
                                        <div class="text-2xl font-bold text-emerald-500 mt-1">\${stats.available}</div>
                                    </div>
                                    <div class="bg-[#0b1220] p-4 rounded-xl">
                                        <div class="text-xs text-gray-500 font-bold uppercase tracking-widest">Occupied</div>
                                        <div class="text-2xl font-bold text-red-500 mt-1">\${stats.occupied}</div>
                                    </div>
                                    <div class="bg-[#0b1220] p-4 rounded-xl">
                                        <div class="text-xs text-gray-500 font-bold uppercase tracking-widest">Occupancy Rate</div>
                                        <div class="text-2xl font-bold text-blue-500 mt-1">\${stats.rate}%</div>
                                    </div>
                                </div>
                            </div>

                            <div class="bg-[#111a2e] border border-[#1f2a44] p-6 rounded-[2rem]">
                                <h3 class="text-lg font-bold text-white mb-4">Zone Distribution</h3>
                                <div class="space-y-2 max-h-60 overflow-y-auto">
                                    \${zoneStats.map(z => \`
                                        <div class="bg-[#0b1220] p-3 rounded-xl">
                                            <div class="flex items-center justify-between mb-2">
                                                <span class="text-sm font-semibold text-white">\${z.name}</span>
                                                <span class="text-xs text-gray-500">\${z.occupied}/\${z.total}</span>
                                            </div>
                                            <div class="h-2 bg-[#1a2540] rounded-full overflow-hidden">
                                                <div class="h-full bg-blue-600" style="width: \${(z.occupied/z.total)*100}%"></div>
                                            </div>
                                        </div>
                                    \`).join('')}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            \`;
            document.getElementById('view-slot-detail').innerHTML = html;
        }

        function closeSlotDetail() {
            selectedSlot = null;
            const selectedSlotNav = document.getElementById('selected-slot-nav');
            if (selectedSlotNav) {
                selectedSlotNav.classList.add('hidden');
            }
            setView('dashboard');
        }

        function filterSearchResults(query) {
            const searchContainer = document.getElementById('searchResultsContainer');
            const searchResults = document.getElementById('searchResults');
            const resultCount = document.getElementById('resultCount');
            
            if (!query.trim()) {
                searchContainer.classList.add('hidden');
                return;
            }

            const filtered = slots.filter(s => 
                s.vehicle && s.vehicle.licensePlate.toLowerCase().includes(query.toLowerCase())
            );

            if (filtered.length === 0) {
                searchResults.innerHTML = \`
                    <div class="text-center py-8 text-gray-500">
                        <i data-lucide="search" class="size-8 mx-auto mb-3 opacity-50"></i>
                        <p>No vehicles found matching "<span class="text-white font-semibold">\${query}</span>"</p>
                    </div>
                \`;
            } else {
                searchResults.innerHTML = filtered.map(slot => \`
                    <button onclick="handleSlotClick('\${slot.id}')" class="w-full flex items-center justify-between p-4 bg-[#0b1220] hover:bg-[#1a2540] rounded-xl transition-colors text-left border border-[#1f2a44]">
                        <div class="flex-1">
                            <div class="font-bold text-white">\${slot.vehicle.licensePlate}</div>
                            <div class="text-sm text-gray-400">Slot \${slot.number} • \${slot.vehicle.owner}</div>
                        </div>
                        <div class="text-xs px-3 py-1 rounded-full bg-blue-600/20 text-blue-400 font-semibold">\${slot.status}</div>
                    </button>
                \`).join('');
            }

            resultCount.textContent = \`\${filtered.length} \${filtered.length === 1 ? 'match' : 'matches'}\`;
            searchContainer.classList.remove('hidden');
            lucide.createIcons();
        }

        function toggleParkingExpand() {
            const subItems = document.getElementById('parking-sub-items');
            const chevron = document.getElementById('parking-chevron');
            if (subItems.classList.contains('hidden')) {
                subItems.classList.remove('hidden');
                chevron.style.transform = 'rotate(180deg)';
            } else {
                subItems.classList.add('hidden');
                chevron.style.transform = 'rotate(0deg)';
            }
        }

        function closeModal() {
            document.getElementById('slot-modal').classList.add('hidden');
        }

        async function performAction(action, extra = {}) {
            const payload = { action, slotId: selectedSlot.id, ...extra };
            const response = await fetch('/api/action', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            });
            const data = await response.json();
            if (data.success) {
                zones = data.zones;
                slots = data.slots;
                closeModal();
                renderView();
            }
        }

        async function submitEntry(event) {
            event.preventDefault();
            const formData = new FormData(event.target);
            const vehicle = Object.fromEntries(formData.entries());
            
            const response = await fetch('/api/action', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ action: 'enter', slotId: selectedSlot.id, vehicle })
            });
            const data = await response.json();
            if (data.success) {
                zones = data.zones;
                slots = data.slots;
                // Update selectedSlot with vehicle info for the success page
                selectedSlot = slots.find(s => s.id === selectedSlot.id);
                setView('success');
            }
        }

        function handleNewEntry() {
            const firstAvailable = slots.find(s => s.status === 'available');
            if (firstAvailable) {
                selectedSlot = firstAvailable;
                setView('entry');
            } else {
                alert('No available slots found!');
            }
        }

        function scrollToZone(idx) {
            dashActiveZoneIdx = idx;
            const container = document.getElementById('dash-scroll');
            const panelWidth = container.offsetWidth;
            container.scrollTo({ left: idx * panelWidth, behavior: 'smooth' });
            renderDashboard();
        }

        function initCharts() {
            const ctx1 = document.getElementById('occupancyChart');
            if (ctx1) {
                new Chart(ctx1, {
                    type: 'line',
                    data: {
                        labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                        datasets: [{
                            label: 'Allocations',
                            data: [45, 59, 80, 81, 56, 55, 40],
                            borderColor: '#3b82f6',
                            backgroundColor: 'rgba(59, 130, 246, 0.1)',
                            fill: true,
                            tension: 0.4
                        }]
                    },
                    options: {
                        plugins: { legend: { display: false } },
                        scales: {
                            y: { grid: { color: '#1f2a44' }, ticks: { color: '#9ca3af' } },
                            x: { grid: { display: false }, ticks: { color: '#9ca3af' } }
                        }
                    }
                });
            }

            const ctx2 = document.getElementById('vehicleTypeChart');
            if (ctx2) {
                const counts = {};
                slots.forEach(s => {
                    if (s.vehicle) counts[s.vehicle.type] = (counts[s.vehicle.type] || 0) + 1;
                });
                const labels = Object.keys(counts);
                const values = Object.values(counts);

                new Chart(ctx2, {
                    type: 'doughnut',
                    data: {
                        labels: labels.length ? labels : ['No Data'],
                        datasets: [{
                            data: values.length ? values : [1],
                            backgroundColor: ['#3b82f6', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6'],
                            borderWidth: 0
                        }]
                    },
                    options: {
                        plugins: { legend: { position: 'bottom', labels: { color: '#9ca3af' } } },
                        cutout: '70%'
                    }
                });
            }
        }

        function calculateStats() {
            const total = slots.length;
            const occupied = slots.filter(s => s.status === 'occupied').length;
            return {
                total,
                occupied,
                available: total - occupied - slots.filter(s => s.status === 'reserved' || s.status === 'maintenance').length,
                rate: total ? Math.round((occupied / total) * 100) : 0
            };
        }

        function calculateZoneStats() {
            return zones.map(z => {
                const zSlots = slots.filter(s => s.zoneId === z.id);
                const occ = zSlots.filter(s => s.status === 'occupied').length;
                return {
                    name: z.name,
                    total: zSlots.length,
                    occupied: occ,
                    available: zSlots.length - occ
                };
            });
        }

        function getSlotColor(status) {
            switch(status) {
                case 'occupied': return 'bg-gradient-to-br from-red-500 to-red-600';
                case 'reserved': return 'bg-gradient-to-br from-amber-400 to-amber-500';
                case 'maintenance': return 'bg-gradient-to-br from-orange-500 to-orange-600';
                default: return 'bg-gradient-to-br from-emerald-500 to-emerald-600';
            }
        }

        function getSlotIcon(status) {
            switch(status) {
                case 'occupied': return '<i data-lucide="car" class="size-8"></i>';
                case 'reserved': return '<i data-lucide="bookmark" class="size-8"></i>';
                case 'maintenance': return '<i data-lucide="wrench" class="size-8"></i>';
                default: return '<span class="text-2xl">P</span>';
            }
        }

        function handleSlotClick(slotId) {
            selectedSlot = slots.find(s => s.id === slotId);
            
            // Show selected slot in sidebar
            const selectedSlotNav = document.getElementById('selected-slot-nav');
            const selectedSlotLabel = document.getElementById('selected-slot-label');
            if (selectedSlotNav && selectedSlotLabel) {
                selectedSlotNav.classList.remove('hidden');
                selectedSlotLabel.textContent = \`Slot \${selectedSlot.number}\`;
            }
            
            // Ensure parking is expanded
            const parkingSubItems = document.getElementById('parking-sub-items');
            if (parkingSubItems && parkingSubItems.classList.contains('hidden')) {
                document.getElementById('parking-chevron').style.transform = 'rotate(180deg)';
                parkingSubItems.classList.remove('hidden');
            }
            
            // Navigate to slot detail view
            setView('slot-detail');
        }

        // Initialize
        fetchData();
    </script>
</body>
</html>
