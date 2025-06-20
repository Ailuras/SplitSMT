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

(declare-sort var788 0)
(declare-sort var1326 0)
(declare-sort var3787 0)
(declare-sort var57 0)
(declare-sort var2777 0)
(declare-sort var3565 0)
(declare-sort var2646 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun addParameter/-1629709269 (var3787 String String) var3787)
(declare-fun addParameterIfAbsent/-944034303 (var3787 String String) var3787)
(declare-fun var57_getInstance/1376797019 (var1326) var57)
(declare-fun var57_createExecutorIfAbsent/1704630758 (var57 var3787) var2777)
(declare-fun arr-var3565-init () (Array Int var3565))
(declare-fun cast-from-var3787-to-var3565 (var3787) var3565)
(declare-fun String_format/1339386452 (String (Array Int var3565)) String)
(declare-fun var2646_requireNonNull/1378936425 (var3565 String) var3565)
(declare-fun cast-from-var2777-to-var3565 (var2777) var3565)
(declare-const null-var788 var788)
(declare-const null-var1326 var1326)
(declare-const null-var3787 var3787)
(declare-const null-__Array__Int__var3565__ (Array Int var3565))
(declare-const var2296 var788) ; Statement: r6 := @this: org.apache.dubbo.rpc.protocol.tri.TripleProtocol 
(assert (not (= var2296 null-var788)))
(declare-const var1431 var1326) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.model.ApplicationModel 
(assert (not (= var1431 null-var1326)))
(declare-const var1385 var3787) ; Statement: r7 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var1385 null-var3787)))
(assert true)
(define-const var2517 var3787 (addParameter/-1629709269 var1385 "threadname" "DubboClientHandler")) ; Statement: $r0 = virtualinvoke r7.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("threadname", "DubboClientHandler") 
(assert true)
(define-const var2940 var3787 (addParameterIfAbsent/-944034303 var2517 "threadpool" "cached")) ; Statement: r8 = virtualinvoke $r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameterIfAbsent(java.lang.String,java.lang.String)>("threadpool", "cached") 
(define-const var1667 var57 (var57_getInstance/1376797019 var1431)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.threadpool.manager.ExecutorRepository: org.apache.dubbo.common.threadpool.manager.ExecutorRepository getInstance(org.apache.dubbo.rpc.model.ApplicationModel)>(r1) 
(define-const var627 var2777 (var57_createExecutorIfAbsent/1704630758 var1667 var2940)) ; Statement: r3 = interfaceinvoke $r2.<org.apache.dubbo.common.threadpool.manager.ExecutorRepository: java.util.concurrent.ExecutorService createExecutorIfAbsent(org.apache.dubbo.common.URL)>(r8) 
(define-const var3372 (Array Int var3565) arr-var3565-init) ; Statement: $r4 = newarray (java.lang.Object)[1] 
(declare-const var3372!1 (Array Int var3565))
(assert (not (= var3372!1 null-__Array__Int__var3565__)))
(assert (= (select var3372!1 0) (cast-from-var3787-to-var3565 var2940))) ; Statement: $r4[0] = r8 
(define-const var453 String (String_format/1339386452 "No available executor found in %s" var3372!1)) ; Statement: $r5 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("No available executor found in %s", $r4) 
;(assert (var2646_requireNonNull/1378936425 (cast-from-var2777-to-var3565 var627) var453)) ; Statement: staticinvoke <java.util.Objects: java.lang.Object requireNonNull(java.lang.Object,java.lang.String)>(r3, $r5) 

(declare-const var627!1 var2777)
(declare-const var453!1 String)
 ; Statement: return r3 
(check-sat)
; {addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL), addParameterIfAbsent/-944034303=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL), var57_getInstance/1376797019=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.common.threadpool.manager.ExecutorRepository), var57_createExecutorIfAbsent/1704630758=([org.apache.dubbo.common.threadpool.manager.ExecutorRepository, org.apache.dubbo.common.URL], java.util.concurrent.ExecutorService), arr-var3565-init=([], java.lang.Object[]), cast-from-var3787-to-var3565=([org.apache.dubbo.common.URL], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), var2646_requireNonNull/1378936425=([java.lang.Object, java.lang.String], java.lang.Object), cast-from-var2777-to-var3565=([java.util.concurrent.ExecutorService], java.lang.Object)}
; {var788=org.apache.dubbo.rpc.protocol.tri.TripleProtocol, var2296=r6, var1326=org.apache.dubbo.rpc.model.ApplicationModel, var1431=r1, var3787=org.apache.dubbo.common.URL, var1385=r7, var2517=$r0, var2940=r8, var57=org.apache.dubbo.common.threadpool.manager.ExecutorRepository, var1667=$r2, var2777=java.util.concurrent.ExecutorService, var627=r3, var3565=java.lang.Object, var3372=$r4, var453=$r5, var2646=java.util.Objects}
; {org.apache.dubbo.rpc.protocol.tri.TripleProtocol=var788, r6=var2296, org.apache.dubbo.rpc.model.ApplicationModel=var1326, r1=var1431, org.apache.dubbo.common.URL=var3787, r7=var1385, $r0=var2517, r8=var2940, org.apache.dubbo.common.threadpool.manager.ExecutorRepository=var57, $r2=var1667, java.util.concurrent.ExecutorService=var2777, r3=var627, java.lang.Object=var3565, $r4=var3372, $r5=var453, java.util.Objects=var2646}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r6 := @this: org.apache.dubbo.rpc.protocol.tri.TripleProtocol;	r1 := @parameter0: org.apache.dubbo.rpc.model.ApplicationModel;	r7 := @parameter1: org.apache.dubbo.common.URL;	$r0 = virtualinvoke r7.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("threadname", "DubboClientHandler");	r8 = virtualinvoke $r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameterIfAbsent(java.lang.String,java.lang.String)>("threadpool", "cached");	$r2 = staticinvoke <org.apache.dubbo.common.threadpool.manager.ExecutorRepository: org.apache.dubbo.common.threadpool.manager.ExecutorRepository getInstance(org.apache.dubbo.rpc.model.ApplicationModel)>(r1);	r3 = interfaceinvoke $r2.<org.apache.dubbo.common.threadpool.manager.ExecutorRepository: java.util.concurrent.ExecutorService createExecutorIfAbsent(org.apache.dubbo.common.URL)>(r8);	$r4 = newarray (java.lang.Object)[1];	$r4[0] = r8;	$r5 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("No available executor found in %s", $r4);	staticinvoke <java.util.Objects: java.lang.Object requireNonNull(java.lang.Object,java.lang.String)>(r3, $r5);	return r3
;block_num 1