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

(declare-sort var364 0)
(declare-sort var1128 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1128_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var1481 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1481 null-String)))
(define-const var1552 Bool (var1128_isEmpty/-813097145 var1481)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = staticinvoke <java.net.URLDecoder: java.lang.String decode(java.lang.String,java.lang.String)>(r0, "UTF-8") 
(assert (not (= (ite var1552 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return "" 
(check-sat)
; {var1128_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1481=r0, var364=null_type, var1128=org.apache.dubbo.common.utils.StringUtils, var1552=$z0}
; {r0=var1481, null_type=var364, org.apache.dubbo.common.utils.StringUtils=var1128, $z0=var1552}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = staticinvoke <java.net.URLDecoder: java.lang.String decode(java.lang.String,java.lang.String)>(r0, "UTF-8");	return ""
;block_num 2