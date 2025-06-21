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

(declare-sort var1812 0)
(declare-sort var1921 0)
(declare-sort var1422 0)
(declare-sort var2101 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1921_isEmpty/-813097145 (String) Bool)
(declare-fun var2101_emptyList/582664469 () var1422)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2103 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2103 null-String)))
(declare-const var2350 Int) ; Statement: c0 := @parameter1: char 
(assert (not (= var2350 null-Int)))
(define-const var1806 Bool (var1921_isEmpty/-813097145 var2103)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList0(java.lang.String,char)>(r0, c0) 
(assert (not (= (ite var1806 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2329 var1422 var2101_emptyList/582664469) ; Statement: $r2 = staticinvoke <java.util.Collections: java.util.List emptyList()>() 
 ; Statement: return $r2 
(check-sat)
; {var1921_isEmpty/-813097145=([java.lang.String], boolean), var2101_emptyList/582664469=([], java.util.List)}
; {var2103=r0, var1812=null_type, var2350=c0, var1921=org.apache.dubbo.common.utils.StringUtils, var1806=$z0, var1422=java.util.List, var2101=java.util.Collections, var2329=$r2}
; {r0=var2103, null_type=var1812, c0=var2350, org.apache.dubbo.common.utils.StringUtils=var1921, $z0=var1806, java.util.List=var1422, java.util.Collections=var2101, $r2=var2329}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	c0 := @parameter1: char;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList0(java.lang.String,char)>(r0, c0);	$r2 = staticinvoke <java.util.Collections: java.util.List emptyList()>();	return $r2
;block_num 2