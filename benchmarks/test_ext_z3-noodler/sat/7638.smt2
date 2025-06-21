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

(declare-sort var3455 0)
(declare-sort var646 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun addParameter/-1629709269 (var3455 String String) var3455)
(declare-const null-var3455 var3455)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2610 var3455) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2610 null-var3455)))
(declare-const var363 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var363 null-String)))
(declare-const var846 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var846 null-Int)))
(define-const var2503 String (String_valueOf/1240665136 var846)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
(assert true)
(define-const var1136 var3455 (addParameter/-1629709269 var2610 var363 var2503)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {String_valueOf/1240665136=([int], java.lang.String), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL)}
; {var3455=org.apache.dubbo.common.URL, var2610=r0, var363=r1, var646=null_type, var846=i0, var2503=$r2, var1136=$r3}
; {org.apache.dubbo.common.URL=var3455, r0=var2610, r1=var363, null_type=var646, i0=var846, $r2=var2503, $r3=var1136}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	i0 := @parameter1: int;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1