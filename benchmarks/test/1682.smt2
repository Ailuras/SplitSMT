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

(declare-sort var192 0)
(declare-sort var3513 0)
(declare-sort var3753 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3753_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var192 var192)
(declare-const null-String String)
(declare-const null-Float64 Float64)
(declare-const var101 var192) ; Statement: r1 := @this: org.apache.dubbo.common.convert.StringToDoubleConverter 
(assert (not (= var101 null-var192)))
(declare-const var3731 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3731 null-String)))
(define-const var3107 Bool (var3753_isNotEmpty/-1251449450 var3731)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = null 
(assert (= (ite var3107 1 0) 0)) ; Cond: $z0 == 0 
(define-const var543 Float64 null-Float64) ; Statement: $r2 = null 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var3753_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var192=org.apache.dubbo.common.convert.StringToDoubleConverter, var101=r1, var3731=r0, var3513=null_type, var3753=org.apache.dubbo.common.utils.StringUtils, var3107=$z0, var543=$r2}
; {org.apache.dubbo.common.convert.StringToDoubleConverter=var192, r1=var101, r0=var3731, null_type=var3513, org.apache.dubbo.common.utils.StringUtils=var3753, $z0=var3107, $r2=var543}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.convert.StringToDoubleConverter;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = null;	$r2 = null;	return $r2
;block_num 3