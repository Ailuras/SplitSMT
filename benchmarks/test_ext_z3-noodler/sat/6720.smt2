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

(declare-sort var2852 0)
(declare-sort var613 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var613_delimitedListToStringArray/-204322269 (String String String) (Array Int String))
(declare-const null-String String)
(declare-const var1534 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1534 null-String)))
(declare-const var884 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var884 null-String)))
(define-const var2861 (Array Int String) (var613_delimitedListToStringArray/-204322269 var1534 var884 null-String)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] delimitedListToStringArray(java.lang.String,java.lang.String,java.lang.String)>(r0, r1, null) 
 ; Statement: return $r2 
(check-sat)
; {var613_delimitedListToStringArray/-204322269=([java.lang.String, java.lang.String, java.lang.String], java.lang.String[])}
; {var1534=r0, var2852=null_type, var884=r1, var613=org.apache.dubbo.common.utils.StringUtils, var2861=$r2}
; {r0=var1534, null_type=var2852, r1=var884, org.apache.dubbo.common.utils.StringUtils=var613, $r2=var2861}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] delimitedListToStringArray(java.lang.String,java.lang.String,java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String[] delimitedListToStringArray(java.lang.String,java.lang.String,java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] delimitedListToStringArray(java.lang.String,java.lang.String,java.lang.String)>(r0, r1, null);	return $r2
;block_num 1