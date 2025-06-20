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

(declare-sort var2566 0)
(declare-sort var282 0)
(declare-sort var1604 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2015795402 (var2566 String String) String)
(declare-fun var1604_isEmpty/-813097145 (String) Bool)
(declare-fun Float32_parseFloat/-1274905469 (String) Float32)
(declare-const null-var2566 var2566)
(declare-const null-String String)
(declare-const null-Float32 Float32)
(declare-const var3734 var2566) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3734 null-var2566)))
(declare-const var1394 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1394 null-String)))
(declare-const var826 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var826 null-String)))
(declare-const var3366 Float32) ; Statement: f1 := @parameter2: float 
(assert (not (= var3366 null-Float32)))
(assert true)
(define-const var3023 String (getMethodParameter/2015795402 var3734 var1394 var826)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var1893 Bool (var1604_isEmpty/-813097145 var3023)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r3) 
(assert (= (ite var1893 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1244 Float32 (Float32_parseFloat/-1274905469 var3023)) ; Statement: $f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r3) 
 ; Statement: return $f0 
(check-sat)
; {getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var1604_isEmpty/-813097145=([java.lang.String], boolean), Float32_parseFloat/-1274905469=([java.lang.String], float)}
; {var2566=org.apache.dubbo.common.URL, var3734=r0, var1394=r1, var282=null_type, var826=r2, var3366=f1, var3023=r3, var1604=org.apache.dubbo.common.utils.StringUtils, var1893=$z0, var1244=$f0}
; {org.apache.dubbo.common.URL=var2566, r0=var3734, r1=var1394, null_type=var282, r2=var826, f1=var3366, r3=var3023, org.apache.dubbo.common.utils.StringUtils=var1604, $z0=var1893, $f0=var1244}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	f1 := @parameter2: float;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r3);	$f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r3);	return $f0
;block_num 2