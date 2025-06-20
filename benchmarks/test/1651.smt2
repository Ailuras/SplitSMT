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

(declare-sort var24 0)
(declare-sort var314 0)
(declare-sort var355 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var355_length/1485543905 (String) Int)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var24 var24)
(declare-const null-String String)
(declare-const var458 var24) ; Statement: r3 := @this: org.apache.dubbo.common.convert.StringToCharacterConverter 
(assert (not (= var458 null-var24)))
(declare-const var3558 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3558 null-String)))
(define-const var2420 Int (var355_length/1485543905 (cast-from-String-to-String var3558))) ; Statement: i0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>(r0) 
 ; Statement: if i0 != 0 goto (branch) 
(assert (not (not (= var2420 0)))) ; Negate: Cond: i0 != 0  
 ; Statement: return null 
(check-sat)
; {var355_length/1485543905=([java.lang.CharSequence], int), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var24=org.apache.dubbo.common.convert.StringToCharacterConverter, var458=r3, var3558=r0, var314=null_type, var355=org.apache.dubbo.common.utils.StringUtils, var2420=i0}
; {org.apache.dubbo.common.convert.StringToCharacterConverter=var24, r3=var458, r0=var3558, null_type=var314, org.apache.dubbo.common.utils.StringUtils=var355, i0=var2420}
;seq <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>": 1}
;stmts r3 := @this: org.apache.dubbo.common.convert.StringToCharacterConverter;	r0 := @parameter0: java.lang.String;	i0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>(r0);	if i0 != 0 goto (branch);	return null
;block_num 2