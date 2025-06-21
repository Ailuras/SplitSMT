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

(declare-sort var1308 0)
(declare-sort var1699 0)
(declare-sort var821 0)
(declare-sort var3510 0)
(declare-sort var85 0)
(declare-sort var1580 0)
(declare-sort var2860 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun tpsLimiter/-1366693661 (var1308) var3510)
(declare-fun var1580_getUrl/-275947851 (var1580) var85)
(declare-fun cast-from-var1699-to-var1580 (var1699) var1580)
(declare-fun var3510_isAllowable/-1031056798 (var3510 var85 var821) Bool)
(declare-fun var1699_invoke/-1860754555 (var1699 var821) var2860)
(declare-const null-var1308 var1308)
(declare-const null-var1699 var1699)
(declare-const null-var821 var821)
(declare-const var1886 var1308) ; Statement: r0 := @this: org.apache.dubbo.rpc.filter.TpsLimitFilter 
(assert (not (= var1886 null-var1308)))
(declare-const var1669 var1699) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var1669 null-var1699)))
(declare-const var2113 var821) ; Statement: r3 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2113 null-var821)))
(define-const var1021 var3510 (tpsLimiter/-1366693661 var1886)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.filter.TpsLimitFilter: org.apache.dubbo.rpc.filter.tps.TPSLimiter tpsLimiter> 
(define-const var3385 var85 (var1580_getUrl/-275947851 (cast-from-var1699-to-var1580 var1669))) ; Statement: $r4 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(define-const var2382 Bool (var3510_isAllowable/-1031056798 var1021 var3385 var2113)) ; Statement: $z0 = interfaceinvoke $r2.<org.apache.dubbo.rpc.filter.tps.TPSLimiter: boolean isAllowable(org.apache.dubbo.common.URL,org.apache.dubbo.rpc.Invocation)>($r4, r3) 
 ; Statement: if $z0 != 0 goto $r5 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r3) 
(assert (not (= (ite var2382 1 0) 0))) ; Cond: $z0 != 0 
(define-const var841 var2860 (var1699_invoke/-1860754555 var1669 var2113)) ; Statement: $r5 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r3) 
 ; Statement: return $r5 
(check-sat)
; {tpsLimiter/-1366693661=([org.apache.dubbo.rpc.filter.TpsLimitFilter], org.apache.dubbo.rpc.filter.tps.TPSLimiter), var1580_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var1699-to-var1580=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), var3510_isAllowable/-1031056798=([org.apache.dubbo.rpc.filter.tps.TPSLimiter, org.apache.dubbo.common.URL, org.apache.dubbo.rpc.Invocation], boolean), var1699_invoke/-1860754555=([org.apache.dubbo.rpc.Invoker, org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.Result)}
; {var1308=org.apache.dubbo.rpc.filter.TpsLimitFilter, var1886=r0, var1699=org.apache.dubbo.rpc.Invoker, var1669=r1, var821=org.apache.dubbo.rpc.Invocation, var2113=r3, var3510=org.apache.dubbo.rpc.filter.tps.TPSLimiter, var1021=$r2, var85=org.apache.dubbo.common.URL, var1580=org.apache.dubbo.common.Node, var3385=$r4, var2382=$z0, var2860=org.apache.dubbo.rpc.Result, var841=$r5}
; {org.apache.dubbo.rpc.filter.TpsLimitFilter=var1308, r0=var1886, org.apache.dubbo.rpc.Invoker=var1699, r1=var1669, org.apache.dubbo.rpc.Invocation=var821, r3=var2113, org.apache.dubbo.rpc.filter.tps.TPSLimiter=var3510, $r2=var1021, org.apache.dubbo.common.URL=var85, org.apache.dubbo.common.Node=var1580, $r4=var3385, $z0=var2382, org.apache.dubbo.rpc.Result=var2860, $r5=var841}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.rpc.filter.TpsLimitFilter;	r1 := @parameter0: org.apache.dubbo.rpc.Invoker;	r3 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r2 = r0.<org.apache.dubbo.rpc.filter.TpsLimitFilter: org.apache.dubbo.rpc.filter.tps.TPSLimiter tpsLimiter>;	$r4 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$z0 = interfaceinvoke $r2.<org.apache.dubbo.rpc.filter.tps.TPSLimiter: boolean isAllowable(org.apache.dubbo.common.URL,org.apache.dubbo.rpc.Invocation)>($r4, r3);	if $z0 != 0 goto $r5 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r3);	$r5 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r3);	return $r5
;block_num 2