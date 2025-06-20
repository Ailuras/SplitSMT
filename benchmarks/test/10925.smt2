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

(declare-sort var3375 0)
(declare-sort var3663 0)
(declare-sort var2624 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getSource/-295186747 (var3663) var2624)
(declare-const null-var3375 var3375)
(declare-const null-var3663 var3663)
(declare-const null-var2624 var2624)
(declare-const var644 var3375) ; Statement: r3 := @this: org.apache.dubbo.metrics.event.SimpleMetricsEventMulticaster 
(assert (not (= var644 null-var3375)))
(declare-const var3523 var3663) ; Statement: r0 := @parameter0: org.apache.dubbo.metrics.event.MetricsEvent 
(assert (not (= var3523 null-var3663)))
(assert true)
(define-const var845 var2624 (getSource/-295186747 var3523)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.metrics.event.MetricsEvent: org.apache.dubbo.rpc.model.ApplicationModel getSource()>() 
 ; Statement: if $r1 == null goto return 0 
(assert (= var845 null-var2624)) ; Cond: $r1 == null 
 ; Statement: return 0 
(check-sat)
; {getSource/-295186747=([org.apache.dubbo.metrics.event.MetricsEvent], org.apache.dubbo.rpc.model.ApplicationModel)}
; {var3375=org.apache.dubbo.metrics.event.SimpleMetricsEventMulticaster, var644=r3, var3663=org.apache.dubbo.metrics.event.MetricsEvent, var3523=r0, var2624=org.apache.dubbo.rpc.model.ApplicationModel, var845=$r1}
; {org.apache.dubbo.metrics.event.SimpleMetricsEventMulticaster=var3375, r3=var644, org.apache.dubbo.metrics.event.MetricsEvent=var3663, r0=var3523, org.apache.dubbo.rpc.model.ApplicationModel=var2624, $r1=var845}
;seq 
;cnt {}
;stmts r3 := @this: org.apache.dubbo.metrics.event.SimpleMetricsEventMulticaster;	r0 := @parameter0: org.apache.dubbo.metrics.event.MetricsEvent;	$r1 = virtualinvoke r0.<org.apache.dubbo.metrics.event.MetricsEvent: org.apache.dubbo.rpc.model.ApplicationModel getSource()>();	if $r1 == null goto return 0;	return 0
;block_num 2