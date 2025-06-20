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

(declare-sort var3438 0)
(declare-sort var2572 0)
(declare-sort var3143 0)
(declare-sort var893 0)
(declare-sort var2343 0)
(declare-sort var1695 0)
(declare-sort var488 0)
(declare-sort var2747 0)
(declare-sort var800 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var893_getAttachment/-2134772037 (var893 String) String)
(declare-fun var2343_isEmpty/-813097145 (String) Bool)
(declare-fun getParameter/-1307325648 (var3143 String) String)
(declare-fun var488_bootstrap$/-23376506 (String) var1695)
(declare-fun filterInvoker/2017639208 (var3438 var2572 var1695) var2572)
(declare-fun var2747_isEmpty/73262611 (var800) Bool)
(declare-fun cast-from-var2572-to-var800 (var2572) var800)
(declare-const null-var3438 var3438)
(declare-const null-var2572 var2572)
(declare-const null-var3143 var3143)
(declare-const null-var893 var893)
(declare-const var283 var3438) ; Statement: r2 := @this: org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter 
(assert (not (= var283 null-var3438)))
(declare-const var592 var2572) ; Statement: r3 := @parameter0: org.apache.dubbo.rpc.cluster.router.state.BitList 
(assert (not (= var592 null-var2572)))
(declare-const var2481 var3143) ; Statement: r7 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var2481 null-var3143)))
(declare-const var1752 var893) ; Statement: r0 := @parameter2: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1752 null-var893)))
(define-const var2630 String (var893_getAttachment/-2134772037 var1752 "dubbo.tag")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("dubbo.tag") 
(define-const var2426 Bool (var2343_isEmpty/-813097145 var2630)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r8 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("dubbo.tag") 
(assert (not (= (ite var2426 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var1912 String (getParameter/-1307325648 var2481 "dubbo.tag")) ; Statement: $r8 = virtualinvoke r7.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("dubbo.tag") 
 ; Statement: goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r8)] 
(assert true) ; Non Conditional
(define-const var3366 Bool (var2343_isEmpty/-813097145 var1912)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r8) 
 ; Statement: if $z1 != 0 goto $r4 = staticinvoke <org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_8__96: java.util.function.Predicate bootstrap$()>() 
(assert (not (not (= (ite var3366 1 0) 0)))) ; Negate: Cond: $z1 != 0  
(define-const var3268 var1695 (var488_bootstrap$/-23376506 var1912)) ; Statement: $r5 = staticinvoke <org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_6__110: java.util.function.Predicate bootstrap$(java.lang.String)>($r8) 
(assert true)
(define-const var877 var2572 (filterInvoker/2017639208 var283 var592 var3268)) ; Statement: r9 = specialinvoke r2.<org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter: org.apache.dubbo.rpc.cluster.router.state.BitList filterInvoker(org.apache.dubbo.rpc.cluster.router.state.BitList,java.util.function.Predicate)>(r3, $r5) 
(define-const var2653 Bool (var2747_isEmpty/73262611 (cast-from-var2572-to-var800 var877))) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>(r9) 
 ; Statement: if $z2 == 0 goto return r9 
(assert (= (ite var2653 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: return r9 
(check-sat)
; {var893_getAttachment/-2134772037=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.String), var2343_isEmpty/-813097145=([java.lang.String], boolean), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var488_bootstrap$/-23376506=([java.lang.String], java.util.function.Predicate), filterInvoker/2017639208=([org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter, org.apache.dubbo.rpc.cluster.router.state.BitList, java.util.function.Predicate], org.apache.dubbo.rpc.cluster.router.state.BitList), var2747_isEmpty/73262611=([java.util.Collection], boolean), cast-from-var2572-to-var800=([org.apache.dubbo.rpc.cluster.router.state.BitList], java.util.Collection)}
; {var3438=org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter, var283=r2, var2572=org.apache.dubbo.rpc.cluster.router.state.BitList, var592=r3, var3143=org.apache.dubbo.common.URL, var2481=r7, var893=org.apache.dubbo.rpc.Invocation, var1752=r0, var2630=$r1, var2343=org.apache.dubbo.common.utils.StringUtils, var2426=$z0, var1912=$r8, var3366=$z1, var1695=java.util.function.Predicate, var488=org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_6__110, var3268=$r5, var877=r9, var2747=org.apache.dubbo.common.utils.CollectionUtils, var800=java.util.Collection, var2653=$z2}
; {org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter=var3438, r2=var283, org.apache.dubbo.rpc.cluster.router.state.BitList=var2572, r3=var592, org.apache.dubbo.common.URL=var3143, r7=var2481, org.apache.dubbo.rpc.Invocation=var893, r0=var1752, $r1=var2630, org.apache.dubbo.common.utils.StringUtils=var2343, $z0=var2426, $r8=var1912, $z1=var3366, java.util.function.Predicate=var1695, org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_6__110=var488, $r5=var3268, r9=var877, org.apache.dubbo.common.utils.CollectionUtils=var2747, java.util.Collection=var800, $z2=var2653}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2}
;stmts r2 := @this: org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter;	r3 := @parameter0: org.apache.dubbo.rpc.cluster.router.state.BitList;	r7 := @parameter1: org.apache.dubbo.common.URL;	r0 := @parameter2: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("dubbo.tag");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r8 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("dubbo.tag");	$r8 = virtualinvoke r7.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("dubbo.tag");	goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r8)];	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r8);	if $z1 != 0 goto $r4 = staticinvoke <org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_8__96: java.util.function.Predicate bootstrap$()>();	$r5 = staticinvoke <org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_6__110: java.util.function.Predicate bootstrap$(java.lang.String)>($r8);	r9 = specialinvoke r2.<org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter: org.apache.dubbo.rpc.cluster.router.state.BitList filterInvoker(org.apache.dubbo.rpc.cluster.router.state.BitList,java.util.function.Predicate)>(r3, $r5);	$z2 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>(r9);	if $z2 == 0 goto return r9;	return r9
;block_num 5