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

(declare-sort var3990 0)
(declare-sort var3410 0)
(declare-sort var1258 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2015795402 (var3990 String String) String)
(declare-fun var1258_isEmpty/-813097145 (String) Bool)
(declare-const null-var3990 var3990)
(declare-const null-String String)
(declare-const null-Float32 Float32)
(declare-const var828 var3990) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var828 null-var3990)))
(declare-const var3420 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3420 null-String)))
(declare-const var1193 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1193 null-String)))
(declare-const var3764 Float32) ; Statement: f1 := @parameter2: float 
(assert (not (= var3764 null-Float32)))
(assert true)
(define-const var2611 String (getMethodParameter/2015795402 var828 var3420 var1193)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var688 Bool (var1258_isEmpty/-813097145 var2611)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r3) 
(assert (not (= (ite var688 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return f1 
(check-sat)
; {getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var1258_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3990=org.apache.dubbo.common.URL, var828=r0, var3420=r1, var3410=null_type, var1193=r2, var3764=f1, var2611=r3, var1258=org.apache.dubbo.common.utils.StringUtils, var688=$z0}
; {org.apache.dubbo.common.URL=var3990, r0=var828, r1=var3420, null_type=var3410, r2=var1193, f1=var3764, r3=var2611, org.apache.dubbo.common.utils.StringUtils=var1258, $z0=var688}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	f1 := @parameter2: float;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r3);	return f1
;block_num 2