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

(declare-sort var3280 0)
(declare-sort var1650 0)
(declare-sort var241 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceParameter/1782298180 (var3280 String String) String)
(declare-fun var241_isEmpty/-813097145 (String) Bool)
(declare-const null-var3280 var3280)
(declare-const null-String String)
(declare-const null-Float32 Float32)
(declare-const var1590 var3280) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1590 null-var3280)))
(declare-const var3950 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3950 null-String)))
(declare-const var1448 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1448 null-String)))
(declare-const var3479 Float32) ; Statement: f1 := @parameter2: float 
(assert (not (= var3479 null-Float32)))
(assert true)
(define-const var3639 String (getServiceParameter/1782298180 var1590 var3950 var1448)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var3798 Bool (var241_isEmpty/-813097145 var3639)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r3) 
(assert (not (= (ite var3798 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return f1 
(check-sat)
; {getServiceParameter/1782298180=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var241_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3280=org.apache.dubbo.common.URL, var1590=r0, var3950=r1, var1650=null_type, var1448=r2, var3479=f1, var3639=r3, var241=org.apache.dubbo.common.utils.StringUtils, var3798=$z0}
; {org.apache.dubbo.common.URL=var3280, r0=var1590, r1=var3950, null_type=var1650, r2=var1448, f1=var3479, r3=var3639, org.apache.dubbo.common.utils.StringUtils=var241, $z0=var3798}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	f1 := @parameter2: float;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r3);	return f1
;block_num 2