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

(declare-sort var638 0)
(declare-sort var2956 0)
(declare-sort var3785 0)
(declare-sort var1307 0)
(declare-sort var1661 0)
(declare-sort var3770 0)
(declare-sort var1115 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3770_convertToSplitName/-325941157 (String String) String)
(declare-fun var1307_contains/1636690605 (var1307 var1115) Bool)
(declare-fun cast-from-String-to-var1115 (String) var1115)
(declare-const null-var638 var638)
(declare-const null-var2956 var2956)
(declare-const null-String String)
(declare-const var1661-securityKey var1307)
(declare-const var2989 var638) ; Statement: r5 := @parameter0: java.util.Map 
(assert (not (= var2989 null-var638)))
(declare-const var2968 var2956) ; Statement: r6 := @parameter1: java.util.Properties 
(assert (not (= var2968 null-var2956)))
(declare-const var2779 String) ; Statement: r0 := @parameter2: java.lang.String 
(assert (not (= var2779 null-String)))
(define-const var677 Bool (ite (= 1 0) true false)) ; Statement: z1 = 0 
; split operation: var2929 = var2779.split("\u005c.") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.") 
(define-const var331 var1307 var1661-securityKey) ; Statement: $r3 = <org.apache.dubbo.common.config.ConfigurationUtils: java.util.Set securityKey> 
(define-const var3375 Int (get_split_length var2779 "\u005c." (- 1))) ; Statement: $i0 = lengthof r1 
(define-const var3941 Int (- var3375 1)) ; Statement: $i1 = $i0 - 1 
(define-const var2055 String (get_split_element var2779 "\u005c." (- 1) var3941)) ; Statement: $r2 = r1[$i1] 
(define-const var2976 String (var3770_convertToSplitName/-325941157 var2055 "-")) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String convertToSplitName(java.lang.String,java.lang.String)>($r2, "-") 
(define-const var3693 Bool (var1307_contains/1636690605 var331 (cast-from-String-to-var1115 var2976))) ; Statement: $z0 = interfaceinvoke $r3.<java.util.Set: boolean contains(java.lang.Object)>($r4) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var3693 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if z1 != 0 goto return 
(assert (not (= (ite var677 1 0) 0))) ; Cond: z1 != 0 
 ; Statement: return 
(check-sat)
; {var3770_convertToSplitName/-325941157=([java.lang.String, java.lang.String], java.lang.String), var1307_contains/1636690605=([java.util.Set, java.lang.Object], boolean), cast-from-String-to-var1115=([java.lang.String], java.lang.Object)}
; {var638=java.util.Map, var2989=r5, var2956=java.util.Properties, var2968=r6, var2779=r0, var3785=null_type, var677=z1, var2929=r1, var1307=java.util.Set, var1661=org.apache.dubbo.common.config.ConfigurationUtils, var331=$r3, var3375=$i0, var3941=$i1, var2055=$r2, var3770=org.apache.dubbo.common.utils.StringUtils, var2976=$r4, var1115=java.lang.Object, var3693=$z0}
; {java.util.Map=var638, r5=var2989, java.util.Properties=var2956, r6=var2968, r0=var2779, null_type=var3785, z1=var677, r1=var2929, java.util.Set=var1307, org.apache.dubbo.common.config.ConfigurationUtils=var1661, $r3=var331, $i0=var3375, $i1=var3941, $r2=var2055, org.apache.dubbo.common.utils.StringUtils=var3770, $r4=var2976, java.lang.Object=var1115, $z0=var3693}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: java.lang.String convertToSplitName(java.lang.String,java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: java.lang.String convertToSplitName(java.lang.String,java.lang.String)>": 1}
;stmts r5 := @parameter0: java.util.Map;	r6 := @parameter1: java.util.Properties;	r0 := @parameter2: java.lang.String;	z1 = 0;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.");	$r3 = <org.apache.dubbo.common.config.ConfigurationUtils: java.util.Set securityKey>;	$i0 = lengthof r1;	$i1 = $i0 - 1;	$r2 = r1[$i1];	$r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String convertToSplitName(java.lang.String,java.lang.String)>($r2, "-");	$z0 = interfaceinvoke $r3.<java.util.Set: boolean contains(java.lang.Object)>($r4);	if $z0 == 0 goto (branch);	if z1 != 0 goto return;	return
;block_num 3
(exit)
