<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="common/header.jsp" />
<jsp:include page="common/sidebar.jsp" />

<main class="flex-1 overflow-y-auto bg-background" x-data="checkoutData()">
    <div class="p-8">
        <div class="max-w-2xl mx-auto">
            <!-- Checkout released state -->
            <template x-if="released">
                <div class="rounded-2xl border border-border bg-card overflow-hidden shadow-xl animate-in fade-in zoom-in duration-300">
                    <div class="bg-gradient-to-br from-emerald-500 to-emerald-600 p-8 flex flex-col items-center gap-4 text-center">
                        <div class="size-20 bg-white/20 rounded-full flex items-center justify-center">
                            <i data-lucide="check-circle-2" class="size-10 text-white"></i>
                        </div>
                        <div>
                            <h1 class="text-2xl font-bold text-white">Vehicle Released</h1>
                            <p class="text-emerald-100 text-sm mt-1">Slot <span x-text="slotNumber"></span> is now available</p>
                        </div>
                    </div>
                    <div class="p-8 text-center space-y-6">
                        <div class="text-5xl font-bold text-foreground" x-text="'$' + totalCost"></div>
                        <p class="text-sm text-muted-foreground" x-text="durationLabel + ' @ $' + rate + '/h'"></p>
                        <a href="${pageContext.request.contextPath}/" class="block w-full py-3 bg-emerald-600 hover:bg-emerald-700 text-white rounded-xl transition-colors text-center">
                            Done
                        </a>
                    </div>
                </div>
            </template>

            <!-- Checkout form state -->
            <template x-if="!released">
                <div class="rounded-2xl border border-border bg-card overflow-hidden shadow-xl animate-in fade-in slide-in-from-bottom-4 duration-300">
                    <div class="bg-gradient-to-br from-green-400 to-emerald-500 p-6 flex items-center gap-4">
                        <div class="size-12 bg-white/25 rounded-xl flex items-center justify-center shrink-0">
                            <i data-lucide="receipt" class="size-6 text-white"></i>
                        </div>
                        <div>
                            <h1 class="text-xl font-semibold text-white">Vehicle Checkout</h1>
                            <p class="text-green-50 text-sm">Review the session summary before release</p>
                        </div>
                    </div>

                    <div class="p-6 space-y-6">
                        <div class="rounded-xl border border-border divide-y divide-border">
                            <template x-for="row in summaryRows" :key="row.label">
                                <div class="flex items-center justify-between px-4 py-3">
                                    <span class="text-sm text-muted-foreground" x-text="row.label"></span>
                                    <span class="text-sm font-medium text-foreground" x-text="row.value"></span>
                                </div>
                            </template>
                        </div>

                        <div class="rounded-xl p-4 space-y-3 bg-emerald-500/10 border border-emerald-500/25">
                            <div class="flex items-center gap-2 mb-1">
                                <i data-lucide="credit-card" class="size-4 text-emerald-400"></i>
                                <span class="text-sm font-medium text-foreground">Fare Breakdown</span>
                            </div>
                            <div class="flex justify-between text-sm">
                                <span class="text-muted-foreground">Duration</span>
                                <span class="text-foreground" x-text="durationLabel"></span>
                            </div>
                            <div class="flex justify-between text-sm">
                                <span class="text-muted-foreground">Rate</span>
                                <span class="text-foreground" x-text="'$' + rate.toFixed(2) + ' / hr'"></span>
                            </div>
                            <div class="border-t border-emerald-700/30 pt-3 mt-1 flex justify-between">
                                <span class="font-semibold text-foreground">Total</span>
                                <span class="font-semibold text-lg text-emerald-400" x-text="'$' + totalCost"></span>
                            </div>
                        </div>

                        <div class="flex items-center gap-2 px-4 py-3 rounded-xl text-sm bg-emerald-500/10 border border-emerald-500/25 text-emerald-300">
                            <i data-lucide="calendar-clock" class="size-4 shrink-0"></i>
                            <span x-text="entryTime + ' → ' + exitTime"></span>
                        </div>

                        <div class="flex gap-3 pt-1">
                            <a href="${pageContext.request.contextPath}/" class="flex-1 py-3 rounded-xl text-sm bg-muted text-foreground text-center hover:bg-accent transition-colors">
                                Cancel
                            </a>
                            <button @click="releaseVehicle()" class="flex-1 py-3 bg-emerald-500 hover:bg-emerald-600 text-white rounded-xl text-sm flex items-center justify-center gap-2 transition-colors">
                                <i data-lucide="log-out" class="size-4"></i> Confirm Release
                            </button>
                        </div>
                    </div>
                </div>
            </template>
        </div>
    </div>
</main>

<jsp:include page="common/footer.jsp" />
