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

(declare-sort var3691 0)
(declare-sort var2561 0)
(declare-sort var3074 0)
(declare-sort var2695 0)
(declare-sort var1163 0)
(declare-sort var1188 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2695_getUrl/-275947851 (var2695) var3074)
(declare-fun cast-from-var3691-to-var2695 (var3691) var2695)
(declare-fun var1188_getStubServiceDescriptor/-686957074 (var3074 String) var1163)
(declare-const null-var3691 var3691)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const null-var1163 var1163)
(declare-const var92 var3691) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var92 null-var3691)))
(declare-const var311 String) ; Statement: r4 := @parameter1: java.lang.String 
(assert (not (= var311 null-String)))
(declare-const var607 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var607 null-Bool)))
 ; Statement: if z0 == 0 goto $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert (not (= (ite var607 1 0) 0))) ; Negate: Cond: z0 == 0  
(define-const var65 var3074 (var2695_getUrl/-275947851 (cast-from-var3691-to-var2695 var92))) ; Statement: $r8 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(define-const var1029 var1163 (var1188_getStubServiceDescriptor/-686957074 var65 var311)) ; Statement: r9 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.DescriptorUtils: org.apache.dubbo.rpc.model.ServiceDescriptor getStubServiceDescriptor(org.apache.dubbo.common.URL,java.lang.String)>($r8, r4) 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if r9 != null goto return r9 
(assert (not (= var1029 null-var1163))) ; Cond: r9 != null 
 ; Statement: return r9 
(check-sat)
; {var2695_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var3691-to-var2695=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), var1188_getStubServiceDescriptor/-686957074=([org.apache.dubbo.common.URL, java.lang.String], org.apache.dubbo.rpc.model.ServiceDescriptor)}
; {var3691=org.apache.dubbo.rpc.Invoker, var92=r0, var311=r4, var2561=null_type, var607=z0, var3074=org.apache.dubbo.common.URL, var2695=org.apache.dubbo.common.Node, var65=$r8, var1163=org.apache.dubbo.rpc.model.ServiceDescriptor, var1188=org.apache.dubbo.rpc.protocol.tri.DescriptorUtils, var1029=r9}
; {org.apache.dubbo.rpc.Invoker=var3691, r0=var92, r4=var311, null_type=var2561, z0=var607, org.apache.dubbo.common.URL=var3074, org.apache.dubbo.common.Node=var2695, $r8=var65, org.apache.dubbo.rpc.model.ServiceDescriptor=var1163, org.apache.dubbo.rpc.protocol.tri.DescriptorUtils=var1188, r9=var1029}
;seq 
;cnt {}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	r4 := @parameter1: java.lang.String;	z0 := @parameter2: boolean;	if z0 == 0 goto $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r8 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r9 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.DescriptorUtils: org.apache.dubbo.rpc.model.ServiceDescriptor getStubServiceDescriptor(org.apache.dubbo.common.URL,java.lang.String)>($r8, r4);	goto [?= (branch)];	if r9 != null goto return r9;	return r9
;block_num 4