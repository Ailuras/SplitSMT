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

(declare-sort var3243 0)
(declare-sort var329 0)
(declare-sort var1440 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1440_isEmpty/-813097145 (String) Bool)
(declare-fun var3243_encode/304408814 (String) String)
(declare-fun addParameter/-180549847 (var3243 String String) var3243)
(declare-const null-var3243 var3243)
(declare-const null-String String)
(declare-const var1210 var3243) ; Statement: r1 := @this: com.alibaba.dubbo.common.URL 
(assert (not (= var1210 null-var3243)))
(declare-const var316 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var316 null-String)))
(declare-const var227 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var227 null-String)))
(define-const var736 Bool (var1440_isEmpty/-813097145 var227)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r3 = staticinvoke <com.alibaba.dubbo.common.URL: java.lang.String encode(java.lang.String)>(r0) 
(assert (= (ite var736 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2347 String (var3243_encode/304408814 var227)) ; Statement: $r3 = staticinvoke <com.alibaba.dubbo.common.URL: java.lang.String encode(java.lang.String)>(r0) 
(assert true)
(define-const var2529 var3243 (addParameter/-180549847 var1210 var316 var2347)) ; Statement: $r4 = virtualinvoke r1.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r2, $r3) 
 ; Statement: return $r4 
(check-sat)
; {var1440_isEmpty/-813097145=([java.lang.String], boolean), var3243_encode/304408814=([java.lang.String], java.lang.String), addParameter/-180549847=([com.alibaba.dubbo.common.URL, java.lang.String, java.lang.String], com.alibaba.dubbo.common.URL)}
; {var3243=com.alibaba.dubbo.common.URL, var1210=r1, var316=r2, var329=null_type, var227=r0, var1440=org.apache.dubbo.common.utils.StringUtils, var736=$z0, var2347=$r3, var2529=$r4}
; {com.alibaba.dubbo.common.URL=var3243, r1=var1210, r2=var316, null_type=var329, r0=var227, org.apache.dubbo.common.utils.StringUtils=var1440, $z0=var736, $r3=var2347, $r4=var2529}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: com.alibaba.dubbo.common.URL;	r2 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r3 = staticinvoke <com.alibaba.dubbo.common.URL: java.lang.String encode(java.lang.String)>(r0);	$r3 = staticinvoke <com.alibaba.dubbo.common.URL: java.lang.String encode(java.lang.String)>(r0);	$r4 = virtualinvoke r1.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r2, $r3);	return $r4
;block_num 2