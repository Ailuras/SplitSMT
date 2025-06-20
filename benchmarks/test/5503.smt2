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

(declare-sort var1284 0)
(declare-sort var3714 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3714_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3714-EMPTY_STRING_ARRAY (Array Int String))
(declare-const var354 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var354 null-String)))
(declare-const var2627 Int) ; Statement: c0 := @parameter1: char 
(assert (not (= var2627 null-Int)))
(define-const var712 Bool (var3714_isEmpty/-813097145 var354)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList0(java.lang.String,char)>(r0, c0) 
(assert (not (= (ite var712 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var285 (Array Int String) var3714-EMPTY_STRING_ARRAY) ; Statement: $r5 = <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] EMPTY_STRING_ARRAY> 
 ; Statement: return $r5 
(check-sat)
; {var3714_isEmpty/-813097145=([java.lang.String], boolean)}
; {var354=r0, var1284=null_type, var2627=c0, var3714=org.apache.dubbo.common.utils.StringUtils, var712=$z0, var285=$r5}
; {r0=var354, null_type=var1284, c0=var2627, org.apache.dubbo.common.utils.StringUtils=var3714, $z0=var712, $r5=var285}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	c0 := @parameter1: char;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList0(java.lang.String,char)>(r0, c0);	$r5 = <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] EMPTY_STRING_ARRAY>;	return $r5
;block_num 2