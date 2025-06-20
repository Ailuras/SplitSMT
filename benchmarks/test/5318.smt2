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

(declare-sort var3488 0)
(declare-sort var2373 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2373_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-String String)
(declare-const var1746 (Array Int String)) ; Statement: r1 := @parameter0: java.lang.String[] 
(assert (not (= var1746 null-__Array__Int__String__)))
(declare-const var2390 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2390 null-String)))
(define-const var103 Bool (var2373_isNotEmpty/-1251449450 var2390)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto return 0 
(assert (= (ite var103 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 0 
(check-sat)
; {var2373_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1746=r1, var2390=r0, var3488=null_type, var2373=org.apache.dubbo.common.utils.StringUtils, var103=$z0}
; {r1=var1746, r0=var2390, null_type=var3488, org.apache.dubbo.common.utils.StringUtils=var2373, $z0=var103}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.lang.String[];	r0 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto return 0;	return 0
;block_num 2