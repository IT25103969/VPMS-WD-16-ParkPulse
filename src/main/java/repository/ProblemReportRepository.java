package repository;

import model.ProblemReport;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ConcurrentSkipListMap;
import java.util.stream.Collectors;

public class ProblemReportRepository {

    private final Map<Long, ProblemReport> storage = new ConcurrentSkipListMap<>();
    private Long currentId = 1L;

    public ProblemReport save(ProblemReport report){
        if (report.getId() == null){
            report.setId(currentId++);
        }
        storage.put(report.getId(), report);
        return report;
    }

    public List<ProblemReport> findAll(){
        return new ArrayList<>(storage.values());
    }

    public List<ProblemReport> findAllOrderByDateDesc(){
        return storage.values().stream()
                .sorted((a, b) -> b.getReportedAt().compareTo(a.getReportedAt()))
                .collect(Collectors.toList());
    }

    public Optional<ProblemReport> findById(Long id){
        return Optional.ofNullable(storage.get(id));
    }

    public List<ProblemReport> findByUserId(Long userId){
        return storage.values().stream()
                .filter(r -> r.getUserId().equals(userId))
                .sorted((a, b) -> b.getReportedAt().compareTo(a.getReportedAt()))
                .collect(Collectors.toList());
    }

    public List<ProblemReport> findByStatus(String status){
        return storage.values().stream()
                .filter(r -> r.getStatus().equalsIgnoreCase(status))
                .collect(Collectors.toList());
    }

    public ProblemReport update(ProblemReport report){
        if (storage.containsKey(report.getId())){
            storage.put(report.getId(), report);
            return report;
        }
        throw new RuntimeException("Report not found with ID : "+report.getId());
    }

    public void deleteById(Long id){
        storage.remove(id);
    }

    public long countPending(){
        return storage.values().stream()
                .filter(r -> "Pending".equals(r.getStatus()))
                .count();
    }

    public boolean existsById(Long id){
        return storage.containsKey(id);
    }
}
