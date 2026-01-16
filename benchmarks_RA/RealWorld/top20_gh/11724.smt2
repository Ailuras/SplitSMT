(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun count_matches ((s String)) Int
  (ite (= (str.len s) 0) 0
    (let ((len_s (str.len s))
          (len_removed (str.len (str.replace_all s delta ""))))
      (- len_s len_removed))))

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

(define-fun convert_for_split_re ((s String) (r (RegEx String))) String
  (str.replace_re_all s r delta))

(define-fun-rec replace_iter_re ((s String) (r (RegEx String)) (i Int)) String
  (ite (<= i 0) s
    (replace_iter_re (str.replace_re s r delta) r (- i 1))))

(define-fun split_at_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
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

(define-fun split_rest_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter_re s r k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits_re ((s String) (r (RegEx String))) Int
  (let ((tmp (convert_for_split_re s r)))
    (+ 1 (count_matches tmp))))
(declare-fun split_at_re (String RegLan Int) String)
(declare-fun split_rest_re (String RegLan Int) String)
(declare-fun num_splits_re (String RegLan) Int)

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

(define-fun get_split_length_re ((x String) (d RegLan) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (num_splits_re x d) limit)
         (num_splits_re x d)
         limit)
    (num_splits_re x d)
  )
)

(define-fun get_split_element_re ((x String) (d RegLan) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits_re x d) limit))
    (split_rest_re x d (- limit 1))
    (split_at_re x d i)
  )
)

(declare-sort var1468 0)
(declare-sort var2487 0)
(declare-sort var3099 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1468_getServiceModel/1214805812 (var1468) var2487)
(declare-fun var1468_getTargetServiceUniqueName/-1786712159 (var1468) String)
(declare-const null-var1468 var1468)
(declare-const null-var2487 var2487)
(declare-const null-String String)
(declare-const var255 var1468) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var255 null-var1468)))
(define-const var1049 var2487 (var1468_getServiceModel/1214805812 var255)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: org.apache.dubbo.rpc.model.ServiceModel getServiceModel()>() 
 ; Statement: if $r1 == null goto $r4 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>() 
(assert (= var1049 null-var2487)) ; Cond: $r1 == null 
(define-const var691 String (var1468_getTargetServiceUniqueName/-1786712159 var255)) ; Statement: $r4 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>() 
(define-const var2035 String null-String) ; Statement: r9 = null 
; split operation: var1473 = var691.split("/") ; Statement: $r5 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var1461 Int (get_split_length var691 "/" (- 1))) ; Statement: $i0 = lengthof $r5 
 ; Statement: if $i0 != 2 goto return r9 
(assert (not (= var1461 2))) ; Cond: $i0 != 2 
 ; Statement: return r9 
; {var1468_getServiceModel/1214805812=([org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.model.ServiceModel), var1468_getTargetServiceUniqueName/-1786712159=([org.apache.dubbo.rpc.Invocation], java.lang.String)}
; {var1468=org.apache.dubbo.rpc.Invocation, var255=r0, var2487=org.apache.dubbo.rpc.model.ServiceModel, var1049=$r1, var691=$r4, var3099=null_type, var2035=r9, var1473=$r5, var1461=$i0}
; {org.apache.dubbo.rpc.Invocation=var1468, r0=var255, org.apache.dubbo.rpc.model.ServiceModel=var2487, $r1=var1049, $r4=var691, null_type=var3099, r9=var2035, $r5=var1473, $i0=var1461}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: org.apache.dubbo.rpc.model.ServiceModel getServiceModel()>();	if $r1 == null goto $r4 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>();	$r4 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>();	r9 = null;	$r5 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	$i0 = lengthof $r5;	if $i0 != 2 goto return r9;	return r9
;block_num 3
(check-sat)
(exit)
