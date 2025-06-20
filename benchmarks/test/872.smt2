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

(declare-sort var3198 0)
(declare-sort var3124 0)
(declare-sort var1309 0)
(declare-sort var1419 0)
(declare-sort var1729 0)
(declare-sort var1625 0)
(declare-sort var107 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1419_getAttachment/-2134772037 (var1419 String) String)
(declare-fun var1729_isEmpty/-813097145 (String) Bool)
(declare-fun getParameter/-1307325648 (var1309 String) String)
(declare-fun var107_bootstrap$/-649368054 () var1625)
(declare-fun filterInvoker/2017639208 (var3198 var3124 var1625) var3124)
(declare-const null-var3198 var3198)
(declare-const null-var3124 var3124)
(declare-const null-var1309 var1309)
(declare-const null-var1419 var1419)
(declare-const var1 var3198) ; Statement: r2 := @this: org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter 
(assert (not (= var1 null-var3198)))
(declare-const var3993 var3124) ; Statement: r3 := @parameter0: org.apache.dubbo.rpc.cluster.router.state.BitList 
(assert (not (= var3993 null-var3124)))
(declare-const var3867 var1309) ; Statement: r7 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var3867 null-var1309)))
(declare-const var194 var1419) ; Statement: r0 := @parameter2: org.apache.dubbo.rpc.Invocation 
(assert (not (= var194 null-var1419)))
(define-const var3465 String (var1419_getAttachment/-2134772037 var194 "dubbo.tag")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("dubbo.tag") 
(define-const var2320 Bool (var1729_isEmpty/-813097145 var3465)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r8 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("dubbo.tag") 
(assert (not (= (ite var2320 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var2398 String (getParameter/-1307325648 var3867 "dubbo.tag")) ; Statement: $r8 = virtualinvoke r7.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("dubbo.tag") 
 ; Statement: goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r8)] 
(assert true) ; Non Conditional
(define-const var3996 Bool (var1729_isEmpty/-813097145 var2398)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r8) 
 ; Statement: if $z1 != 0 goto $r4 = staticinvoke <org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_8__96: java.util.function.Predicate bootstrap$()>() 
(assert (not (= (ite var3996 1 0) 0))) ; Cond: $z1 != 0 
(define-const var1919 var1625 var107_bootstrap$/-649368054) ; Statement: $r4 = staticinvoke <org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_8__96: java.util.function.Predicate bootstrap$()>() 
(assert true)
(define-const var2256 var3124 (filterInvoker/2017639208 var1 var3993 var1919)) ; Statement: r9 = specialinvoke r2.<org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter: org.apache.dubbo.rpc.cluster.router.state.BitList filterInvoker(org.apache.dubbo.rpc.cluster.router.state.BitList,java.util.function.Predicate)>(r3, $r4) 
(assert true) ; Non Conditional
 ; Statement: return r9 
(check-sat)
; {var1419_getAttachment/-2134772037=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.String), var1729_isEmpty/-813097145=([java.lang.String], boolean), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var107_bootstrap$/-649368054=([], java.util.function.Predicate), filterInvoker/2017639208=([org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter, org.apache.dubbo.rpc.cluster.router.state.BitList, java.util.function.Predicate], org.apache.dubbo.rpc.cluster.router.state.BitList)}
; {var3198=org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter, var1=r2, var3124=org.apache.dubbo.rpc.cluster.router.state.BitList, var3993=r3, var1309=org.apache.dubbo.common.URL, var3867=r7, var1419=org.apache.dubbo.rpc.Invocation, var194=r0, var3465=$r1, var1729=org.apache.dubbo.common.utils.StringUtils, var2320=$z0, var2398=$r8, var3996=$z1, var1625=java.util.function.Predicate, var107=org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_8__96, var1919=$r4, var2256=r9}
; {org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter=var3198, r2=var1, org.apache.dubbo.rpc.cluster.router.state.BitList=var3124, r3=var3993, org.apache.dubbo.common.URL=var1309, r7=var3867, org.apache.dubbo.rpc.Invocation=var1419, r0=var194, $r1=var3465, org.apache.dubbo.common.utils.StringUtils=var1729, $z0=var2320, $r8=var2398, $z1=var3996, java.util.function.Predicate=var1625, org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_8__96=var107, $r4=var1919, r9=var2256}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2}
;stmts r2 := @this: org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter;	r3 := @parameter0: org.apache.dubbo.rpc.cluster.router.state.BitList;	r7 := @parameter1: org.apache.dubbo.common.URL;	r0 := @parameter2: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("dubbo.tag");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r8 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("dubbo.tag");	$r8 = virtualinvoke r7.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("dubbo.tag");	goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r8)];	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r8);	if $z1 != 0 goto $r4 = staticinvoke <org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_8__96: java.util.function.Predicate bootstrap$()>();	$r4 = staticinvoke <org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter$lambda_filterUsingStaticTag_8__96: java.util.function.Predicate bootstrap$()>();	r9 = specialinvoke r2.<org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter: org.apache.dubbo.rpc.cluster.router.state.BitList filterInvoker(org.apache.dubbo.rpc.cluster.router.state.BitList,java.util.function.Predicate)>(r3, $r4);	return r9
;block_num 5