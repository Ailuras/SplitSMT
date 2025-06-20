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

(declare-sort var2729 0)
(declare-sort var3205 0)
(declare-sort var127 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var127_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2729 var2729)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var436 var2729) ; Statement: r1 := @this: org.apache.dubbo.common.convert.StringToShortConverter 
(assert (not (= var436 null-var2729)))
(declare-const var614 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var614 null-String)))
(define-const var2415 Bool (var127_isNotEmpty/-1251449450 var614)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = null 
(assert (= (ite var2415 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3361 Int null-Int) ; Statement: $r2 = null 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var127_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2729=org.apache.dubbo.common.convert.StringToShortConverter, var436=r1, var614=r0, var3205=null_type, var127=org.apache.dubbo.common.utils.StringUtils, var2415=$z0, var3361=$r2}
; {org.apache.dubbo.common.convert.StringToShortConverter=var2729, r1=var436, r0=var614, null_type=var3205, org.apache.dubbo.common.utils.StringUtils=var127, $z0=var2415, $r2=var3361}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.convert.StringToShortConverter;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = null;	$r2 = null;	return $r2
;block_num 3