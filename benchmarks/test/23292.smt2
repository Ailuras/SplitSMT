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

(declare-sort var3762 0)
(declare-sort var3360 0)
(declare-sort var3416 0)
(declare-sort var1393 0)
(declare-sort var920 0)
(declare-sort var853 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1393_getUrl/-275947851 (var1393) var3416)
(declare-fun cast-from-var3762-to-var1393 (var3762) var1393)
(declare-fun var853_getReflectionServiceDescriptor/-718652752 (var3416) var920)
(declare-const null-var3762 var3762)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const null-var920 var920)
(declare-const var1429 var3762) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var1429 null-var3762)))
(declare-const var470 String) ; Statement: r4 := @parameter1: java.lang.String 
(assert (not (= var470 null-String)))
(declare-const var3515 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var3515 null-Bool)))
 ; Statement: if z0 == 0 goto $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert (= (ite var3515 1 0) 0)) ; Cond: z0 == 0 
(define-const var3241 var3416 (var1393_getUrl/-275947851 (cast-from-var3762-to-var1393 var1429))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(define-const var1169 var920 (var853_getReflectionServiceDescriptor/-718652752 var3241)) ; Statement: r9 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.DescriptorUtils: org.apache.dubbo.rpc.model.ServiceDescriptor getReflectionServiceDescriptor(org.apache.dubbo.common.URL)>($r1) 
(assert true) ; Non Conditional
 ; Statement: if r9 != null goto return r9 
(assert (not (= var1169 null-var920))) ; Cond: r9 != null 
 ; Statement: return r9 
(check-sat)
; {var1393_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var3762-to-var1393=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), var853_getReflectionServiceDescriptor/-718652752=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ServiceDescriptor)}
; {var3762=org.apache.dubbo.rpc.Invoker, var1429=r0, var470=r4, var3360=null_type, var3515=z0, var3416=org.apache.dubbo.common.URL, var1393=org.apache.dubbo.common.Node, var3241=$r1, var920=org.apache.dubbo.rpc.model.ServiceDescriptor, var853=org.apache.dubbo.rpc.protocol.tri.DescriptorUtils, var1169=r9}
; {org.apache.dubbo.rpc.Invoker=var3762, r0=var1429, r4=var470, null_type=var3360, z0=var3515, org.apache.dubbo.common.URL=var3416, org.apache.dubbo.common.Node=var1393, $r1=var3241, org.apache.dubbo.rpc.model.ServiceDescriptor=var920, org.apache.dubbo.rpc.protocol.tri.DescriptorUtils=var853, r9=var1169}
;seq 
;cnt {}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	r4 := @parameter1: java.lang.String;	z0 := @parameter2: boolean;	if z0 == 0 goto $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r9 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.DescriptorUtils: org.apache.dubbo.rpc.model.ServiceDescriptor getReflectionServiceDescriptor(org.apache.dubbo.common.URL)>($r1);	if r9 != null goto return r9;	return r9
;block_num 4