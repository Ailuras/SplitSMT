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

(declare-sort var2537 0)
(declare-sort var1429 0)
(declare-sort var1126 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1126_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2537 var2537)
(declare-const null-String String)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var3129 var2537) ; Statement: r1 := @this: org.apache.dubbo.common.convert.StringToCharArrayConverter 
(assert (not (= var3129 null-var2537)))
(declare-const var36 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var36 null-String)))
(define-const var1467 Bool (var1126_isNotEmpty/-1251449450 var36)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = null 
(assert (= (ite var1467 1 0) 0)) ; Cond: $z0 == 0 
(define-const var420 (Array Int Int) null-__Array__Int__Int__) ; Statement: $r2 = null 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var1126_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2537=org.apache.dubbo.common.convert.StringToCharArrayConverter, var3129=r1, var36=r0, var1429=null_type, var1126=org.apache.dubbo.common.utils.StringUtils, var1467=$z0, var420=$r2}
; {org.apache.dubbo.common.convert.StringToCharArrayConverter=var2537, r1=var3129, r0=var36, null_type=var1429, org.apache.dubbo.common.utils.StringUtils=var1126, $z0=var1467, $r2=var420}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.convert.StringToCharArrayConverter;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = null;	$r2 = null;	return $r2
;block_num 3