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

(declare-sort var2237 0)
(declare-sort var3497 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3497_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-String String)
(declare-const var3234 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3234 null-String)))
(define-const var1096 Bool (var3497_isNotEmpty/-1251449450 var3234)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $z7 = 0 
(assert (= (ite var1096 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2297 Bool (ite (= 1 0) true false)) ; Statement: $z7 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z7 
(check-sat)
; {var3497_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3234=r0, var2237=null_type, var3497=org.apache.dubbo.common.utils.StringUtils, var1096=$z0, var2297=$z7}
; {r0=var3234, null_type=var2237, org.apache.dubbo.common.utils.StringUtils=var3497, $z0=var1096, $z7=var2297}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $z7 = 0;	$z7 = 0;	return $z7
;block_num 3