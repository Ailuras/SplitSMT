(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var613 0)
(declare-sort var1435 0)
(declare-sort var973 0)
(declare-sort var468 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var973_parseQueryString/-1071871736 (String) var1435)
(declare-fun var1435_get/1088891777 (var1435 var468) var468)
(declare-fun cast-from-String-to-var468 (String) var468)
(declare-fun cast-from-var468-to-String (var468) String)
(declare-const null-String String)
(declare-const var3504 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3504 null-String)))
(declare-const var560 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var560 null-String)))
(define-const var1870 var1435 (var973_parseQueryString/-1071871736 var3504)) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>(r0) 
(define-const var3211 var468 (var1435_get/1088891777 var1870 (cast-from-String-to-var468 var560))) ; Statement: $r3 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2) 
(define-const var3543 String (cast-from-var468-to-String var3211)) ; Statement: $r4 = (java.lang.String) $r3 
 ; Statement: return $r4 
(check-sat)
; {var973_parseQueryString/-1071871736=([java.lang.String], java.util.Map), var1435_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var468=([java.lang.String], java.lang.Object), cast-from-var468-to-String=([java.lang.Object], java.lang.String)}
; {var3504=r0, var613=null_type, var560=r2, var1435=java.util.Map, var973=org.apache.dubbo.common.utils.StringUtils, var1870=r1, var468=java.lang.Object, var3211=$r3, var3543=$r4}
; {r0=var3504, null_type=var613, r2=var560, java.util.Map=var1435, org.apache.dubbo.common.utils.StringUtils=var973, r1=var1870, java.lang.Object=var468, $r3=var3211, $r4=var3543}
;seq <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>(r0);	$r3 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2);	$r4 = (java.lang.String) $r3;	return $r4
;block_num 1