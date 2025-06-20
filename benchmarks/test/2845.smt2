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

(declare-sort var635 0)
(declare-sort var1094 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun destroyed/-1855590362 (var635) var1094)
(declare-fun get/2135855162 (var1094) Bool)
(declare-const null-var635 var635)
(declare-const var1292 var635) ; Statement: r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var1292 null-var635)))
(define-const var3505 var1094 (destroyed/-1855590362 var1292)) ; Statement: $r1 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.concurrent.atomic.AtomicBoolean destroyed> 
(assert true)
(define-const var856 Bool (get/2135855162 var3505)) ; Statement: $z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicBoolean: boolean get()>() 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var856 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {destroyed/-1855590362=([org.apache.dubbo.common.extension.ExtensionLoader], java.util.concurrent.atomic.AtomicBoolean), get/2135855162=([java.util.concurrent.atomic.AtomicBoolean], boolean)}
; {var635=org.apache.dubbo.common.extension.ExtensionLoader, var1292=r0, var1094=java.util.concurrent.atomic.AtomicBoolean, var3505=$r1, var856=$z0}
; {org.apache.dubbo.common.extension.ExtensionLoader=var635, r0=var1292, java.util.concurrent.atomic.AtomicBoolean=var1094, $r1=var3505, $z0=var856}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	$r1 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.concurrent.atomic.AtomicBoolean destroyed>;	$z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicBoolean: boolean get()>();	if $z0 == 0 goto return;	return
;block_num 2