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

(declare-sort var2801 0)
(declare-sort var141 0)
(declare-sort var1900 0)
(declare-sort var0 0)
(declare-sort var138 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var0_getSide/1522078474 (var1900) String)
(declare-fun invoke/1333346987 (var2801 var141 var1900 Bool) var138)
(declare-const null-var2801 var2801)
(declare-const null-var141 var141)
(declare-const null-var1900 var1900)
(declare-const var3003 var2801) ; Statement: r0 := @this: org.apache.dubbo.metrics.filter.MetricsFilter 
(assert (not (= var3003 null-var2801)))
(declare-const var3539 var141) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var3539 null-var141)))
(declare-const var2280 var1900) ; Statement: r2 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2280 null-var1900)))
(define-const var40 String "provider") ; Statement: $r4 = "provider" 
(define-const var3295 String (var0_getSide/1522078474 var2280)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.metrics.model.MetricsSupport: java.lang.String getSide(org.apache.dubbo.rpc.Invocation)>(r2) 
(assert true)
(define-const var3032 Bool (= var40 var3295)) ; Statement: $z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>($r3) 
(assert true)
(define-const var415 var138 (invoke/1333346987 var3003 var3539 var2280 var3032)) ; Statement: $r5 = virtualinvoke r0.<org.apache.dubbo.metrics.filter.MetricsFilter: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invoker,org.apache.dubbo.rpc.Invocation,boolean)>(r1, r2, $z0) 
 ; Statement: return $r5 
(check-sat)
; {var0_getSide/1522078474=([org.apache.dubbo.rpc.Invocation], java.lang.String), invoke/1333346987=([org.apache.dubbo.metrics.filter.MetricsFilter, org.apache.dubbo.rpc.Invoker, org.apache.dubbo.rpc.Invocation, boolean], org.apache.dubbo.rpc.Result)}
; {var2801=org.apache.dubbo.metrics.filter.MetricsFilter, var3003=r0, var141=org.apache.dubbo.rpc.Invoker, var3539=r1, var1900=org.apache.dubbo.rpc.Invocation, var2280=r2, var40=$r4, var0=org.apache.dubbo.metrics.model.MetricsSupport, var3295=$r3, var3032=$z0, var138=org.apache.dubbo.rpc.Result, var415=$r5}
; {org.apache.dubbo.metrics.filter.MetricsFilter=var2801, r0=var3003, org.apache.dubbo.rpc.Invoker=var141, r1=var3539, org.apache.dubbo.rpc.Invocation=var1900, r2=var2280, $r4=var40, org.apache.dubbo.metrics.model.MetricsSupport=var0, $r3=var3295, $z0=var3032, org.apache.dubbo.rpc.Result=var138, $r5=var415}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.metrics.filter.MetricsFilter;	r1 := @parameter0: org.apache.dubbo.rpc.Invoker;	r2 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r4 = "provider";	$r3 = staticinvoke <org.apache.dubbo.metrics.model.MetricsSupport: java.lang.String getSide(org.apache.dubbo.rpc.Invocation)>(r2);	$z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>($r3);	$r5 = virtualinvoke r0.<org.apache.dubbo.metrics.filter.MetricsFilter: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invoker,org.apache.dubbo.rpc.Invocation,boolean)>(r1, r2, $z0);	return $r5
;block_num 1