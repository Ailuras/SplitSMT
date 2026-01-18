(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun-rec count_matches_rec ((s String) (from Int)) Int
  (let ((pos (str.indexof s delta from)))
    (ite (= pos (- 0 1))
         0
         (+ 1 (count_matches_rec s (+ pos (str.len delta)))))))

(define-fun count_matches ((s String)) Int
  (count_matches_rec s 0))

(define-fun-rec nth_match_start ((s String) (n Int) (from Int)) Int
  (ite (<= n 0) (- 1)
    (let ((p (str.indexof s delta from)))
      (ite (= n 1) p
        (nth_match_start s (- n 1) (+ p (str.len delta)))))))

(define-fun split_at ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun-rec replace_iter ((s String) (sep String) (i Int)) String
  (ite (<= i 0) s
    (replace_iter (str.replace s sep delta) sep (- i 1))))

(define-fun split_rest ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter s sep k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits ((s String) (sep String)) Int
  (let ((tmp (convert_for_split s sep)))
    (+ 1 (count_matches tmp))))
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (num_splits x d) limit)
         (num_splits x d)
         limit)
    (num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits x d) limit))
    (split_rest x d (- limit 1))
    (split_at x d i)
  )
)

(declare-sort var1908 0)
(declare-sort var367 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1908_getProperty/258823597 (String) String)
(declare-const null-String String)
(define-const var2824 String (var1908_getProperty/258823597 "org.mockito.inline.preload")) ; Statement: r3 = staticinvoke <java.lang.System: java.lang.String getProperty(java.lang.String)>("org.mockito.inline.preload") 
 ; Statement: if r3 != null goto $r1 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(assert (not (= var2824 null-String))) ; Cond: r3 != null 
; split operation: var751 = var2824.split(",") ; Statement: $r1 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var2607 Int (get_split_length var2824 "," (- 1))) ; Statement: $i0 = lengthof $r1 
(define-const var1618 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto return 
(assert (>= var1618 var2607)) ; Cond: i1 >= $i0 
 ; Statement: return 
; {var1908_getProperty/258823597=([java.lang.String], java.lang.String)}
; {var1908=java.lang.System, var2824=r3, var367=null_type, var751=$r1, var2607=$i0, var1618=i1}
; {java.lang.System=var1908, r3=var2824, null_type=var367, $r1=var751, $i0=var2607, i1=var1618}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r3 = staticinvoke <java.lang.System: java.lang.String getProperty(java.lang.String)>("org.mockito.inline.preload");	if r3 != null goto $r1 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r1 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$i0 = lengthof $r1;	i1 = 0;	if i1 >= $i0 goto return;	return
;block_num 4
(check-sat)
(exit)
