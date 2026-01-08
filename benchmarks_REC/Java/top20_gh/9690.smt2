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

(declare-sort var3829 0)
(declare-sort var705 0)
(declare-sort var1738 0)
(declare-sort var1024 0)
(declare-sort var3137 0)
(declare-sort var1251 0)
(declare-sort var2763 0)
(declare-sort var3435 0)
(declare-sort var3609 0)
(declare-sort var3848 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun size/-1863229846 (var3829) Int)
(declare-fun var1024_stream/-1757820 ((Array Int var3137)) var1738)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var3137__ ((Array Int String)) (Array Int var3137))
(declare-fun var2763_bootstrap$/1705390446 () var1251)
(declare-fun var1738_map/130902797 (var1738 var1251) var1738)
(declare-fun var3609_toList/714215649 () var3435)
(declare-fun var1738_collect/-2050842585 (var1738 var3435) var3137)
(declare-fun cast-from-var3137-to-var3848 (var3137) var3848)
(declare-fun addAll/-313517534 (var3829 var3848) Bool)
(declare-const null-var3829 var3829)
(declare-const null-String String)
(declare-const var1655 var3829) ; Statement: r0 := @parameter0: java.util.ArrayList 
(assert (not (= var1655 null-var3829)))
(declare-const var2901 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2901 null-String)))
(assert true)
(define-const var3268 Int (size/-1863229846 var1655)) ; Statement: $i0 = virtualinvoke r0.<java.util.ArrayList: int size()>() 
(define-const var2378 Int (mod var3268 2)) ; Statement: $i1 = $i0 % 2 
 ; Statement: if $i1 != 1 goto r15 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(":") 
(assert (not (= var2378 1))) ; Cond: $i1 != 1 
; split operation: var1833 = var2901.split(":") ; Statement: r15 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(":") 
(declare-const var1833 (Array Int String))
(define-const var2368 Int (get_split_length var2901 ":" (- 1))) ; Statement: $i2 = lengthof r15 
 ; Statement: if $i2 <= 0 goto $r8 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("=") 
(assert (not (<= var2368 0))) ; Negate: Cond: $i2 <= 0  
(define-const var2634 Int (get_split_length var2901 ":" (- 1))) ; Statement: $i6 = lengthof r15 
(define-const var2408 Int (mod var2634 2)) ; Statement: $i7 = $i6 % 2 
 ; Statement: if $i7 != 0 goto $r8 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("=") 
(assert (not (not (= var2408 0)))) ; Negate: Cond: $i7 != 0  
(define-const var210 var1738 (var1024_stream/-1757820 (cast-from-__Array__Int__String__-to-__Array__Int__var3137__ var1833))) ; Statement: $r10 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>(r15) 
(define-const var554 var1251 var2763_bootstrap$/1705390446) ; Statement: $r9 = staticinvoke <org.apache.dubbo.config.spring.util.DubboAnnotationUtils$trim__589: java.util.function.Function bootstrap$()>() 
(define-const var3309 var1738 (var1738_map/130902797 var210 var554)) ; Statement: $r12 = interfaceinvoke $r10.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r9) 
(define-const var3816 var3435 var3609_toList/714215649) ; Statement: $r11 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toList()>() 
(define-const var851 var3137 (var1738_collect/-2050842585 var3309 var3816)) ; Statement: $r13 = interfaceinvoke $r12.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r11) 
(define-const var817 var3848 (cast-from-var3137-to-var3848 var851)) ; Statement: $r14 = (java.util.Collection) $r13 
(assert true)
;(assert (addAll/-313517534 var1655 var817)) ; Statement: virtualinvoke r0.<java.util.ArrayList: boolean addAll(java.util.Collection)>($r14) 

(declare-const var1655!1 var3829)
(declare-const var817!1 var3848)
 ; Statement: return r0 
(check-sat)
; {size/-1863229846=([java.util.ArrayList], int), var1024_stream/-1757820=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var3137__=([java.lang.String[]], java.lang.Object[]), var2763_bootstrap$/1705390446=([], java.util.function.Function), var1738_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var3609_toList/714215649=([], java.util.stream.Collector), var1738_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var3137-to-var3848=([java.lang.Object], java.util.Collection), addAll/-313517534=([java.util.ArrayList, java.util.Collection], boolean)}
; {var3829=java.util.ArrayList, var1655=r0, var2901=r1, var705=null_type, var3268=$i0, var2378=$i1, var1833=r15, var2368=$i2, var2634=$i6, var2408=$i7, var1738=java.util.stream.Stream, var1024=java.util.Arrays, var3137=java.lang.Object, var210=$r10, var1251=java.util.function.Function, var2763=org.apache.dubbo.config.spring.util.DubboAnnotationUtils$trim__589, var554=$r9, var3309=$r12, var3435=java.util.stream.Collector, var3609=java.util.stream.Collectors, var3816=$r11, var851=$r13, var3848=java.util.Collection, var817=$r14}
; {java.util.ArrayList=var3829, r0=var1655, r1=var2901, null_type=var705, $i0=var3268, $i1=var2378, r15=var1833, $i2=var2368, $i6=var2634, $i7=var2408, java.util.stream.Stream=var1738, java.util.Arrays=var1024, java.lang.Object=var3137, $r10=var210, java.util.function.Function=var1251, org.apache.dubbo.config.spring.util.DubboAnnotationUtils$trim__589=var2763, $r9=var554, $r12=var3309, java.util.stream.Collector=var3435, java.util.stream.Collectors=var3609, $r11=var3816, $r13=var851, java.util.Collection=var3848, $r14=var817}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.util.ArrayList;	r1 := @parameter1: java.lang.String;	$i0 = virtualinvoke r0.<java.util.ArrayList: int size()>();	$i1 = $i0 % 2;	if $i1 != 1 goto r15 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(":");	r15 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(":");	$i2 = lengthof r15;	if $i2 <= 0 goto $r8 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("=");	$i6 = lengthof r15;	$i7 = $i6 % 2;	if $i7 != 0 goto $r8 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("=");	$r10 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>(r15);	$r9 = staticinvoke <org.apache.dubbo.config.spring.util.DubboAnnotationUtils$trim__589: java.util.function.Function bootstrap$()>();	$r12 = interfaceinvoke $r10.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r9);	$r11 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toList()>();	$r13 = interfaceinvoke $r12.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r11);	$r14 = (java.util.Collection) $r13;	virtualinvoke r0.<java.util.ArrayList: boolean addAll(java.util.Collection)>($r14);	return r0
;block_num 4
(exit)
