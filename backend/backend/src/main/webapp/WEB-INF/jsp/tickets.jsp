<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tickets | ParkPulse</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            darkMode: 'class'
        }
    </script>
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>
    <link rel="stylesheet" href="css/theme.css">
    <script>
        // Inline script to prevent FOUC (Flash of Unstyled Content) for dark mode
        (function() {
            const isDark = localStorage.getItem('theme') === 'dark';
            if (isDark) document.documentElement.classList.add('dark');
        })();
    </script>
    <style>
        /* Custom sidebar transitions matching React version */
        #sidebar {
            transition: width 0.25s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .sidebar-item-text {
            transition: opacity 0.2s, max-width 0.25s;
        }
        .collapsed .sidebar-item-text {
            opacity: 0;
            max-width: 0;
            pointer-events: none;
        }
        .collapsed .logo-text {
            opacity: 0;
            transform: translateX(-8px);
        }
        .logo-text {
            transition: opacity 0.2s, transform 0.2s;
        }
    </style>
</head>
<body class="flex h-screen w-full overflow-hidden bg-gray-50 dark:bg-gray-900 text-gray-900 dark:text-white">

    <!-- Sidebar -->
    <aside id="sidebar" class="flex-shrink-0 flex flex-col border-r border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 h-full overflow-hidden" style="width: 220px;">
        <!-- Header -->
        <div class="flex items-center gap-3 px-4 py-4 border-b border-gray-200 dark:border-gray-700 min-w-0">
            <button id="sidebar-toggle" class="flex-shrink-0 p-1.5 rounded-lg transition hover:bg-gray-100 dark:hover:bg-gray-700 text-gray-500 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white" aria-label="Toggle sidebar">
                <i data-lucide="menu" size="20"></i>
            </button>
            <div class="logo-text flex items-center gap-2 min-w-0 overflow-hidden">
                <div class="flex-shrink-0 w-7 h-7 rounded-lg bg-blue-600 flex items-center justify-center">
                    <i data-lucide="activity" size="14" class="text-white"></i>
                </div>
                <span class="font-semibold text-sm whitespace-nowrap truncate">ParkPulse</span>
            </div>
        </div>

        <!-- Nav -->
        <nav class="flex-1 px-2 py-4 flex flex-col gap-1">
            <a href="tickets" class="flex items-center gap-3 rounded-xl text-sm transition w-full text-left overflow-hidden bg-blue-600 text-white p-[10px_12px]">
                <span class="flex-shrink-0"><i data-lucide="ticket" size="18"></i></span>
                <span class="sidebar-item-text whitespace-nowrap overflow-hidden">Tickets</span>
            </a>
            <a href="revenue" class="flex items-center gap-3 rounded-xl text-sm transition w-full text-left overflow-hidden text-gray-500 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-700 p-[10px_12px]">
                <span class="flex-shrink-0"><i data-lucide="bar-chart-2" size="18"></i></span>
                <span class="sidebar-item-text whitespace-nowrap overflow-hidden">Revenue</span>
            </a>
        </nav>

        <!-- Sidebar Footer -->
        <div class="px-2 pb-4 flex flex-col gap-1 border-t border-gray-200 dark:border-gray-700 pt-3">
            <button onclick="toggleDarkMode()" class="flex items-center gap-3 rounded-xl text-sm transition w-full overflow-hidden bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-200 hover:bg-gray-200 dark:hover:bg-gray-600 p-[9px_12px]">
                <span class="flex-shrink-0 dark:hidden"><i data-lucide="moon" size="16"></i></span>
                <span class="flex-shrink-0 hidden dark:block"><i data-lucide="sun" size="16"></i></span>
                <span class="sidebar-item-text whitespace-nowrap overflow-hidden dark:hidden">Switch to Dark</span>
                <span class="sidebar-item-text whitespace-nowrap overflow-hidden hidden dark:block">Switch to Light</span>
            </button>
            <button class="flex items-center gap-3 rounded-xl text-sm transition w-full overflow-hidden text-gray-500 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-700 p-[9px_12px]">
                <span class="flex-shrink-0"><i data-lucide="log-out" size="16"></i></span>
                <span class="sidebar-item-text whitespace-nowrap overflow-hidden">Sign Out</span>
            </button>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 flex flex-col overflow-hidden">
        <div class="flex flex-col gap-6 p-6 w-full overflow-y-auto">
            <!-- Header Section -->
            <div>
                <h2 class="font-semibold text-xl">Tickets</h2>
                <p class="text-sm text-gray-500 dark:text-gray-400">Track and manage all parking payment records</p>
            </div>

            <!-- Summary Cards -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div class="rounded-2xl border border-gray-100 dark:border-gray-700 bg-white dark:bg-gray-800 p-4">
                    <div class="flex items-center gap-2 mb-1">
                        <i data-lucide="clock" size="16" class="text-amber-400"></i>
                        <span class="text-xs text-gray-500 dark:text-gray-400">Ongoing</span>
                    </div>
                    <p id="ongoing-count" class="text-2xl font-semibold">0</p>
                </div>
                <div class="rounded-2xl border border-gray-100 dark:border-gray-700 bg-white dark:bg-gray-800 p-4">
                    <div class="flex items-center gap-2 mb-1">
                        <i data-lucide="check-circle-2" size="16" class="text-emerald-400"></i>
                        <span class="text-xs text-gray-500 dark:text-gray-400">Finished</span>
                    </div>
                    <p id="finished-count" class="text-2xl font-semibold">0</p>
                </div>
                <div class="rounded-2xl border border-gray-100 dark:border-gray-700 bg-white dark:bg-gray-800 p-4">
                    <div class="flex items-center gap-2 mb-1">
                        <span class="text-xs text-gray-500 dark:text-gray-400">Total Revenue</span>
                    </div>
                    <p id="total-revenue" class="text-2xl font-semibold">Rs 0.00</p>
                </div>
            </div>

            <!-- Table Card -->
            <div class="rounded-2xl border border-gray-100 dark:border-gray-700 bg-white dark:bg-gray-800 overflow-visible">
                <!-- Tabs + controls row -->
                <div class="flex items-center justify-between px-5 pt-4 pb-0 gap-3 flex-wrap">
                    <div class="flex items-center gap-2">
                        <button onclick="switchTab('ongoing')" id="tab-ongoing" class="px-4 py-2 rounded-xl text-sm font-medium transition capitalize bg-blue-600 text-white">
                            <span class="flex items-center gap-1.5">
                                <i data-lucide="clock" size="13"></i>
                                Ongoing
                                <span id="ongoing-tab-count" class="text-xs opacity-70">(0)</span>
                            </span>
                        </button>
                        <button onclick="switchTab('finished')" id="tab-finished" class="px-4 py-2 rounded-xl text-sm font-medium transition capitalize text-gray-500 dark:text-gray-400 hover:text-gray-800 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-700">
                            <span class="flex items-center gap-1.5">
                                <i data-lucide="check-circle-2" size="13"></i>
                                Finished
                                <span id="finished-tab-count" class="text-xs opacity-70">(0)</span>
                            </span>
                        </button>

                        <!-- Filter button -->
                        <div class="relative">
                            <button id="filter-btn" class="flex items-center gap-1.5 px-3 py-2 rounded-xl text-sm transition border border-gray-200 dark:border-gray-600 text-gray-500 dark:text-gray-400 hover:text-gray-800 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-700">
                                <i data-lucide="sliders-horizontal" size="14"></i>
                                <span>Filter</span>
                                <span id="active-filter-count" class="hidden text-[10px] font-semibold px-1.5 py-0.5 rounded-full min-w-[18px] text-center bg-blue-600 text-white">0</span>
                            </button>

                            <!-- Filter Popover -->
                            <div id="filter-popover" class="hidden absolute z-40 top-full mt-2 right-0 w-80 rounded-2xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 shadow-2xl">
                                <div class="flex items-center justify-between px-4 py-3 border-b border-gray-100 dark:border-gray-700">
                                    <div class="flex items-center gap-2">
                                        <i data-lucide="sliders-horizontal" size="15" class="text-blue-400"></i>
                                        <span class="text-sm font-semibold">Filter Tickets</span>
                                    </div>
                                    <button onclick="toggleFilter()" class="p-1 rounded-lg transition hover:bg-gray-100 dark:hover:bg-gray-700 text-gray-400">
                                        <i data-lucide="x" size="15"></i>
                                    </button>
                                </div>
                                <div class="p-4 flex flex-col gap-4 max-h-[400px] overflow-y-auto">
                                    <!-- Date Range -->
                                    <div>
                                        <p class="text-xs font-semibold uppercase tracking-wide mb-2 text-gray-500 dark:text-gray-400">Date Range</p>
                                        <div class="grid grid-cols-2 gap-2">
                                            <div>
                                                <label class="block text-xs mb-1.5 text-gray-500 dark:text-gray-400">From</label>
                                                <input type="date" id="filter-date-from" class="w-full rounded-lg px-3 py-2 text-sm border border-gray-200 dark:border-gray-600 bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white outline-none focus:ring-2 focus:ring-blue-500 transition">
                                            </div>
                                            <div>
                                                <label class="block text-xs mb-1.5 text-gray-500 dark:text-gray-400">To</label>
                                                <input type="date" id="filter-date-to" class="w-full rounded-lg px-3 py-2 text-sm border border-gray-200 dark:border-gray-600 bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white outline-none focus:ring-2 focus:ring-blue-500 transition">
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Vehicle Type -->
                                    <div>
                                        <p class="text-xs font-semibold uppercase tracking-wide mb-2 text-gray-500 dark:text-gray-400">Vehicle Type</p>
                                        <div id="filter-vehicle-type" class="flex flex-wrap gap-1.5">
                                            <button data-val="" class="px-3 py-1.5 rounded-lg text-xs transition bg-blue-600 text-white">All</button>
                                            <button data-val="Car" class="px-3 py-1.5 rounded-lg text-xs transition bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600">Car</button>
                                            <button data-val="SUV" class="px-3 py-1.5 rounded-lg text-xs transition bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600">SUV</button>
                                            <button data-val="Motorcycle" class="px-3 py-1.5 rounded-lg text-xs transition bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600">Motorcycle</button>
                                            <button data-val="Truck" class="px-3 py-1.5 rounded-lg text-xs transition bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600">Truck</button>
                                            <button data-val="Van" class="px-3 py-1.5 rounded-lg text-xs transition bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600">Van</button>
                                        </div>
                                    </div>
                                    <!-- Payment Method -->
                                    <div>
                                        <p class="text-xs font-semibold uppercase tracking-wide mb-2 text-gray-500 dark:text-gray-400">Payment Method</p>
                                        <div id="filter-payment-method" class="flex gap-1.5">
                                            <button data-val="" class="px-3 py-1.5 rounded-lg text-xs transition bg-blue-600 text-white">All</button>
                                            <button data-val="Cash" class="px-3 py-1.5 rounded-lg text-xs transition bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600">Cash</button>
                                            <button data-val="Card" class="px-3 py-1.5 rounded-lg text-xs transition bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600">Card</button>
                                            <button data-val="Mobile" class="px-3 py-1.5 rounded-lg text-xs transition bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600">Mobile</button>
                                        </div>
                                    </div>
                                    <!-- Amount Range -->
                                    <div>
                                        <p class="text-xs font-semibold uppercase tracking-wide mb-2 text-gray-500 dark:text-gray-400">Amount (රු)</p>
                                        <div class="grid grid-cols-2 gap-2">
                                            <div>
                                                <label class="block text-xs mb-1.5 text-gray-500 dark:text-gray-400">Min</label>
                                                <input type="number" id="filter-amount-min" placeholder="0" class="w-full rounded-lg px-3 py-2 text-sm border border-gray-200 dark:border-gray-600 bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white outline-none focus:ring-2 focus:ring-blue-500 transition">
                                            </div>
                                            <div>
                                                <label class="block text-xs mb-1.5 text-gray-500 dark:text-gray-400">Max</label>
                                                <input type="number" id="filter-amount-max" placeholder="999" class="w-full rounded-lg px-3 py-2 text-sm border border-gray-200 dark:border-gray-600 bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white outline-none focus:ring-2 focus:ring-blue-500 transition">
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Slot -->
                                    <div>
                                        <p class="text-xs font-semibold uppercase tracking-wide mb-2 text-gray-500 dark:text-gray-400">Parking Slot</p>
                                        <input type="text" id="filter-slot" placeholder="e.g. A3, B7" class="w-full rounded-lg px-3 py-2 text-sm border border-gray-200 dark:border-gray-600 bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white outline-none focus:ring-2 focus:ring-blue-500 transition">
                                    </div>
                                </div>
                                <div class="flex items-center justify-between px-4 py-3 border-t border-gray-100 dark:border-gray-700">
                                    <button onclick="resetFilters()" class="flex items-center gap-1.5 text-xs transition text-gray-500 dark:text-gray-400 hover:text-gray-800 dark:hover:text-white">
                                        <i data-lucide="rotate-ccw" size="12"></i> Reset all
                                    </button>
                                    <button onclick="applyFilters()" class="px-4 py-1.5 rounded-lg bg-blue-600 text-white text-xs hover:bg-blue-700 transition flex items-center gap-1.5">
                                        <i data-lucide="check" size="12"></i> Apply
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Search -->
                    <div class="flex items-center gap-2 rounded-xl border border-gray-200 dark:border-gray-600 bg-gray-50 dark:bg-gray-700 px-3 py-2 text-sm">
                        <i data-lucide="search" size="14" class="text-gray-500 dark:text-gray-400"></i>
                        <input id="search-input" placeholder="Search tickets..." class="bg-transparent outline-none text-sm w-44 text-gray-900 dark:text-white">
                    </div>
                </div>

                <!-- Active filter pills -->
                <div id="filter-pills" class="hidden flex flex-wrap gap-1.5 px-5 pt-3">
                    <!-- Pills injected by JS -->
                </div>

                <!-- Table -->
                <div class="overflow-x-auto mt-3">
                    <table class="w-full text-sm">
                        <thead>
                            <tr class="text-xs uppercase tracking-wide border-b border-gray-100 dark:border-gray-700 text-gray-400 dark:text-gray-500">
                                <th class="text-left px-5 py-3 font-medium">Ticket ID</th>
                                <th class="text-left px-5 py-3 font-medium">Owner</th>
                                <th class="text-left px-5 py-3 font-medium">Plate</th>
                                <th class="text-left px-5 py-3 font-medium">Slot</th>
                                <th class="text-left px-5 py-3 font-medium">Entry</th>
                                <th id="table-col-dynamic" class="text-left px-5 py-3 font-medium">Duration</th>
                                <th class="text-left px-5 py-3 font-medium">Rate</th>
                                <th class="text-left px-5 py-3 font-medium">Payment</th>
                                <th class="text-left px-5 py-3 font-medium">Action</th>
                            </tr>
                        </thead>
                        <tbody id="tickets-tbody" class="divide-y divide-gray-100 dark:divide-gray-700">
                            <!-- Rows injected by JS -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>

    <!-- Modals -->
    <!-- Edit Modal -->
    <div id="edit-modal" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm">
        <div class="w-full max-w-md rounded-2xl shadow-2xl p-6 bg-white dark:bg-gray-800 text-gray-900 dark:text-white">
            <div class="flex items-center justify-between mb-5">
                <h3 class="font-semibold text-base">Edit Ticket — <span id="edit-id-title"></span></h3>
                <button onclick="closeModal('edit')" class="p-1.5 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700 transition">
                    <i data-lucide="x" size="18"></i>
                </button>
            </div>
            <form id="edit-form" class="grid grid-cols-2 gap-3">
                <input type="hidden" id="edit-id">
                <div class="flex flex-col gap-1">
                    <label class="text-xs text-gray-500 dark:text-gray-400">Owner Name</label>
                    <input type="text" id="edit-owner" class="rounded-lg px-3 py-2 text-sm border border-gray-200 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white outline-none focus:ring-2 focus:ring-blue-500 transition">
                </div>
                <div class="flex flex-col gap-1">
                    <label class="text-xs text-gray-500 dark:text-gray-400">Vehicle Plate</label>
                    <input type="text" id="edit-plate" class="rounded-lg px-3 py-2 text-sm border border-gray-200 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white outline-none focus:ring-2 focus:ring-blue-500 transition">
                </div>
                <div class="flex flex-col gap-1">
                    <label class="text-xs text-gray-500 dark:text-gray-400">Parking Slot</label>
                    <input type="text" id="edit-slot" class="rounded-lg px-3 py-2 text-sm border border-gray-200 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white outline-none focus:ring-2 focus:ring-blue-500 transition">
                </div>
                <div class="flex flex-col gap-1">
                    <label class="text-xs text-gray-500 dark:text-gray-400">Vehicle Type</label>
                    <input type="text" id="edit-type" class="rounded-lg px-3 py-2 text-sm border border-gray-200 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white outline-none focus:ring-2 focus:ring-blue-500 transition">
                </div>
                <div class="flex flex-col gap-1">
                    <label class="text-xs text-gray-500 dark:text-gray-400">Entry Time</label>
                    <input type="datetime-local" id="edit-entry" class="rounded-lg px-3 py-2 text-sm border border-gray-200 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white outline-none focus:ring-2 focus:ring-blue-500 transition">
                </div>
                <div class="flex flex-col gap-1">
                    <label class="text-xs text-gray-500 dark:text-gray-400">Exit Time</label>
                    <input type="datetime-local" id="edit-exit" class="rounded-lg px-3 py-2 text-sm border border-gray-200 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white outline-none focus:ring-2 focus:ring-blue-500 transition">
                </div>
                <div class="flex flex-col gap-1">
                    <label class="text-xs text-gray-500 dark:text-gray-400">Payment Method</label>
                    <select id="edit-payment" class="rounded-lg px-3 py-2 text-sm border border-gray-200 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white outline-none focus:ring-2 focus:ring-blue-500">
                        <option>Cash</option>
                        <option>Card</option>
                        <option>Mobile</option>
                    </select>
                </div>
                <div class="flex flex-col gap-1">
                    <label class="text-xs text-gray-500 dark:text-gray-400">Status</label>
                    <select id="edit-status" class="rounded-lg px-3 py-2 text-sm border border-gray-200 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white outline-none focus:ring-2 focus:ring-blue-500">
                        <option value="ongoing">Ongoing</option>
                        <option value="finished">Finished</option>
                    </select>
                </div>
            </form>

            <div id="edit-finished-info" class="hidden mt-4 rounded-xl px-4 py-3 flex items-center justify-between bg-gray-50 dark:bg-gray-700/60">
                <div>
                    <p class="text-xs mb-0.5 text-gray-500 dark:text-gray-400">Total Amount Paid</p>
                    <p class="text-xs text-gray-400 dark:text-gray-500">via <span id="edit-payment-label"></span></p>
                </div>
                <span class="text-xl font-semibold text-emerald-400">Rs <span id="edit-amount-label">0.00</span></span>
            </div>

            <div class="flex gap-2 mt-6">
                <button onclick="closeModal('edit')" class="flex-1 py-2 rounded-xl text-sm border border-gray-200 dark:border-gray-600 text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 transition">
                    Cancel
                </button>
                <button id="edit-print-btn" class="px-4 py-2 rounded-xl text-sm border border-gray-200 dark:border-gray-600 text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 transition flex items-center gap-1.5">
                    <i data-lucide="printer" size="14"></i> Print
                </button>
                <button onclick="saveEdit()" class="flex-1 py-2 rounded-xl text-sm bg-blue-600 text-white hover:bg-blue-700 transition flex items-center justify-center gap-2">
                    <i data-lucide="check" size="15"></i> Save Changes
                </button>
            </div>
        </div>
    </div>

    <!-- Delete Modal -->
    <div id="delete-modal" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm">
        <div class="w-full max-w-sm rounded-2xl shadow-2xl p-6 bg-white dark:bg-gray-800 text-gray-900 dark:text-white">
            <div class="flex justify-center mb-4">
                <div class="w-14 h-14 rounded-full bg-red-500/15 flex items-center justify-center">
                    <i data-lucide="alert-triangle" size="28" class="text-red-400"></i>
                </div>
            </div>
            <div class="text-center mb-5">
                <h3 class="font-semibold text-base mb-1.5">Delete Ticket?</h3>
                <p class="text-sm leading-relaxed text-gray-500 dark:text-gray-400">
                    You're about to permanently delete ticket <span id="delete-id-label" class="font-semibold font-mono text-red-400"></span> for <span id="delete-owner-label" class="font-semibold"></span>. This action cannot be undone.
                </p>
            </div>
            <div class="rounded-xl px-4 py-3 mb-5 flex items-center justify-between text-sm bg-gray-50 dark:bg-gray-700/60">
                <div class="flex items-center gap-2">
                    <span id="delete-plate-label" class="font-mono text-gray-700 dark:text-gray-300"></span>
                    <span class="text-xs text-gray-400 dark:text-gray-500">·</span>
                    <span id="delete-slot-label" class="text-xs bg-blue-500/20 text-blue-400 px-2 py-0.5 rounded-lg font-mono"></span>
                </div>
                <span id="delete-type-label" class="text-xs font-medium text-gray-500 dark:text-gray-400"></span>
            </div>
            <div class="flex gap-3">
                <button onclick="closeModal('delete')" class="flex-1 py-2.5 rounded-xl text-sm border border-gray-200 dark:border-gray-600 text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 transition font-medium">
                    Cancel
                </button>
                <button onclick="confirmDelete()" class="flex-1 py-2.5 rounded-xl text-sm bg-red-600 hover:bg-red-700 text-white transition font-medium flex items-center justify-center gap-2">
                    <i data-lucide="trash-2" size="14"></i> Delete
                </button>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="js/core.js"></script>
    <script src="js/tickets.js"></script>
    <script>
        // Initialize Lucide icons
        lucide.createIcons();
    </script>
</body>
</html>
