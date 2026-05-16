    </div> <!-- Close flex container from header -->
    
    <script src="${pageContext.request.contextPath}/js/app.js"></script>
    <script>
        // Initialize Lucide icons
        document.addEventListener('alpine:initialized', () => {
            lucide.createIcons();
        });
        
        // Re-run lucide on Alpine component changes if needed
        window.refreshIcons = () => {
            lucide.createIcons();
        };
    </script>
</body>
</html>
