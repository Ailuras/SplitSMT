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

(declare-sort var1095 0)
(declare-sort var287 0)
(declare-sort var699 0)
(declare-sort var502 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getSource/-295186747 (var287) var699)
(declare-fun appName/-1356821530 (var287) String)
(declare-fun var502_isEmpty/-813097145 (String) Bool)
(declare-const null-var1095 var1095)
(declare-const null-var287 var287)
(declare-const null-var699 var699)
(declare-const var1983 var1095) ; Statement: r3 := @this: org.apache.dubbo.metrics.event.SimpleMetricsEventMulticaster 
(assert (not (= var1983 null-var1095)))
(declare-const var1328 var287) ; Statement: r0 := @parameter0: org.apache.dubbo.metrics.event.MetricsEvent 
(assert (not (= var1328 null-var287)))
(assert true)
(define-const var2501 var699 (getSource/-295186747 var1328)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.metrics.event.MetricsEvent: org.apache.dubbo.rpc.model.ApplicationModel getSource()>() 
 ; Statement: if $r1 == null goto return 0 
(assert (not (= var2501 null-var699))) ; Negate: Cond: $r1 == null  
(assert true)
(define-const var2570 String (appName/-1356821530 var1328)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.metrics.event.MetricsEvent: java.lang.String appName()>() 
(define-const var2554 Bool (var502_isEmpty/-813097145 var2570)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {getSource/-295186747=([org.apache.dubbo.metrics.event.MetricsEvent], org.apache.dubbo.rpc.model.ApplicationModel), appName/-1356821530=([org.apache.dubbo.metrics.event.MetricsEvent], java.lang.String), var502_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1095=org.apache.dubbo.metrics.event.SimpleMetricsEventMulticaster, var1983=r3, var287=org.apache.dubbo.metrics.event.MetricsEvent, var1328=r0, var699=org.apache.dubbo.rpc.model.ApplicationModel, var2501=$r1, var2570=$r2, var502=org.apache.dubbo.common.utils.StringUtils, var2554=$z0}
; {org.apache.dubbo.metrics.event.SimpleMetricsEventMulticaster=var1095, r3=var1983, org.apache.dubbo.metrics.event.MetricsEvent=var287, r0=var1328, org.apache.dubbo.rpc.model.ApplicationModel=var699, $r1=var2501, $r2=var2570, org.apache.dubbo.common.utils.StringUtils=var502, $z0=var2554}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.metrics.event.SimpleMetricsEventMulticaster;	r0 := @parameter0: org.apache.dubbo.metrics.event.MetricsEvent;	$r1 = virtualinvoke r0.<org.apache.dubbo.metrics.event.MetricsEvent: org.apache.dubbo.rpc.model.ApplicationModel getSource()>();	if $r1 == null goto return 0;	$r2 = virtualinvoke r0.<org.apache.dubbo.metrics.event.MetricsEvent: java.lang.String appName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r2);	return $z0
;block_num 2