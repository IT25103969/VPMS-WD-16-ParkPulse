<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout | ParkPulse</title>
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
        (function() {
            const isDark = localStorage.getItem('theme') === 'dark';
            if (isDark) document.documentElement.classList.add('dark');
        })();
    </script>
    <style>
        #sidebar { transition: width 0.25s cubic-bezier(0.4, 0, 0.2, 1); }
        .sidebar-item-text { transition: opacity 0.2s, max-width 0.25s; }
        .collapsed .sidebar-item-text { opacity: 0; max-width: 0; pointer-events: none; }
        .collapsed .logo-text { opacity: 0; transform: translateX(-8px); }
        .logo-text { transition: opacity 0.2s, transform 0.2s; }
    </style>
</head>
<body class="flex h-screen w-full overflow-hidden bg-gray-50 dark:bg-gray-900 text-gray-900 dark:text-white">

    <!-- Sidebar -->
    <aside id="sidebar" class="flex-shrink-0 flex flex-col border-r border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 h-full overflow-hidden" style="width: 220px;">
        <div class="flex items-center gap-3 px-4 py-4 border-b border-gray-200 dark:border-gray-700 min-w-0">
            <button id="sidebar-toggle" class="flex-shrink-0 p-1.5 rounded-lg transition hover:bg-gray-100 dark:hover:bg-gray-700 text-gray-500 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white">
                <i data-lucide="menu" size="20"></i>
            </button>
            <div class="logo-text flex items-center gap-2 min-w-0 overflow-hidden">
                <div class="flex-shrink-0 w-7 h-7 rounded-lg bg-blue-600 flex items-center justify-center">
                    <i data-lucide="activity" size="14" class="text-white"></i>
                </div>
                <span class="font-semibold text-sm whitespace-nowrap truncate">ParkPulse</span>
            </div>
        </div>
        <nav class="flex-1 px-2 py-4 flex flex-col gap-1">
            <a href="tickets" class="flex items-center gap-3 rounded-xl text-sm transition w-full text-left overflow-hidden text-gray-500 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-700 p-[10px_12px]">
                <span class="flex-shrink-0"><i data-lucide="ticket" size="18"></i></span>
                <span class="sidebar-item-text whitespace-nowrap overflow-hidden">Tickets</span>
            </a>
            <a href="revenue" class="flex items-center gap-3 rounded-xl text-sm transition w-full text-left overflow-hidden text-gray-500 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-700 p-[10px_12px]">
                <span class="flex-shrink-0"><i data-lucide="bar-chart-2" size="18"></i></span>
                <span class="sidebar-item-text whitespace-nowrap overflow-hidden">Revenue</span>
            </a>
        </nav>
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
        <!-- Topbar / Header -->
        <div class="flex items-center gap-3 px-6 py-4 border-b border-gray-200 dark:border-gray-700 sticky top-0 z-10 bg-gray-50 dark:bg-gray-900">
            <a href="tickets" class="flex items-center gap-2 px-3 py-2 rounded-xl text-sm transition hover:bg-gray-100 dark:hover:bg-gray-700 text-gray-500 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white">
                <i data-lucide="arrow-left" size="16"></i> Back to Tickets
            </a>
            <div class="h-4 w-px bg-gray-200 dark:bg-gray-700"></div>
            <div class="flex items-center gap-2">
                <i data-lucide="receipt" size="16" class="text-blue-400"></i>
                <span class="text-sm font-medium">Checkout — <span id="header-id"></span></span>
            </div>
            <span id="header-status" class="ml-auto text-xs px-2.5 py-1 rounded-full font-medium"></span>
        </div>

        <div id="checkout-content" class="flex flex-col lg:flex-row gap-6 p-6 max-w-5xl mx-auto w-full overflow-y-auto">
            <!-- Left — ticket details + billing -->
            <div class="flex-1 flex flex-col gap-4">
                <!-- Vehicle card -->
                <div class="rounded-2xl border border-gray-100 dark:border-gray-700 bg-white dark:bg-gray-800 p-5">
                    <div class="flex items-center gap-3 mb-4">
                        <div class="w-10 h-10 rounded-xl bg-blue-500/20 flex items-center justify-center">
                            <i data-lucide="car" size="20" class="text-blue-400"></i>
                        </div>
                        <div>
                            <p id="info-plate" class="font-semibold"></p>
                            <p id="info-type" class="text-xs text-gray-500 dark:text-gray-400"></p>
                        </div>
                        <span id="info-slot" class="ml-auto font-mono text-xs px-2.5 py-1 rounded-lg bg-blue-500/20 text-blue-400"></span>
                    </div>
                    <div class="grid grid-cols-2 gap-3" id="info-grid">
                        <!-- Details injected by JS -->
                    </div>
                </div>

                <!-- Billing breakdown -->
                <div class="rounded-2xl border border-gray-100 dark:border-gray-700 bg-white dark:bg-gray-800 p-5">
                    <p class="text-sm font-semibold mb-4">Billing Breakdown</p>
                    <div class="flex flex-col gap-2.5" id="billing-list">
                        <!-- Rows injected by JS -->
                    </div>
                </div>
            </div>

            <!-- Right — payment + discount + summary -->
            <div class="w-full lg:w-72 flex flex-col gap-4">
                <!-- Payment method -->
                <div class="rounded-2xl border border-gray-100 dark:border-gray-700 bg-white dark:bg-gray-800 p-5">
                    <p class="text-sm font-semibold mb-3">Payment Method</p>
                    <div class="flex flex-col gap-2" id="payment-methods">
                        <button onclick="selectPayment('Cash')" id="pay-Cash" class="pay-btn flex items-center gap-3 px-4 py-3 rounded-xl border text-sm transition border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50">
                            <i data-lucide="banknote" size="18"></i>
                            <span class="flex-1 text-left">Cash</span>
                            <i data-lucide="check-circle-2" size="15" class="hidden text-blue-400 check-icon"></i>
                        </button>
                        <button onclick="selectPayment('Card')" id="pay-Card" class="pay-btn flex items-center gap-3 px-4 py-3 rounded-xl border text-sm transition border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50">
                            <i data-lucide="credit-card" size="18"></i>
                            <span class="flex-1 text-left">Card</span>
                            <i data-lucide="check-circle-2" size="15" class="hidden text-blue-400 check-icon"></i>
                        </button>
                        <button onclick="selectPayment('Mobile')" id="pay-Mobile" class="pay-btn flex items-center gap-3 px-4 py-3 rounded-xl border text-sm transition border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50">
                            <i data-lucide="smartphone" size="18"></i>
                            <span class="flex-1 text-left">Mobile Pay</span>
                            <i data-lucide="check-circle-2" size="15" class="hidden text-blue-400 check-icon"></i>
                        </button>
                    </div>

                    <!-- Card saved indicator -->
                    <div id="card-saved-indicator" class="hidden mt-3 rounded-xl px-3 py-2.5 flex items-center justify-between bg-gray-50 dark:bg-gray-700/50">
                        <div class="flex items-center gap-2">
                            <i data-lucide="credit-card" size="14" class="text-blue-400"></i>
                            <span id="saved-card-number" class="text-xs font-mono">•••• 0000</span>
                        </div>
                        <button onclick="openCardDialog()" class="text-xs text-blue-400 hover:text-blue-300 transition">Edit</button>
                    </div>

                    <!-- Enter card button -->
                    <button id="enter-card-btn" onclick="openCardDialog()" class="hidden mt-3 w-full py-2 rounded-xl border border-dashed border-blue-500/50 text-blue-400 text-xs hover:bg-blue-500/10 transition flex items-center justify-center gap-1.5">
                        <i data-lucide="credit-card" size="13"></i> Enter card details
                    </button>
                </div>

                <!-- Discount -->
                <div class="rounded-2xl border border-gray-100 dark:border-gray-700 bg-white dark:bg-gray-800 p-5">
                    <div class="flex items-center gap-2 mb-3">
                        <i data-lucide="percent" size="14" class="text-amber-400"></i>
                        <p class="text-sm font-semibold">Discount</p>
                    </div>
                    <div class="flex gap-2 mb-3">
                        <button onclick="setDiscountType('percent')" id="discount-percent-btn" class="flex-1 py-1.5 rounded-lg text-xs transition border bg-blue-600 text-white border-blue-600">% Percent</button>
                        <button onclick="setDiscountType('flat')" id="discount-flat-btn" class="flex-1 py-1.5 rounded-lg text-xs transition border border-gray-200 dark:border-gray-600 text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700">රු Flat</button>
                    </div>
                    <div class="relative">
                        <span id="discount-symbol" class="absolute left-3 top-1/2 -translate-y-1/2 text-xs text-gray-500 dark:text-gray-400">%</span>
                        <input type="number" id="discount-value" placeholder="0" class="w-full pl-8 rounded-xl px-3 py-2 text-sm border border-gray-200 dark:border-gray-600 bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white outline-none focus:ring-2 focus:ring-blue-500 transition">
                    </div>
                    <p id="discount-info" class="hidden text-xs text-emerald-400 mt-2"></p>
                </div>

                <!-- Amount summary -->
                <div class="rounded-2xl border border-gray-100 dark:border-gray-700 bg-white dark:bg-gray-800 p-5">
                    <span class="text-xs text-gray-500 dark:text-gray-400">Amount Due</span>
                    <p id="total-amount" class="text-3xl font-semibold text-emerald-400 mt-1">Rs 0.00</p>
                    <p id="original-amount" class="hidden text-xs mt-1 line-through text-gray-500 dark:text-gray-400">Rs 0.00</p>
                    <p class="text-xs mt-1 text-gray-500 dark:text-gray-400">Parking charges only</p>
                </div>

                <button id="confirm-pay-btn" onclick="confirmPayment()" class="w-full py-3.5 rounded-2xl bg-blue-600 hover:bg-blue-700 active:scale-95 text-white font-semibold text-sm transition flex items-center justify-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed">
                    <i data-lucide="check-circle-2" size="17"></i>
                    Confirm Payment
                </button>

                <button id="print-receipt-btn" class="w-full py-3 rounded-2xl text-sm transition border border-gray-200 dark:border-gray-700 text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 dark:hover:text-white flex items-center justify-center gap-2">
                    <i data-lucide="printer" size="15"></i> Print Ticket
                </button>

                <p id="payment-warning" class="hidden text-center text-xs text-amber-400">Please enter card details to proceed</p>

                <a href="tickets" class="w-full py-3 rounded-2xl text-sm text-center transition border border-gray-200 dark:border-gray-700 text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 dark:hover:text-white">
                    Cancel
                </a>
            </div>
        </div>

        <!-- Success Screen -->
        <div id="success-screen" class="hidden flex flex-col items-center justify-center h-full gap-5">
            <div class="flex flex-col items-center gap-4">
                <div class="w-20 h-20 rounded-full bg-emerald-500/20 flex items-center justify-center">
                    <i data-lucide="check-circle-2" size="40" class="text-emerald-400"></i>
                </div>
                <div class="text-center">
                    <p class="text-xl font-semibold">Payment Confirmed</p>
                    <p id="success-msg" class="text-sm mt-1 text-gray-500 dark:text-gray-400"></p>
                </div>
                <div class="rounded-2xl border border-gray-100 dark:border-gray-700 bg-white dark:bg-gray-800 px-6 py-3 text-center">
                    <p class="text-xs text-gray-500 dark:text-gray-400">Total Charged</p>
                    <p id="success-total" class="text-3xl font-semibold text-emerald-400 mt-1"></p>
                </div>
                <button id="success-print-btn" class="flex items-center gap-2 px-5 py-2.5 rounded-xl bg-emerald-600 hover:bg-emerald-700 text-white text-sm transition">
                    <i data-lucide="printer" size="15"></i> Print Receipt
                </button>
                <p class="text-xs text-gray-500 dark:text-gray-400">Redirecting back…</p>
            </div>
        </div>
    </main>

    <!-- Card Details Dialog -->
    <div id="card-modal" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm">
        <div class="w-full max-w-sm rounded-2xl shadow-2xl overflow-hidden bg-white dark:bg-gray-800 text-gray-900 dark:text-white">
            <div class="flex items-center justify-between px-5 py-4 border-b border-gray-100 dark:border-gray-700">
                <div class="flex items-center gap-2">
                    <div class="w-7 h-7 rounded-lg bg-blue-600 flex items-center justify-center">
                        <i data-lucide="credit-card" size="14" class="text-white"></i>
                    </div>
                    <span class="font-semibold text-sm">Card Details</span>
                </div>
                <button onclick="closeCardDialog()" class="p-1.5 rounded-lg transition hover:bg-gray-100 dark:hover:bg-gray-700 text-gray-400">
                    <i data-lucide="x" size="16"></i>
                </button>
            </div>
            
            <div class="px-5 pt-4">
                <div class="rounded-2xl bg-gradient-to-br from-blue-600 to-blue-800 p-4 text-white relative overflow-hidden">
                    <div class="absolute top-0 right-0 w-32 h-32 rounded-full bg-white/5 -translate-y-8 translate-x-8"></div>
                    <div class="absolute bottom-0 left-0 w-24 h-24 rounded-full bg-white/5 translate-y-8 -translate-x-8"></div>
                    <div class="flex items-center justify-between mb-6">
                        <span class="text-xs opacity-70">ParkPulse Pay</span>
                        <i data-lucide="credit-card" size="20" class="opacity-70"></i>
                    </div>
                    <p id="card-preview-number" class="font-mono text-base tracking-widest mb-3 opacity-90">•••• •••• •••• ••••</p>
                    <div class="flex items-end justify-between">
                        <div>
                            <p class="text-[10px] opacity-60 mb-0.5">Card Holder</p>
                            <p id="card-preview-name" class="text-sm font-medium">YOUR NAME</p>
                        </div>
                        <div class="text-right">
                            <p class="text-[10px] opacity-60 mb-0.5">Expires</p>
                            <p id="card-preview-expiry" class="text-sm font-medium">MM/YY</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="px-5 py-4 flex flex-col gap-3">
                <div>
                    <label class="text-xs mb-1.5 block text-gray-500 dark:text-gray-400">Cardholder Name</label>
                    <input id="card-name" placeholder="John Doe" class="card-input w-full rounded-xl px-3 py-2.5 text-sm border border-gray-200 dark:border-gray-600 bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white outline-none focus:ring-2 transition">
                    <p id="err-name" class="hidden text-xs text-red-400 mt-1 flex items-center gap-1"><i data-lucide="alert-circle" size="11"></i> Required</p>
                </div>
                <div>
                    <label class="text-xs mb-1.5 block text-gray-500 dark:text-gray-400">Card Number</label>
                    <input id="card-number" placeholder="1234 5678 9012 3456" class="card-input w-full rounded-xl px-3 py-2.5 text-sm border border-gray-200 dark:border-gray-600 bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white outline-none focus:ring-2 transition">
                    <p id="err-number" class="hidden text-xs text-red-400 mt-1 flex items-center gap-1"><i data-lucide="alert-circle" size="11"></i> Must be 16 digits</p>
                </div>
                <div class="grid grid-cols-2 gap-3">
                    <div>
                        <label class="text-xs mb-1.5 block text-gray-500 dark:text-gray-400">Expiry Date</label>
                        <input id="card-expiry" placeholder="MM/YY" class="card-input w-full rounded-xl px-3 py-2.5 text-sm border border-gray-200 dark:border-gray-600 bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white outline-none focus:ring-2 transition">
                        <p id="err-expiry" class="hidden text-xs text-red-400 mt-1 flex items-center gap-1"><i data-lucide="alert-circle" size="11"></i> MM/YY format</p>
                    </div>
                    <div>
                        <label class="text-xs mb-1.5 block text-gray-500 dark:text-gray-400">CVV</label>
                        <input id="card-cvv" type="password" maxlength="4" placeholder="•••" class="card-input w-full rounded-xl px-3 py-2.5 text-sm border border-gray-200 dark:border-gray-600 bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white outline-none focus:ring-2 transition">
                        <p id="err-cvv" class="hidden text-xs text-red-400 mt-1 flex items-center gap-1"><i data-lucide="alert-circle" size="11"></i> 3–4 digits</p>
                    </div>
                </div>
            </div>

            <div class="flex gap-3 px-5 py-4 border-t border-gray-100 dark:border-gray-700">
                <button onclick="closeCardDialog()" class="flex-1 py-2.5 rounded-xl text-sm border border-gray-200 dark:border-gray-600 text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 transition">Cancel</button>
                <button onclick="saveCard()" class="flex-1 py-2.5 rounded-xl text-sm bg-blue-600 hover:bg-blue-700 text-white transition flex items-center justify-center gap-2 font-medium">
                    <i data-lucide="lock" size="13"></i> Save Card
                </button>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="js/core.js"></script>
    <script src="js/checkout.js"></script>
    <script>lucide.createIcons();</script>
</body>
</html>
