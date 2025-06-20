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

(declare-sort var1348 0)
(declare-sort var3084 0)
(declare-sort var3113 0)
(declare-sort var276 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3084_isEmpty/-813097145 (String) Bool)
(declare-fun var276_emptyMap/401053835 () var3113)
(declare-const null-String String)
(declare-const var2491 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2491 null-String)))
(define-const var2471 Bool (var3084_isEmpty/-813097145 var2491)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r13 = new java.util.LinkedHashMap 
(assert (not (= (ite var2471 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1487 var3113 var276_emptyMap/401053835) ; Statement: $r12 = staticinvoke <java.util.Collections: java.util.Map emptyMap()>() 
 ; Statement: return $r12 
(check-sat)
; {var3084_isEmpty/-813097145=([java.lang.String], boolean), var276_emptyMap/401053835=([], java.util.Map)}
; {var2491=r0, var1348=null_type, var3084=org.apache.dubbo.common.utils.StringUtils, var2471=$z0, var3113=java.util.Map, var276=java.util.Collections, var1487=$r12}
; {r0=var2491, null_type=var1348, org.apache.dubbo.common.utils.StringUtils=var3084, $z0=var2471, java.util.Map=var3113, java.util.Collections=var276, $r12=var1487}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r13 = new java.util.LinkedHashMap;	$r12 = staticinvoke <java.util.Collections: java.util.Map emptyMap()>();	return $r12
;block_num 2