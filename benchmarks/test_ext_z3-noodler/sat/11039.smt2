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

(declare-sort var504 0)
(declare-sort var3402 0)
(declare-sort var1012 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMetricsKeyWrapper/-252825486 (var504) var1012)
(declare-fun getType/1339125236 (var1012) String)
(declare-const null-var504 var504)
(declare-const null-String String)
(declare-const var973 var504) ; Statement: r1 := @this: org.apache.dubbo.metrics.model.container.LongContainer 
(assert (not (= var973 null-var504)))
(declare-const var367 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var367 null-String)))
(assert true)
(define-const var2952 var1012 (getMetricsKeyWrapper/-252825486 var973)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.metrics.model.container.LongContainer: org.apache.dubbo.metrics.model.key.MetricsKeyWrapper getMetricsKeyWrapper()>() 
(assert true)
(define-const var3464 String (getType/1339125236 var2952)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.metrics.model.key.MetricsKeyWrapper: java.lang.String getType()>() 
(assert true)
(define-const var2313 Bool (= var367 var3464)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r3) 
 ; Statement: return $z0 
(check-sat)
; {getMetricsKeyWrapper/-252825486=([org.apache.dubbo.metrics.model.container.LongContainer], org.apache.dubbo.metrics.model.key.MetricsKeyWrapper), getType/1339125236=([org.apache.dubbo.metrics.model.key.MetricsKeyWrapper], java.lang.String)}
; {var504=org.apache.dubbo.metrics.model.container.LongContainer, var973=r1, var367=r0, var3402=null_type, var1012=org.apache.dubbo.metrics.model.key.MetricsKeyWrapper, var2952=$r2, var3464=$r3, var2313=$z0}
; {org.apache.dubbo.metrics.model.container.LongContainer=var504, r1=var973, r0=var367, null_type=var3402, org.apache.dubbo.metrics.model.key.MetricsKeyWrapper=var1012, $r2=var2952, $r3=var3464, $z0=var2313}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r1 := @this: org.apache.dubbo.metrics.model.container.LongContainer;	r0 := @parameter0: java.lang.String;	$r2 = virtualinvoke r1.<org.apache.dubbo.metrics.model.container.LongContainer: org.apache.dubbo.metrics.model.key.MetricsKeyWrapper getMetricsKeyWrapper()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.metrics.model.key.MetricsKeyWrapper: java.lang.String getType()>();	$z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r3);	return $z0
;block_num 1