-- Запрос Select для вывода данных о компонентах зацепления:

```sql
SELECT T1.begin_vac AS engagement_day, GROUP_CONCAT(T1.id_stuff ORDER BY T1.id_stuff) AS id_stuff
FROM kolbasa T1
JOIN (
    SELECT T2.begin_vac, COUNT(*) AS overlap_count
    FROM kolbasa T2
    JOIN kolbasa T3 ON T3.begin_vac <= T2.end_vac AND T3.end_vac >= T2.begin_vac
    GROUP BY T2.begin_vac
    HAVING overlap_count > max_simul_vac
) T4 ON T4.begin_vac <= T1.begin_vac AND T4.begin_vac + INTERVAL T4.overlap_count - 1 DAY >= T1.begin_vac
GROUP BY T1.begin_vac
HAVING COUNT(*) > max_simul_vac;
```
