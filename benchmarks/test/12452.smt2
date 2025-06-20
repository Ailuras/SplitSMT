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

(declare-sort var810 0)
(declare-sort var1632 0)
(declare-sort var2140 0)
(declare-sort var2027 0)
(declare-sort var2689 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun routerSnapshotSwitcher/470289796 (var810) var2140)
(declare-fun getEnabledService/479098787 (var2140) var2027)
(declare-fun String_join/1594745010 (String var2689) String)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun cast-from-var2027-to-var2689 (var2027) var2689)
(declare-const null-var810 var810)
(declare-const null-var1632 var1632)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1164 var810) ; Statement: r0 := @this: org.apache.dubbo.qos.command.impl.GetEnabledRouterSnapshot 
(assert (not (= var1164 null-var810)))
(declare-const var3883 var1632) ; Statement: r4 := @parameter0: org.apache.dubbo.qos.api.CommandContext 
(assert (not (= var3883 null-var1632)))
(declare-const var3997 (Array Int String)) ; Statement: r5 := @parameter1: java.lang.String[] 
(assert (not (= var3997 null-__Array__Int__String__)))
(define-const var318 var2140 (routerSnapshotSwitcher/470289796 var1164)) ; Statement: $r1 = r0.<org.apache.dubbo.qos.command.impl.GetEnabledRouterSnapshot: org.apache.dubbo.rpc.cluster.router.RouterSnapshotSwitcher routerSnapshotSwitcher> 
(assert true)
(define-const var3424 var2027 (getEnabledService/479098787 var318)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotSwitcher: java.util.Set getEnabledService()>() 
(define-const var2770 String (String_join/1594745010 (cast-from-String-to-String "\n") (cast-from-var2027-to-var2689 var3424))) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.Iterable)>("\n", $r2) 
 ; Statement: return $r3 
(check-sat)
; {routerSnapshotSwitcher/470289796=([org.apache.dubbo.qos.command.impl.GetEnabledRouterSnapshot], org.apache.dubbo.rpc.cluster.router.RouterSnapshotSwitcher), getEnabledService/479098787=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotSwitcher], java.util.Set), String_join/1594745010=([java.lang.CharSequence, java.lang.Iterable], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), cast-from-var2027-to-var2689=([java.util.Set], java.lang.Iterable)}
; {var810=org.apache.dubbo.qos.command.impl.GetEnabledRouterSnapshot, var1164=r0, var1632=org.apache.dubbo.qos.api.CommandContext, var3883=r4, var3997=r5, var2140=org.apache.dubbo.rpc.cluster.router.RouterSnapshotSwitcher, var318=$r1, var2027=java.util.Set, var3424=$r2, var2689=java.lang.Iterable, var2770=$r3}
; {org.apache.dubbo.qos.command.impl.GetEnabledRouterSnapshot=var810, r0=var1164, org.apache.dubbo.qos.api.CommandContext=var1632, r4=var3883, r5=var3997, org.apache.dubbo.rpc.cluster.router.RouterSnapshotSwitcher=var2140, $r1=var318, java.util.Set=var2027, $r2=var3424, java.lang.Iterable=var2689, $r3=var2770}
;seq <java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.Iterable)>
;cnt {"<java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.Iterable)>": 1}
;stmts r0 := @this: org.apache.dubbo.qos.command.impl.GetEnabledRouterSnapshot;	r4 := @parameter0: org.apache.dubbo.qos.api.CommandContext;	r5 := @parameter1: java.lang.String[];	$r1 = r0.<org.apache.dubbo.qos.command.impl.GetEnabledRouterSnapshot: org.apache.dubbo.rpc.cluster.router.RouterSnapshotSwitcher routerSnapshotSwitcher>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotSwitcher: java.util.Set getEnabledService()>();	$r3 = staticinvoke <java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.Iterable)>("\n", $r2);	return $r3
;block_num 1