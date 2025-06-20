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

(declare-sort var14 0)
(declare-sort var1410 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun parentPrefix/50586633 (var14) String)
(declare-const null-var14 var14)
(declare-const null-String String)
(declare-const var2662 var14) ; Statement: r0 := @this: org.apache.dubbo.config.MethodConfig 
(assert (not (= var2662 null-var14)))
(define-const var590 String (parentPrefix/50586633 var2662)) ; Statement: $r1 = r0.<org.apache.dubbo.config.MethodConfig: java.lang.String parentPrefix> 
 ; Statement: if $r1 == null goto return null 
(assert (= var590 null-String)) ; Cond: $r1 == null 
 ; Statement: return null 
(check-sat)
; {parentPrefix/50586633=([org.apache.dubbo.config.MethodConfig], java.lang.String)}
; {var14=org.apache.dubbo.config.MethodConfig, var2662=r0, var590=$r1, var1410=null_type}
; {org.apache.dubbo.config.MethodConfig=var14, r0=var2662, $r1=var590, null_type=var1410}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.config.MethodConfig;	$r1 = r0.<org.apache.dubbo.config.MethodConfig: java.lang.String parentPrefix>;	if $r1 == null goto return null;	return null
;block_num 2