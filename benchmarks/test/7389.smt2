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

(declare-sort var3034 0)
(declare-sort var148 0)
(declare-sort var1394 0)
(declare-sort var1075 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var148_isEmpty/-813097145 (String) Bool)
(declare-fun var1075_emptyList/582664469 () var1394)
(declare-const null-String String)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var2511 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2511 null-String)))
(declare-const var85 (Array Int Int)) ; Statement: r5 := @parameter1: char[] 
(assert (not (= var85 null-__Array__Int__Int__)))
(define-const var1406 Bool (var148_isEmpty/-813097145 var2511)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (not (= (ite var1406 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3706 var1394 var1075_emptyList/582664469) ; Statement: $r4 = staticinvoke <java.util.Collections: java.util.List emptyList()>() 
 ; Statement: return $r4 
(check-sat)
; {var148_isEmpty/-813097145=([java.lang.String], boolean), var1075_emptyList/582664469=([], java.util.List)}
; {var2511=r0, var3034=null_type, var85=r5, var148=org.apache.dubbo.common.utils.StringUtils, var1406=$z0, var1394=java.util.List, var1075=java.util.Collections, var3706=$r4}
; {r0=var2511, null_type=var3034, r5=var85, org.apache.dubbo.common.utils.StringUtils=var148, $z0=var1406, java.util.List=var1394, java.util.Collections=var1075, $r4=var3706}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r5 := @parameter1: char[];	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto (branch);	$r4 = staticinvoke <java.util.Collections: java.util.List emptyList()>();	return $r4
;block_num 2