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

(declare-sort var2576 0)
(declare-sort var451 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-149410723 (Float32) String)
(declare-fun addParameter/-180549847 (var2576 String String) var2576)
(declare-const null-var2576 var2576)
(declare-const null-String String)
(declare-const null-Float32 Float32)
(declare-const var3462 var2576) ; Statement: r0 := @this: com.alibaba.dubbo.common.URL 
(assert (not (= var3462 null-var2576)))
(declare-const var805 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var805 null-String)))
(declare-const var3821 Float32) ; Statement: f0 := @parameter1: float 
(assert (not (= var3821 null-Float32)))
(define-const var1058 String (String_valueOf/-149410723 var3821)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(float)>(f0) 
(assert true)
(define-const var511 var2576 (addParameter/-180549847 var3462 var805 var1058)) ; Statement: $r3 = virtualinvoke r0.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {String_valueOf/-149410723=([float], java.lang.String), addParameter/-180549847=([com.alibaba.dubbo.common.URL, java.lang.String, java.lang.String], com.alibaba.dubbo.common.URL)}
; {var2576=com.alibaba.dubbo.common.URL, var3462=r0, var805=r1, var451=null_type, var3821=f0, var1058=$r2, var511=$r3}
; {com.alibaba.dubbo.common.URL=var2576, r0=var3462, r1=var805, null_type=var451, f0=var3821, $r2=var1058, $r3=var511}
;seq <java.lang.String: java.lang.String valueOf(float)>
;cnt {"<java.lang.String: java.lang.String valueOf(float)>": 1}
;stmts r0 := @this: com.alibaba.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	f0 := @parameter1: float;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(float)>(f0);	$r3 = virtualinvoke r0.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1