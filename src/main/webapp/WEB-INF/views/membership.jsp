<%@ include file="includes/head.jsp" %>
<%@ include file="includes/sidebar.jsp" %>

<main class="flex-1 flex flex-col min-w-0 overflow-hidden">
    <div class="flex-1 flex flex-col min-h-0 overflow-auto animate-fade-in">
        <!-- Top Header -->
        <div class="px-8 py-5 flex items-center justify-between shrink-0 border-b border-border bg-gradient-to-b from-green-500/5 to-transparent">
            <div class="flex flex-col gap-0.5">
                <div class="flex items-center gap-2 mb-1">
                    <span class="text-xs text-sidebar-foreground/60">ParkPulse</span>
                    <i data-lucide="chevron-up" class="size-3 rotate-90 text-sidebar-foreground/40"></i>
                    <span class="text-xs font-semibold text-green-500">Membership</span>
                </div>
                <h1 class="text-2xl font-bold text-foreground">Member Management</h1>
                <p class="text-sm text-sidebar-foreground/60 mt-0.5">Monitor, manage and grow your parking community</p>
            </div>
            
            <div class="flex items-center gap-2.5">
                <button onclick="refreshData()" class="w-9 h-9 rounded-xl flex items-center justify-center border border-border bg-green-500/5 hover:bg-green-500/10 transition-colors">
                    <i data-lucide="refresh-cw" class="size-4 text-sidebar-foreground/60"></i>
                </button>
                <button class="w-9 h-9 rounded-xl flex items-center justify-center border border-border bg-green-500/5 hover:bg-green-500/10 transition-colors">
                    <i data-lucide="download" class="size-4 text-sidebar-foreground/60"></i>
                </button>
                <div class="relative">
                    <button id="notif-btn" class="w-9 h-9 rounded-xl flex items-center justify-center border border-border bg-green-500/5 hover:bg-green-500/10 transition-colors">
                        <i data-lucide="bell" class="size-4 text-sidebar-foreground/60"></i>
                        <span class="absolute top-1.5 right-1.5 w-2 h-2 rounded-full bg-green-500 border border-background"></span>
                    </button>
                    <!-- Notifications Dropdown -->
                    <div id="notif-dropdown" class="absolute right-0 top-11 w-72 rounded-2xl z-50 overflow-hidden border border-border bg-card shadow-2xl hidden">
                        <div class="px-4 py-3 border-b border-border">
                            <p class="text-sm font-semibold text-foreground">Notifications</p>
                        </div>
                        <div class="max-h-80 overflow-y-auto">
                            <div class="flex items-start gap-3 px-4 py-3 border-b border-border">
                                <div class="w-7 h-7 rounded-lg flex items-center justify-center shrink-0 mt-0.5 bg-green-500/15">
                                    <i data-lucide="plus" class="size-3.5 text-green-500"></i>
                                </div>
                                <div class="flex-1">
                                    <p class="text-xs font-medium text-foreground">Grace Chen joined recently</p>
                                    <p class="text-xs mt-0.5 text-sidebar-foreground/60">2h ago</p>
                                </div>
                                <span class="w-2 h-2 rounded-full mt-1.5 shrink-0 bg-green-500"></span>
                            </div>
                            <div class="flex items-start gap-3 px-4 py-3 border-b border-border">
                                <div class="w-7 h-7 rounded-lg flex items-center justify-center shrink-0 mt-0.5 bg-red-500/15">
                                    <i data-lucide="user-x" class="size-3.5 text-red-500"></i>
                                </div>
                                <div class="flex-1">
                                    <p class="text-xs font-medium text-foreground">Emma Davis account suspended</p>
                                    <p class="text-xs mt-0.5 text-sidebar-foreground/60">5h ago</p>
                                </div>
                                <span class="w-2 h-2 rounded-full mt-1.5 shrink-0 bg-red-500"></span>
                            </div>
                            <div class="flex items-start gap-3 px-4 py-3 border-b border-border">
                                <div class="w-7 h-7 rounded-lg flex items-center justify-center shrink-0 mt-0.5 bg-green-500/15">
                                    <i data-lucide="check" class="size-3.5 text-green-500"></i>
                                </div>
                                <div class="flex-1">
                                    <p class="text-xs font-medium text-foreground">Bob Martinez plan renewed</p>
                                    <p class="text-xs mt-0.5 text-sidebar-foreground/60">1d ago</p>
                                </div>
                                <span class="w-2 h-2 rounded-full mt-1.5 shrink-0 bg-green-500"></span>
                            </div>
                        </div>
                        <div class="px-4 py-2.5">
                            <button class="text-xs font-semibold text-green-500">View all notifications →</button>
                        </div>
                    </div>
                </div>
                <div class="flex items-center gap-2 px-3 py-1.5 rounded-xl border border-border bg-green-500/5">
                    <div class="w-7 h-7 rounded-lg flex items-center justify-center text-xs font-bold text-white bg-gradient-to-br from-green-600 to-green-400">AD</div>
                    <span class="text-sm font-medium text-foreground">Admin</span>
                </div>
                <button onclick="openModal('add-member-modal')" class="flex items-center gap-2 px-4 py-2 rounded-xl text-sm font-semibold text-white bg-gradient-to-br from-green-600 to-green-500 shadow-lg shadow-green-500/40 hover:scale-[1.02] active:scale-[0.98] transition-all">
                    <i data-lucide="plus" class="size-4"></i>
                    New Member
                </button>
            </div>
        </div>

        <!-- Stats Grid -->
        <div class="px-8 pt-6 pb-4 grid grid-cols-3 gap-4 shrink-0">
            <!-- Total Members -->
            <div class="rounded-2xl p-5 flex flex-col gap-3 relative overflow-hidden border border-border bg-card shadow-sm hover:-translate-y-1 transition-all duration-300">
                <div class="absolute -top-6 -right-6 w-24 h-24 rounded-full opacity-10 blur-2xl bg-green-500"></div>
                <div class="flex items-start justify-between relative">
                    <div class="w-11 h-11 rounded-xl flex items-center justify-center bg-gradient-to-br from-green-500 to-green-600 shadow-lg shadow-green-500/30">
                        <i data-lucide="users" class="size-5 text-white"></i>
                    </div>
                    <div class="flex items-center gap-1 px-2 py-1 rounded-lg bg-green-500/10 border border-green-500/20">
                        <i data-lucide="arrow-up" class="size-3 text-green-500"></i>
                        <span class="text-xs font-bold text-green-500">12%</span>
                    </div>
                </div>
                <div class="flex items-end justify-between relative">
                    <div>
                        <p class="text-xs text-sidebar-foreground/60 mb-1">Total Members</p>
                        <p id="stat-total" class="text-4xl font-bold tracking-tight text-foreground">0</p>
                    </div>
                    <div class="w-[72px] h-[28px] bg-green-500/10 rounded overflow-hidden">
                        <!-- Placeholder for sparkline -->
                        <div class="h-full w-full bg-gradient-to-t from-green-500/20 to-transparent"></div>
                    </div>
                </div>
            </div>
            <!-- Active Members -->
            <div class="rounded-2xl p-5 flex flex-col gap-3 relative overflow-hidden border border-border bg-card shadow-sm hover:-translate-y-1 transition-all duration-300">
                <div class="absolute -top-6 -right-6 w-24 h-24 rounded-full opacity-10 blur-2xl bg-emerald-500"></div>
                <div class="flex items-start justify-between relative">
                    <div class="w-11 h-11 rounded-xl flex items-center justify-center bg-gradient-to-br from-emerald-500 to-emerald-600 shadow-lg shadow-emerald-500/30">
                        <i data-lucide="user-check" class="size-5 text-white"></i>
                    </div>
                    <div class="flex items-center gap-1 px-2 py-1 rounded-lg bg-emerald-500/10 border border-emerald-500/20">
                        <i data-lucide="arrow-up" class="size-3 text-emerald-500"></i>
                        <span class="text-xs font-bold text-emerald-500">8%</span>
                    </div>
                </div>
                <div class="flex items-end justify-between relative">
                    <div>
                        <p class="text-xs text-sidebar-foreground/60 mb-1">Active Members</p>
                        <p id="stat-active" class="text-4xl font-bold tracking-tight text-foreground">0</p>
                    </div>
                    <div class="w-[72px] h-[28px] bg-emerald-500/10 rounded overflow-hidden">
                        <div class="h-full w-full bg-gradient-to-t from-emerald-500/20 to-transparent"></div>
                    </div>
                </div>
            </div>
            <!-- Inactive Members -->
            <div class="rounded-2xl p-5 flex flex-col gap-3 relative overflow-hidden border border-border bg-card shadow-sm hover:-translate-y-1 transition-all duration-300">
                <div class="absolute -top-6 -right-6 w-24 h-24 rounded-full opacity-10 blur-2xl bg-red-500"></div>
                <div class="flex items-start justify-between relative">
                    <div class="w-11 h-11 rounded-xl flex items-center justify-center bg-gradient-to-br from-red-500 to-red-600 shadow-lg shadow-red-500/30">
                        <i data-lucide="user-x" class="size-5 text-white"></i>
                    </div>
                    <div class="flex items-center gap-1 px-2 py-1 rounded-lg bg-red-500/10 border border-red-500/20">
                        <i data-lucide="arrow-down" class="size-3 text-red-500"></i>
                        <span class="text-xs font-bold text-red-500">5%</span>
                    </div>
                </div>
                <div class="flex items-end justify-between relative">
                    <div>
                        <p class="text-xs text-sidebar-foreground/60 mb-1">Inactive / Suspended</p>
                        <p id="stat-inactive" class="text-4xl font-bold tracking-tight text-foreground">0</p>
                    </div>
                    <div class="w-[72px] h-[28px] bg-red-500/10 rounded overflow-hidden">
                        <div class="h-full w-full bg-gradient-to-t from-red-500/20 to-transparent"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Table Section -->
        <div class="px-8 pb-8 flex-1">
            <div class="rounded-[20px] overflow-hidden border border-border bg-card shadow-xl backdrop-blur-xl">
                <!-- Toolbar -->
                <div class="px-6 pt-5 pb-4 border-b border-border">
                    <div class="flex items-center justify-between gap-4 mb-4">
                        <div>
                            <h2 class="text-lg font-bold text-foreground">Member Directory</h2>
                            <p id="member-count" class="text-xs text-sidebar-foreground/60 mt-0.5">0 members found</p>
                        </div>
                        <div class="flex items-center gap-2">
                            <!-- Plan filter -->
                            <div class="relative">
                                <select id="plan-filter" class="appearance-none pl-8 pr-8 py-2 rounded-xl text-xs font-semibold outline-none border border-border bg-green-500/5 text-sidebar-foreground/60">
                                    <option value="All">All Plans</option>
                                    <option value="Monthly">Monthly</option>
                                    <option value="Quarterly">Quarterly</option>
                                    <option value="Annual">Annual</option>
                                </select>
                                <i data-lucide="filter" class="size-3.5 absolute left-2.5 top-1/2 -translate-y-1/2 text-sidebar-foreground/60"></i>
                                <i data-lucide="chevron-down" class="size-3.5 absolute right-2.5 top-1/2 -translate-y-1/2 text-sidebar-foreground/40 pointer-events-none"></i>
                            </div>
                            <!-- Search -->
                            <div class="flex items-center gap-2 px-3 py-2 rounded-xl w-56 border border-border bg-green-500/5">
                                <i data-lucide="search" class="size-3.5 text-sidebar-foreground/60"></i>
                                <input type="text" id="search-input" placeholder="Search members..." class="bg-transparent text-xs outline-none w-full text-foreground placeholder:text-sidebar-foreground/40">
                                <button id="clear-search" class="hidden"><i data-lucide="x" class="size-3 text-sidebar-foreground/60"></i></button>
                            </div>
                        </div>
                    </div>
                    <!-- Status Filter Tabs -->
                    <div class="flex items-center gap-1" id="status-filters">
                        <button data-status="All" class="filter-tab active px-3.5 py-1.5 rounded-lg text-xs font-semibold transition-all">All</button>
                        <button data-status="Active" class="filter-tab px-3.5 py-1.5 rounded-lg text-xs font-semibold transition-all">Active</button>
                        <button data-status="Inactive" class="filter-tab px-3.5 py-1.5 rounded-lg text-xs font-semibold transition-all">Inactive</button>
                        <button data-status="Suspended" class="filter-tab px-3.5 py-1.5 rounded-lg text-xs font-semibold transition-all">Suspended</button>
                    </div>
                </div>

                <!-- Bulk Actions Bar (hidden by default) -->
                <div id="bulk-actions" class="hidden px-6 py-3 flex items-center gap-3 bg-green-500/10 border-b border-green-500/20">
                    <i data-lucide="shield-check" class="size-4 text-green-500"></i>
                    <span id="selected-count" class="text-sm font-semibold text-green-500">0 members selected</span>
                    <div class="flex-1"></div>
                    <button onclick="openModal('bulk-delete-modal')" class="flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-semibold bg-red-500/10 border border-red-500/30 text-red-500 hover:bg-red-500/20 transition-colors">
                        <i data-lucide="trash" class="size-3.5"></i>
                        Delete Selected
                    </button>
                    <button onclick="clearSelection()" class="text-sidebar-foreground/60 hover:text-foreground"><i data-lucide="x" class="size-4"></i></button>
                </div>

                <!-- Table -->
                <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                        <thead>
                            <tr class="bg-foreground/[0.02] border-b border-border">
                                <th class="px-6 py-3.5 w-10">
                                    <input type="checkbox" id="select-all" class="w-4 h-4 rounded border-border text-green-500 focus:ring-green-500/20 bg-background">
                                </th>
                                <th class="text-left px-4 py-3.5 text-xs uppercase tracking-widest font-bold text-sidebar-foreground/40 cursor-pointer" onclick="sortBy('id')">Member ID</th>
                                <th class="text-left px-4 py-3.5 text-xs uppercase tracking-widest font-bold text-sidebar-foreground/40 cursor-pointer" onclick="sortBy('name')">Name</th>
                                <th class="text-left px-4 py-3.5 text-xs uppercase tracking-widest font-bold text-sidebar-foreground/40">Contact</th>
                                <th class="text-left px-4 py-3.5 text-xs uppercase tracking-widest font-bold text-sidebar-foreground/40">Vehicle</th>
                                <th class="text-left px-4 py-3.5 text-xs uppercase tracking-widest font-bold text-sidebar-foreground/40">Plan</th>
                                <th class="text-left px-4 py-3.5 text-xs uppercase tracking-widest font-bold text-sidebar-foreground/40">Status</th>
                                <th class="text-left px-4 py-3.5 text-xs uppercase tracking-widest font-bold text-sidebar-foreground/40">Joined</th>
                                <th class="text-center px-4 py-3.5 text-xs uppercase tracking-widest font-bold text-sidebar-foreground/40">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="member-table-body">
                            <!-- Rows will be injected by JS -->
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <div class="px-6 py-3.5 flex items-center justify-between border-t border-border bg-foreground/[0.01]">
                    <p id="pagination-info" class="text-xs text-sidebar-foreground/60">
                        Showing <span class="text-foreground font-semibold">0–0</span> of <span class="text-foreground font-semibold">0</span>
                    </p>
                    <div class="flex items-center gap-1.5" id="pagination-controls">
                        <!-- Controls will be injected by JS -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Modals -->
<div id="modal-container" class="fixed inset-0 z-[100] hidden">
    <div class="absolute inset-0 bg-black/60 backdrop-blur-md"></div>
    
    <!-- Add/Edit Member Modal -->
    <div id="member-modal" class="modal-content absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-full max-w-lg rounded-3xl overflow-hidden border border-border bg-card shadow-2xl hidden">
        <div class="px-6 py-5 flex items-center justify-between border-b border-border bg-gradient-to-br from-green-500/10 to-transparent">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-2xl flex items-center justify-center bg-gradient-to-br from-green-600 to-green-400 shadow-lg shadow-green-500/40">
                    <i data-lucide="plus" id="modal-icon" class="size-5 text-white"></i>
                </div>
                <div>
                    <h3 id="modal-title" class="font-bold text-foreground text-lg">Add New Member</h3>
                    <p id="modal-subtitle" class="text-xs text-green-500 mt-0.5">Enter member details below</p>
                </div>
            </div>
            <button onclick="closeModal()" class="w-8 h-8 rounded-xl flex items-center justify-center border border-border bg-foreground/5 text-sidebar-foreground/60 hover:text-foreground">
                <i data-lucide="x" class="size-4"></i>
            </button>
        </div>
        
        <form id="member-form" class="px-6 py-5 grid grid-cols-2 gap-4">
            <input type="hidden" id="member-id-hidden">
            <div class="col-span-2">
                <label class="block text-[11px] font-bold uppercase tracking-wider text-sidebar-foreground/60 mb-1.5 ml-1">Full Name <span class="text-red-500">*</span></label>
                <input type="text" id="member-name" required class="w-full px-4 py-2.5 rounded-xl border border-border bg-foreground/[0.03] text-foreground text-sm outline-none focus:ring-2 focus:ring-green-500/20 focus:border-green-500/50 transition-all" placeholder="e.g. John Doe">
            </div>
            <div>
                <label class="block text-[11px] font-bold uppercase tracking-wider text-sidebar-foreground/60 mb-1.5 ml-1">Email Address <span class="text-red-500">*</span></label>
                <input type="email" id="member-email" required class="w-full px-4 py-2.5 rounded-xl border border-border bg-foreground/[0.03] text-foreground text-sm outline-none focus:ring-2 focus:ring-green-500/20 focus:border-green-500/50 transition-all" placeholder="john@email.com">
            </div>
            <div>
                <label class="block text-[11px] font-bold uppercase tracking-wider text-sidebar-foreground/60 mb-1.5 ml-1">Phone Number <span class="text-red-500">*</span></label>
                <input type="text" id="member-phone" required class="w-full px-4 py-2.5 rounded-xl border border-border bg-foreground/[0.03] text-foreground text-sm outline-none focus:ring-2 focus:ring-green-500/20 focus:border-green-500/50 transition-all" placeholder="+1 (555) 000-0000">
            </div>
            <div>
                <label class="block text-[11px] font-bold uppercase tracking-wider text-sidebar-foreground/60 mb-1.5 ml-1">Vehicle Model <span class="text-red-500">*</span></label>
                <input type="text" id="member-vehicle" required class="w-full px-4 py-2.5 rounded-xl border border-border bg-foreground/[0.03] text-foreground text-sm outline-none focus:ring-2 focus:ring-green-500/20 focus:border-green-500/50 transition-all" placeholder="e.g. Toyota Camry">
            </div>
            <div>
                <label class="block text-[11px] font-bold uppercase tracking-wider text-sidebar-foreground/60 mb-1.5 ml-1">License Plate <span class="text-red-500">*</span></label>
                <input type="text" id="member-plate" required class="w-full px-4 py-2.5 rounded-xl border border-border bg-foreground/[0.03] text-foreground text-sm outline-none focus:ring-2 focus:ring-green-500/20 focus:border-green-500/50 transition-all" placeholder="e.g. ABC-1234">
            </div>
            <div>
                <label class="block text-[11px] font-bold uppercase tracking-wider text-sidebar-foreground/60 mb-1.5 ml-1">Subscription Plan</label>
                <div class="grid grid-cols-3 gap-2" id="plan-pills">
                    <button type="button" data-value="Monthly" class="plan-pill rounded-xl py-2 px-3 border border-border bg-foreground/5 text-left transition-all">
                        <span class="block text-xs font-bold text-foreground">Monthly</span>
                        <span class="block text-[10px] text-sidebar-foreground/60">$29/mo</span>
                    </button>
                    <button type="button" data-value="Quarterly" class="plan-pill rounded-xl py-2 px-3 border border-border bg-foreground/5 text-left transition-all">
                        <span class="block text-xs font-bold text-foreground">Quarterly</span>
                        <span class="block text-[10px] text-sidebar-foreground/60">$79/qtr</span>
                    </button>
                    <button type="button" data-value="Annual" class="plan-pill rounded-xl py-2 px-3 border border-border bg-foreground/5 text-left transition-all">
                        <span class="block text-xs font-bold text-foreground">Annual</span>
                        <span class="block text-[10px] text-sidebar-foreground/60">$249/yr</span>
                    </button>
                </div>
                <input type="hidden" id="member-plan" value="Monthly">
            </div>
            <div>
                <label class="block text-[11px] font-bold uppercase tracking-wider text-sidebar-foreground/60 mb-1.5 ml-1">Status</label>
                <div class="flex gap-2" id="status-pills">
                    <button type="button" data-value="Active" class="status-pill flex items-center gap-2 px-3 py-2 rounded-xl border border-border bg-foreground/5 text-xs transition-all">
                        <span class="w-2 h-2 rounded-full bg-green-500"></span>
                        Active
                    </button>
                    <button type="button" data-value="Inactive" class="status-pill flex items-center gap-2 px-3 py-2 rounded-xl border border-border bg-foreground/5 text-xs transition-all">
                        <span class="w-2 h-2 rounded-full bg-slate-500"></span>
                        Inactive
                    </button>
                    <button type="button" data-value="Suspended" class="status-pill flex items-center gap-2 px-3 py-2 rounded-xl border border-border bg-foreground/5 text-xs transition-all">
                        <span class="w-2 h-2 rounded-full bg-red-500"></span>
                        Suspended
                    </button>
                </div>
                <input type="hidden" id="member-status" value="Active">
            </div>
        </form>
        
        <div class="px-6 py-4 flex items-center justify-end gap-3 border-t border-border">
            <button onclick="closeModal()" class="px-5 py-2.5 rounded-xl text-sm font-semibold border border-border bg-foreground/5 text-sidebar-foreground/60 hover:text-foreground">Cancel</button>
            <button onclick="saveMember()" class="flex items-center gap-2 px-5 py-2.5 rounded-xl text-sm font-semibold text-white bg-gradient-to-br from-green-600 to-green-500 shadow-lg shadow-green-500/40 hover:scale-[1.02] active:scale-[0.98] transition-all">
                <i data-lucide="check" class="size-4"></i>
                Save Member
            </button>
        </div>
    </div>

    <!-- Delete Confirm Modal -->
    <div id="delete-modal" class="modal-content absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-full max-w-sm rounded-3xl overflow-hidden border border-red-500/20 bg-card shadow-2xl hidden">
        <div class="px-6 pt-7 pb-5 text-center">
            <div class="w-16 h-16 rounded-2xl flex items-center justify-center mx-auto mb-4 bg-red-500/10 border border-red-500/20">
                <i data-lucide="trash" class="size-7 text-red-500"></i>
            </div>
            <h3 class="font-bold text-lg text-foreground mb-2">Delete Member?</h3>
            <p class="text-sm text-sidebar-foreground/60 leading-relaxed">
                You're about to permanently remove <span id="delete-member-name" class="font-bold text-foreground"></span>. This action cannot be undone.
            </p>
        </div>
        <div class="px-6 pb-6 flex gap-3">
            <button onclick="closeModal()" class="flex-1 py-2.5 rounded-xl text-sm font-semibold border border-border bg-foreground/5 text-sidebar-foreground/60 hover:text-foreground">Cancel</button>
            <button id="confirm-delete-btn" class="flex-1 flex items-center justify-center gap-2 py-2.5 rounded-xl text-sm font-semibold text-white bg-gradient-to-br from-red-500 to-red-600 shadow-lg shadow-red-500/40 hover:scale-[1.02] active:scale-[0.98] transition-all">
                <i data-lucide="trash" class="size-4"></i>
                Delete
            </button>
        </div>
    </div>

    <!-- Bulk Delete Modal -->
    <div id="bulk-delete-modal" class="modal-content absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-full max-w-sm rounded-3xl overflow-hidden border border-red-500/20 bg-card shadow-2xl hidden">
        <div class="px-6 pt-7 pb-5 text-center">
            <div class="w-16 h-16 rounded-2xl flex items-center justify-center mx-auto mb-4 bg-red-500/10 border border-red-500/20">
                <i data-lucide="trash" class="size-7 text-red-500"></i>
            </div>
            <h3 class="font-bold text-lg text-foreground mb-2">Delete <span id="bulk-delete-count"></span> Members?</h3>
            <p class="text-sm text-sidebar-foreground/60 leading-relaxed">
                All selected members will be permanently removed. This action cannot be undone.
            </p>
        </div>
        <div class="px-6 pb-6 flex gap-3">
            <button onclick="closeModal()" class="flex-1 py-2.5 rounded-xl text-sm font-semibold border border-border bg-foreground/5 text-sidebar-foreground/60 hover:text-foreground">Cancel</button>
            <button onclick="bulkDelete()" class="flex-1 flex items-center justify-center gap-2 py-2.5 rounded-xl text-sm font-semibold text-white bg-gradient-to-br from-red-500 to-red-600 shadow-lg shadow-red-500/40 hover:scale-[1.02] active:scale-[0.98] transition-all">
                <i data-lucide="trash" class="size-4"></i>
                Delete All
            </button>
        </div>
    </div>
</div>

<!-- Toast Container -->
<div id="toast-container" class="fixed top-5 right-5 z-[200] flex flex-col gap-2"></div>

<script src="/js/membership.js"></script>
<%@ include file="includes/footer.jsp" %>
