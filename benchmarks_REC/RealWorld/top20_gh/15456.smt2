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

(declare-sort var3571 0)
(declare-sort var3390 0)
(declare-sort var3117 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var3117) void)
(declare-fun cast-from-var3571-to-var3117 (var3571) var3117)
(declare-fun value/-687932879 (var3571) String)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun category/-687932879 (var3571) String)
(declare-fun serviceInterface/-687932879 (var3571) String)
(declare-fun version/-687932879 (var3571) String)
(declare-fun group/-687932879 (var3571) String)
(declare-const null-var3571 var3571)
(declare-const null-String String)
(declare-const var3544 var3571) ; Statement: r0 := @this: org.apache.dubbo.registry.nacos.NacosServiceName 
(assert (not (= var3544 null-var3571)))
(declare-const var3120 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3120 null-String)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var3571-to-var3117 var3544))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var3544!1 var3571)
(declare-const var3544!2 var3571)
(assert (not (= var3544!2 null-var3571)))
(assert (= (value/-687932879 var3544!2) var3120)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String value> = r1 
(define-const var2857 Int (cast-from-Int-to-Int (- 1))) ; Statement: $i1 = (int) (- 1) 
; split operation: var970 = var3120.split(":", var2857) ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i1) 
(define-const var2681 String (get_split_element var3120 ":" var2857 0)) ; Statement: $r3 = r2[0] 
(declare-const var3544!3 var3571)
(assert (not (= var3544!3 null-var3571)))
(assert (= (category/-687932879 var3544!3) var2681)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String category> = $r3 
(define-const var1944 String (get_split_element var3120 ":" var2857 1)) ; Statement: $r4 = r2[1] 
(declare-const var3544!4 var3571)
(assert (not (= var3544!4 null-var3571)))
(assert (= (serviceInterface/-687932879 var3544!4) var1944)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String serviceInterface> = $r4 
(define-const var603 String (get_split_element var3120 ":" var2857 2)) ; Statement: $r5 = r2[2] 
(declare-const var3544!5 var3571)
(assert (not (= var3544!5 null-var3571)))
(assert (= (version/-687932879 var3544!5) var603)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String version> = $r5 
(define-const var2199 String (get_split_element var3120 ":" var2857 3)) ; Statement: $r6 = r2[3] 
(declare-const var3544!6 var3571)
(assert (not (= var3544!6 null-var3571)))
(assert (= (group/-687932879 var3544!6) var2199)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String group> = $r6 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var3571-to-var3117=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.Object), value/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String), cast-from-Int-to-Int=([int], int), category/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String), serviceInterface/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String), version/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String), group/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String)}
; {var3571=org.apache.dubbo.registry.nacos.NacosServiceName, var3544=r0, var3120=r1, var3390=null_type, var3117=java.lang.Object, var2857=$i1, var970=r2, var2681=$r3, var1944=$r4, var603=$r5, var2199=$r6}
; {org.apache.dubbo.registry.nacos.NacosServiceName=var3571, r0=var3544, r1=var3120, null_type=var3390, java.lang.Object=var3117, $i1=var2857, r2=var970, $r3=var2681, $r4=var1944, $r5=var603, $r6=var2199}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.nacos.NacosServiceName;	r1 := @parameter0: java.lang.String;	specialinvoke r0.<java.lang.Object: void <init>()>();	r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String value> = r1;	$i1 = (int) (- 1);	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i1);	$r3 = r2[0];	r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String category> = $r3;	$r4 = r2[1];	r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String serviceInterface> = $r4;	$r5 = r2[2];	r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String version> = $r5;	$r6 = r2[3];	r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String group> = $r6;	return
;block_num 1
(exit)
