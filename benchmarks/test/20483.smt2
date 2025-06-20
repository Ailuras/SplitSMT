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

(declare-sort var2514 0)
(declare-sort var187 0)
(declare-sort var3967 0)
(declare-sort var1137 0)
(declare-sort var3032 0)
(declare-sort var556 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var187-init () var187)
(declare-fun <init>/-974988547 (var187) void)
(declare-fun serviceModel/-1585781850 (var2514) var3967)
(declare-fun interfaceName/-1585781850 (var2514) String)
(declare-fun var1137_isNotEmpty/-1251449450 (String) Bool)
(declare-fun get/981896790 (var187) var3032)
(declare-fun parameterTypesDesc/-1585781850 (var2514) String)
(declare-const null-var2514 var2514)
(declare-const null-var3967 var3967)
(declare-const null-var3032 var3032)
(declare-const null-String String)
(declare-const var1399 var2514) ; Statement: r1 := @this: org.apache.dubbo.rpc.RpcInvocation 
(assert (not (= var1399 null-var2514)))
(define-const var2139 var187 var187-init) ; Statement: $r0 = new java.util.concurrent.atomic.AtomicReference 
(assert true)
;(assert (<init>/-974988547 var2139)) ; Statement: specialinvoke $r0.<java.util.concurrent.atomic.AtomicReference: void <init>()>() 

(declare-const var2139!1 var187)
(define-const var1593 var3967 (serviceModel/-1585781850 var1399)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.model.ServiceModel serviceModel> 
 ; Statement: if $r2 == null goto $r3 = r1.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String interfaceName> 
(assert (= var1593 null-var3967)) ; Cond: $r2 == null 
(define-const var1938 String (interfaceName/-1585781850 var1399)) ; Statement: $r3 = r1.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String interfaceName> 
(define-const var1763 Bool (var1137_isNotEmpty/-1251449450 var1938)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r3) 
 ; Statement: if $z0 == 0 goto $r36 = virtualinvoke $r0.<java.util.concurrent.atomic.AtomicReference: java.lang.Object get()>() 
(assert (= (ite var1763 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var19 var3032 (get/981896790 var2139!1)) ; Statement: $r36 = virtualinvoke $r0.<java.util.concurrent.atomic.AtomicReference: java.lang.Object get()>() 
 ; Statement: if $r36 == null goto $r37 = r1.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String parameterTypesDesc> 
(assert (= var19 null-var3032)) ; Cond: $r36 == null 
(define-const var2993 String (parameterTypesDesc/-1585781850 var1399)) ; Statement: $r37 = r1.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String parameterTypesDesc> 
 ; Statement: if $r37 != null goto return 
(assert (not (= var2993 null-String))) ; Cond: $r37 != null 
 ; Statement: return 
(check-sat)
; {var187-init=([], java.util.concurrent.atomic.AtomicReference), <init>/-974988547=([java.util.concurrent.atomic.AtomicReference], void), serviceModel/-1585781850=([org.apache.dubbo.rpc.RpcInvocation], org.apache.dubbo.rpc.model.ServiceModel), interfaceName/-1585781850=([org.apache.dubbo.rpc.RpcInvocation], java.lang.String), var1137_isNotEmpty/-1251449450=([java.lang.String], boolean), get/981896790=([java.util.concurrent.atomic.AtomicReference], java.lang.Object), parameterTypesDesc/-1585781850=([org.apache.dubbo.rpc.RpcInvocation], java.lang.String)}
; {var2514=org.apache.dubbo.rpc.RpcInvocation, var1399=r1, var187=java.util.concurrent.atomic.AtomicReference, var2139=$r0, var3967=org.apache.dubbo.rpc.model.ServiceModel, var1593=$r2, var1938=$r3, var1137=org.apache.dubbo.common.utils.StringUtils, var1763=$z0, var3032=java.lang.Object, var19=$r36, var2993=$r37, var556=null_type}
; {org.apache.dubbo.rpc.RpcInvocation=var2514, r1=var1399, java.util.concurrent.atomic.AtomicReference=var187, $r0=var2139, org.apache.dubbo.rpc.model.ServiceModel=var3967, $r2=var1593, $r3=var1938, org.apache.dubbo.common.utils.StringUtils=var1137, $z0=var1763, java.lang.Object=var3032, $r36=var19, $r37=var2993, null_type=var556}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.RpcInvocation;	$r0 = new java.util.concurrent.atomic.AtomicReference;	specialinvoke $r0.<java.util.concurrent.atomic.AtomicReference: void <init>()>();	$r2 = r1.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.model.ServiceModel serviceModel>;	if $r2 == null goto $r3 = r1.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String interfaceName>;	$r3 = r1.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String interfaceName>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r3);	if $z0 == 0 goto $r36 = virtualinvoke $r0.<java.util.concurrent.atomic.AtomicReference: java.lang.Object get()>();	$r36 = virtualinvoke $r0.<java.util.concurrent.atomic.AtomicReference: java.lang.Object get()>();	if $r36 == null goto $r37 = r1.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String parameterTypesDesc>;	$r37 = r1.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String parameterTypesDesc>;	if $r37 != null goto return;	return
;block_num 5