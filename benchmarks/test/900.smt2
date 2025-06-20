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

(declare-sort var3420 0)
(declare-sort var1763 0)
(declare-sort var1083 0)
(declare-sort var3802 0)
(declare-sort var1020 0)
(declare-sort var1332 0)
(declare-sort var1795 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3802_getAttachment/-2134772037 (var3802 String) String)
(declare-fun var1020_isEmpty/-813097145 (String) Bool)
(declare-fun var1795_bootstrap$/-649368054 () var1332)
(declare-fun filterInvoker/2017639208 (var3420 var1763 var1332) var1763)
(declare-const null-var3420 var3420)
(declare-const null-var1763 var1763)
(declare-const null-var1083 var1083)
(declare-const null-var3802 var3802)
(declare-const var1073 var3420) ; Statement: r2 := @this: org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter 
(assert (not (= var1073 null-var3420)))
(declare-const var1981 var1763) ; Statement: r3 := @parameter0: org.apache.dubbo.rpc.cluster.router.state.BitList 
(assert (not (= var1981 null-var1763)))
(declare-const var541 var1083) ; Statement: r7 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var541 null-var1083)))
(declare-const var2688 var3802) ; Statement: r0 := @parameter2: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2688 null-var3802)))
(define-const var3221 String (var3802_getAttachment/-2134772037 var2688 "dubbo.tag")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("dubbo.tag") 
(define-const var2434 Bool (var1020_isEmpty/-813097145 var3221)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r8 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("dubbo.tag") 
(assert (= (ite var2434 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2587 String (var3802_getAttachment/-2134772037 var2688 "dubbo.tag")) ; Statement: $r8 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("dubbo.tag") 
(assert true) ; Non Conditional
(define-const var3161 Bool (var1020_isEmpty/-813097145 var2587)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r8) 
 ; Statement: if $z1 != 0 goto $r4 = staticinvoke <org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_8__96: java.util.function.Predicate bootstrap$()>() 
(assert (not (= (ite var3161 1 0) 0))) ; Cond: $z1 != 0 
(define-const var3765 var1332 var1795_bootstrap$/-649368054) ; Statement: $r4 = staticinvoke <org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_8__96: java.util.function.Predicate bootstrap$()>() 
(assert true)
(define-const var3355 var1763 (filterInvoker/2017639208 var1073 var1981 var3765)) ; Statement: r9 = specialinvoke r2.<org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter: org.apache.dubbo.rpc.cluster.router.state.BitList filterInvoker(org.apache.dubbo.rpc.cluster.router.state.BitList,java.util.function.Predicate)>(r3, $r4) 
(assert true) ; Non Conditional
 ; Statement: return r9 
(check-sat)
; {var3802_getAttachment/-2134772037=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.String), var1020_isEmpty/-813097145=([java.lang.String], boolean), var1795_bootstrap$/-649368054=([], java.util.function.Predicate), filterInvoker/2017639208=([org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter, org.apache.dubbo.rpc.cluster.router.state.BitList, java.util.function.Predicate], org.apache.dubbo.rpc.cluster.router.state.BitList)}
; {var3420=org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter, var1073=r2, var1763=org.apache.dubbo.rpc.cluster.router.state.BitList, var1981=r3, var1083=org.apache.dubbo.common.URL, var541=r7, var3802=org.apache.dubbo.rpc.Invocation, var2688=r0, var3221=$r1, var1020=org.apache.dubbo.common.utils.StringUtils, var2434=$z0, var2587=$r8, var3161=$z1, var1332=java.util.function.Predicate, var1795=org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_8__96, var3765=$r4, var3355=r9}
; {org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter=var3420, r2=var1073, org.apache.dubbo.rpc.cluster.router.state.BitList=var1763, r3=var1981, org.apache.dubbo.common.URL=var1083, r7=var541, org.apache.dubbo.rpc.Invocation=var3802, r0=var2688, $r1=var3221, org.apache.dubbo.common.utils.StringUtils=var1020, $z0=var2434, $r8=var2587, $z1=var3161, java.util.function.Predicate=var1332, org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_8__96=var1795, $r4=var3765, r9=var3355}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2}
;stmts r2 := @this: org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter;	r3 := @parameter0: org.apache.dubbo.rpc.cluster.router.state.BitList;	r7 := @parameter1: org.apache.dubbo.common.URL;	r0 := @parameter2: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("dubbo.tag");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r8 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("dubbo.tag");	$r8 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("dubbo.tag");	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r8);	if $z1 != 0 goto $r4 = staticinvoke <org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_8__96: java.util.function.Predicate bootstrap$()>();	$r4 = staticinvoke <org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_8__96: java.util.function.Predicate bootstrap$()>();	r9 = specialinvoke r2.<org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter: org.apache.dubbo.rpc.cluster.router.state.BitList filterInvoker(org.apache.dubbo.rpc.cluster.router.state.BitList,java.util.function.Predicate)>(r3, $r4);	return r9
;block_num 5