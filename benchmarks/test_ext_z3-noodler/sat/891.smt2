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

(declare-sort var617 0)
(declare-sort var2285 0)
(declare-sort var313 0)
(declare-sort var1375 0)
(declare-sort var278 0)
(declare-sort var2719 0)
(declare-sort var882 0)
(declare-sort var223 0)
(declare-sort var100 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1375_getAttachment/-2134772037 (var1375 String) String)
(declare-fun var278_isEmpty/-813097145 (String) Bool)
(declare-fun var882_bootstrap$/-23376506 (String) var2719)
(declare-fun filterInvoker/2017639208 (var617 var2285 var2719) var2285)
(declare-fun var223_isEmpty/73262611 (var100) Bool)
(declare-fun cast-from-var2285-to-var100 (var2285) var100)
(declare-const null-var617 var617)
(declare-const null-var2285 var2285)
(declare-const null-var313 var313)
(declare-const null-var1375 var1375)
(declare-const var238 var617) ; Statement: r2 := @this: org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter 
(assert (not (= var238 null-var617)))
(declare-const var1381 var2285) ; Statement: r3 := @parameter0: org.apache.dubbo.rpc.cluster.router.state.BitList 
(assert (not (= var1381 null-var2285)))
(declare-const var2848 var313) ; Statement: r7 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var2848 null-var313)))
(declare-const var848 var1375) ; Statement: r0 := @parameter2: org.apache.dubbo.rpc.Invocation 
(assert (not (= var848 null-var1375)))
(define-const var3002 String (var1375_getAttachment/-2134772037 var848 "dubbo.tag")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("dubbo.tag") 
(define-const var2061 Bool (var278_isEmpty/-813097145 var3002)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r8 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("dubbo.tag") 
(assert (= (ite var2061 1 0) 0)) ; Cond: $z0 == 0 
(define-const var18 String (var1375_getAttachment/-2134772037 var848 "dubbo.tag")) ; Statement: $r8 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("dubbo.tag") 
(assert true) ; Non Conditional
(define-const var184 Bool (var278_isEmpty/-813097145 var18)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r8) 
 ; Statement: if $z1 != 0 goto $r4 = staticinvoke <org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_8__96: java.util.function.Predicate bootstrap$()>() 
(assert (not (not (= (ite var184 1 0) 0)))) ; Negate: Cond: $z1 != 0  
(define-const var2491 var2719 (var882_bootstrap$/-23376506 var18)) ; Statement: $r5 = staticinvoke <org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_6__110: java.util.function.Predicate bootstrap$(java.lang.String)>($r8) 
(assert true)
(define-const var340 var2285 (filterInvoker/2017639208 var238 var1381 var2491)) ; Statement: r9 = specialinvoke r2.<org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter: org.apache.dubbo.rpc.cluster.router.state.BitList filterInvoker(org.apache.dubbo.rpc.cluster.router.state.BitList,java.util.function.Predicate)>(r3, $r5) 
(define-const var2250 Bool (var223_isEmpty/73262611 (cast-from-var2285-to-var100 var340))) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>(r9) 
 ; Statement: if $z2 == 0 goto return r9 
(assert (= (ite var2250 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: return r9 
(check-sat)
; {var1375_getAttachment/-2134772037=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.String), var278_isEmpty/-813097145=([java.lang.String], boolean), var882_bootstrap$/-23376506=([java.lang.String], java.util.function.Predicate), filterInvoker/2017639208=([org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter, org.apache.dubbo.rpc.cluster.router.state.BitList, java.util.function.Predicate], org.apache.dubbo.rpc.cluster.router.state.BitList), var223_isEmpty/73262611=([java.util.Collection], boolean), cast-from-var2285-to-var100=([org.apache.dubbo.rpc.cluster.router.state.BitList], java.util.Collection)}
; {var617=org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter, var238=r2, var2285=org.apache.dubbo.rpc.cluster.router.state.BitList, var1381=r3, var313=org.apache.dubbo.common.URL, var2848=r7, var1375=org.apache.dubbo.rpc.Invocation, var848=r0, var3002=$r1, var278=org.apache.dubbo.common.utils.StringUtils, var2061=$z0, var18=$r8, var184=$z1, var2719=java.util.function.Predicate, var882=org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_6__110, var2491=$r5, var340=r9, var223=org.apache.dubbo.common.utils.CollectionUtils, var100=java.util.Collection, var2250=$z2}
; {org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter=var617, r2=var238, org.apache.dubbo.rpc.cluster.router.state.BitList=var2285, r3=var1381, org.apache.dubbo.common.URL=var313, r7=var2848, org.apache.dubbo.rpc.Invocation=var1375, r0=var848, $r1=var3002, org.apache.dubbo.common.utils.StringUtils=var278, $z0=var2061, $r8=var18, $z1=var184, java.util.function.Predicate=var2719, org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_6__110=var882, $r5=var2491, r9=var340, org.apache.dubbo.common.utils.CollectionUtils=var223, java.util.Collection=var100, $z2=var2250}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2}
;stmts r2 := @this: org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter;	r3 := @parameter0: org.apache.dubbo.rpc.cluster.router.state.BitList;	r7 := @parameter1: org.apache.dubbo.common.URL;	r0 := @parameter2: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("dubbo.tag");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r8 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("dubbo.tag");	$r8 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("dubbo.tag");	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r8);	if $z1 != 0 goto $r4 = staticinvoke <org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_8__96: java.util.function.Predicate bootstrap$()>();	$r5 = staticinvoke <org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_6__110: java.util.function.Predicate bootstrap$(java.lang.String)>($r8);	r9 = specialinvoke r2.<org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter: org.apache.dubbo.rpc.cluster.router.state.BitList filterInvoker(org.apache.dubbo.rpc.cluster.router.state.BitList,java.util.function.Predicate)>(r3, $r5);	$z2 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>(r9);	if $z2 == 0 goto return r9;	return r9
;block_num 5