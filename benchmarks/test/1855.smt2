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

(declare-sort var737 0)
(declare-sort var3474 0)
(declare-sort var2924 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2924_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var737 var737)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1687 var737) ; Statement: r1 := @this: org.apache.dubbo.common.convert.StringToLongConverter 
(assert (not (= var1687 null-var737)))
(declare-const var526 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var526 null-String)))
(define-const var149 Bool (var2924_isNotEmpty/-1251449450 var526)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = null 
(assert (= (ite var149 1 0) 0)) ; Cond: $z0 == 0 
(define-const var958 Int null-Int) ; Statement: $r2 = null 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var2924_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var737=org.apache.dubbo.common.convert.StringToLongConverter, var1687=r1, var526=r0, var3474=null_type, var2924=org.apache.dubbo.common.utils.StringUtils, var149=$z0, var958=$r2}
; {org.apache.dubbo.common.convert.StringToLongConverter=var737, r1=var1687, r0=var526, null_type=var3474, org.apache.dubbo.common.utils.StringUtils=var2924, $z0=var149, $r2=var958}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.convert.StringToLongConverter;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = null;	$r2 = null;	return $r2
;block_num 3