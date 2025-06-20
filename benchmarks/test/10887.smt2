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

(declare-sort var1346 0)
(declare-sort var2947 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-1973653463 (Bool) String)
(declare-fun addParameter/-180549847 (var1346 String String) var1346)
(declare-const null-var1346 var1346)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var937 var1346) ; Statement: r0 := @this: com.alibaba.dubbo.common.URL 
(assert (not (= var937 null-var1346)))
(declare-const var3289 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3289 null-String)))
(declare-const var3918 Bool) ; Statement: z0 := @parameter1: boolean 
(assert (not (= var3918 null-Bool)))
(define-const var2028 String (String_valueOf/-1973653463 var3918)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(z0) 
(assert true)
(define-const var366 var1346 (addParameter/-180549847 var937 var3289 var2028)) ; Statement: $r3 = virtualinvoke r0.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {String_valueOf/-1973653463=([boolean], java.lang.String), addParameter/-180549847=([com.alibaba.dubbo.common.URL, java.lang.String, java.lang.String], com.alibaba.dubbo.common.URL)}
; {var1346=com.alibaba.dubbo.common.URL, var937=r0, var3289=r1, var2947=null_type, var3918=z0, var2028=$r2, var366=$r3}
; {com.alibaba.dubbo.common.URL=var1346, r0=var937, r1=var3289, null_type=var2947, z0=var3918, $r2=var2028, $r3=var366}
;seq <java.lang.String: java.lang.String valueOf(boolean)>
;cnt {"<java.lang.String: java.lang.String valueOf(boolean)>": 1}
;stmts r0 := @this: com.alibaba.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	z0 := @parameter1: boolean;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(z0);	$r3 = virtualinvoke r0.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1