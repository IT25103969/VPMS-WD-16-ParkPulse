<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
            </div>
        </main>
    </div>

    <script>
        // Initialize Lucide Icons
        document.addEventListener('DOMContentLoaded', () => {
            lucide.createIcons();
        });
        // Re-initialize icons after Alpine updates (if needed)
        document.addEventListener('alpine:initialized', () => {
            lucide.createIcons();
        });
    </script>
</body>
</html>
