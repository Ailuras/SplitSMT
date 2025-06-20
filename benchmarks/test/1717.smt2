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

(declare-sort var3900 0)
(declare-sort var3870 0)
(declare-sort var1101 0)
(declare-sort var3513 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1101_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3900 var3900)
(declare-const null-String String)
(declare-const null-var3513 var3513)
(declare-const var393 var3900) ; Statement: r1 := @this: org.apache.dubbo.common.convert.StringToBooleanConverter 
(assert (not (= var393 null-var3900)))
(declare-const var3268 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3268 null-String)))
(define-const var2059 Bool (var1101_isNotEmpty/-1251449450 var3268)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = null 
(assert (= (ite var2059 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3857 var3513 null-var3513) ; Statement: $r2 = null 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var1101_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3900=org.apache.dubbo.common.convert.StringToBooleanConverter, var393=r1, var3268=r0, var3870=null_type, var1101=org.apache.dubbo.common.utils.StringUtils, var2059=$z0, var3513=java.lang.Boolean, var3857=$r2}
; {org.apache.dubbo.common.convert.StringToBooleanConverter=var3900, r1=var393, r0=var3268, null_type=var3870, org.apache.dubbo.common.utils.StringUtils=var1101, $z0=var2059, java.lang.Boolean=var3513, $r2=var3857}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.convert.StringToBooleanConverter;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = null;	$r2 = null;	return $r2
;block_num 3