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

(declare-sort var2667 0)
(declare-sort var1240 0)
(declare-sort var1730 0)
(declare-sort var900 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var2667_contains/-441121415 (var2667 var900) Bool)
(declare-fun cast-from-String-to-var900 (String) var900)
(declare-const null-var2667 var2667)
(declare-const null-String String)
(declare-const var1730-SERVICE_NAME_SEPARATOR String)
(declare-const var431 var2667) ; Statement: r4 := @parameter0: java.util.List 
(assert (not (= var431 null-var2667)))
(declare-const var113 String) ; Statement: r6 := @parameter1: java.lang.String 
(assert (not (= var113 null-String)))
(declare-const var3145 String) ; Statement: r8 := @parameter2: java.lang.String 
(assert (not (= var3145 null-String)))
(declare-const var1950 String) ; Statement: r10 := @parameter3: java.lang.String 
(assert (not (= var1950 null-String)))
(declare-const var642 String) ; Statement: r0 := @parameter4: java.lang.String 
(assert (not (= var642 null-String)))
(define-const var585 String var1730-SERVICE_NAME_SEPARATOR) ; Statement: $r1 = <org.apache.dubbo.registry.nacos.NacosRegistry: java.lang.String SERVICE_NAME_SEPARATOR> 
(define-const var3317 Int (cast-from-Int-to-Int (- 1))) ; Statement: $i2 = (int) (- 1) 
; split operation: var3054 = var642.split(var585, var3317) ; Statement: r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>($r1, $i2) 
(define-const var2555 Int (get_split_length var642 var585 var3317)) ; Statement: i0 = lengthof r2 
 ; Statement: if i0 == 4 goto r3 = r2[0] 
(assert (= var2555 4)) ; Cond: i0 == 4 
(define-const var3382 String (get_split_element var642 var585 var3317 0)) ; Statement: r3 = r2[0] 
(define-const var2472 Bool (var2667_contains/-441121415 var431 (cast-from-String-to-var900 var3382))) ; Statement: $z0 = interfaceinvoke r4.<java.util.List: boolean contains(java.lang.Object)>(r3) 
 ; Statement: if $z0 != 0 goto r5 = r2[1] 
(assert (not (not (= (ite var2472 1 0) 0)))) ; Negate: Cond: $z0 != 0  
 ; Statement: return 0 
; {cast-from-Int-to-Int=([int], int), var2667_contains/-441121415=([java.util.List, java.lang.Object], boolean), cast-from-String-to-var900=([java.lang.String], java.lang.Object)}
; {var2667=java.util.List, var431=r4, var113=r6, var1240=null_type, var3145=r8, var1950=r10, var642=r0, var1730=org.apache.dubbo.registry.nacos.NacosRegistry, var585=$r1, var3317=$i2, var3054=r2, var2555=i0, var3382=r3, var900=java.lang.Object, var2472=$z0}
; {java.util.List=var2667, r4=var431, r6=var113, null_type=var1240, r8=var3145, r10=var1950, r0=var642, org.apache.dubbo.registry.nacos.NacosRegistry=var1730, $r1=var585, $i2=var3317, r2=var3054, i0=var2555, r3=var3382, java.lang.Object=var900, $z0=var2472}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r4 := @parameter0: java.util.List;	r6 := @parameter1: java.lang.String;	r8 := @parameter2: java.lang.String;	r10 := @parameter3: java.lang.String;	r0 := @parameter4: java.lang.String;	$r1 = <org.apache.dubbo.registry.nacos.NacosRegistry: java.lang.String SERVICE_NAME_SEPARATOR>;	$i2 = (int) (- 1);	r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>($r1, $i2);	i0 = lengthof r2;	if i0 == 4 goto r3 = r2[0];	r3 = r2[0];	$z0 = interfaceinvoke r4.<java.util.List: boolean contains(java.lang.Object)>(r3);	if $z0 != 0 goto r5 = r2[1];	return 0
;block_num 3
(check-sat)
(exit)
