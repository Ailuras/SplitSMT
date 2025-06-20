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

(declare-sort var111 0)
(declare-sort var1954 0)
(declare-sort var3267 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3267_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var111 var111)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var707 var111) ; Statement: r1 := @this: org.apache.dubbo.common.convert.StringToIntegerConverter 
(assert (not (= var707 null-var111)))
(declare-const var2202 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2202 null-String)))
(define-const var721 Bool (var3267_isNotEmpty/-1251449450 var2202)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = null 
(assert (= (ite var721 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1830 Int null-Int) ; Statement: $r2 = null 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var3267_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var111=org.apache.dubbo.common.convert.StringToIntegerConverter, var707=r1, var2202=r0, var1954=null_type, var3267=org.apache.dubbo.common.utils.StringUtils, var721=$z0, var1830=$r2}
; {org.apache.dubbo.common.convert.StringToIntegerConverter=var111, r1=var707, r0=var2202, null_type=var1954, org.apache.dubbo.common.utils.StringUtils=var3267, $z0=var721, $r2=var1830}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.convert.StringToIntegerConverter;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = null;	$r2 = null;	return $r2
;block_num 3