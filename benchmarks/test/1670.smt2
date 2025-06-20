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

(declare-sort var964 0)
(declare-sort var408 0)
(declare-sort var1026 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1026_isNotEmpty/-1251449450 (String) Bool)
(declare-fun Float64_valueOf/-1382253682 (String) Float64)
(declare-const null-var964 var964)
(declare-const null-String String)
(declare-const var2675 var964) ; Statement: r1 := @this: org.apache.dubbo.common.convert.StringToDoubleConverter 
(assert (not (= var2675 null-var964)))
(declare-const var79 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var79 null-String)))
(define-const var1952 Bool (var1026_isNotEmpty/-1251449450 var79)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = null 
(assert (not (= (ite var1952 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3862 Float64 (Float64_valueOf/-1382253682 var79)) ; Statement: $r2 = staticinvoke <java.lang.Double: java.lang.Double valueOf(java.lang.String)>(r0) 
 ; Statement: goto [?= return $r2] 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var1026_isNotEmpty/-1251449450=([java.lang.String], boolean), Float64_valueOf/-1382253682=([java.lang.String], java.lang.Double)}
; {var964=org.apache.dubbo.common.convert.StringToDoubleConverter, var2675=r1, var79=r0, var408=null_type, var1026=org.apache.dubbo.common.utils.StringUtils, var1952=$z0, var3862=$r2}
; {org.apache.dubbo.common.convert.StringToDoubleConverter=var964, r1=var2675, r0=var79, null_type=var408, org.apache.dubbo.common.utils.StringUtils=var1026, $z0=var1952, $r2=var3862}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.convert.StringToDoubleConverter;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = null;	$r2 = staticinvoke <java.lang.Double: java.lang.Double valueOf(java.lang.String)>(r0);	goto [?= return $r2];	return $r2
;block_num 3