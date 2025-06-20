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

(declare-sort var757 0)
(declare-sort var66 0)
(declare-sort var2142 0)
(declare-sort var2767 0)
(declare-sort var3020 0)
(declare-sort var1964 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2767_getUrl/-275947851 (var2767) var2142)
(declare-fun cast-from-var66-to-var2767 (var66) var2767)
(declare-fun getServiceKey/1456125852 (var2142) String)
(declare-fun getServiceModel/-1482396633 (var2142) var3020)
(declare-fun getServiceModel/-1583884111 (var3020) var1964)
(declare-fun var1964_getInterfaceName/228305574 (var1964) String)
(declare-fun register0/2124677208 (var757 String String var66 var2142) void)
(declare-fun getPath/898047937 (var2142) String)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var757 var757)
(declare-const null-var66 var66)
(declare-const var1095 var757) ; Statement: r6 := @this: org.apache.dubbo.rpc.protocol.tri.TriplePathResolver 
(assert (not (= var1095 null-var757)))
(declare-const var769 var66) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var769 null-var66)))
(define-const var1856 var2142 (var2767_getUrl/-275947851 (cast-from-var66-to-var2767 var769))) ; Statement: r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3038 String (getServiceKey/1456125852 var1856)) ; Statement: r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(assert true)
(define-const var3720 var3020 (getServiceModel/-1482396633 var1856)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ServiceModel getServiceModel()>() 
(assert true)
(define-const var1450 var1964 (getServiceModel/-1583884111 var3720)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.model.ServiceModel: org.apache.dubbo.rpc.model.ServiceDescriptor getServiceModel()>() 
(define-const var544 String (var1964_getInterfaceName/228305574 var1450)) ; Statement: r5 = interfaceinvoke $r4.<org.apache.dubbo.rpc.model.ServiceDescriptor: java.lang.String getInterfaceName()>() 
(assert true)
;(assert (register0/2124677208 var1095 var3038 var544 var769 var1856)) ; Statement: specialinvoke r6.<org.apache.dubbo.rpc.protocol.tri.TriplePathResolver: void register0(java.lang.String,java.lang.String,org.apache.dubbo.rpc.Invoker,org.apache.dubbo.common.URL)>(r2, r5, r0, r1) 

(declare-const var1095!1 var757)
(declare-const var3038!1 String)
(declare-const var544!1 String)
(declare-const var769!1 var66)
(declare-const var1856!1 var2142)
(assert true)
(define-const var1729 String (getPath/898047937 var1856!1)) ; Statement: r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert true)
(define-const var2252 Int (lastIndexOf/-1292097097 var1729 47)) ; Statement: i0 = virtualinvoke r7.<java.lang.String: int lastIndexOf(int)>(47) 
(define-const var1665 Int (cast-from-Int-to-Int -1)) ; Statement: $i3 = (int) -1 
 ; Statement: if i0 != $i3 goto $r16 = new java.lang.StringBuilder 
(assert (not (not (= var2252 var1665)))) ; Negate: Cond: i0 != $i3  
 ; Statement: return 
(check-sat)
; {var2767_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var66-to-var2767=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), getServiceModel/-1482396633=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ServiceModel), getServiceModel/-1583884111=([org.apache.dubbo.rpc.model.ServiceModel], org.apache.dubbo.rpc.model.ServiceDescriptor), var1964_getInterfaceName/228305574=([org.apache.dubbo.rpc.model.ServiceDescriptor], java.lang.String), register0/2124677208=([org.apache.dubbo.rpc.protocol.tri.TriplePathResolver, java.lang.String, java.lang.String, org.apache.dubbo.rpc.Invoker, org.apache.dubbo.common.URL], void), getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), lastIndexOf/-1292097097=([java.lang.String, int], int), cast-from-Int-to-Int=([int], int)}
; {var757=org.apache.dubbo.rpc.protocol.tri.TriplePathResolver, var1095=r6, var66=org.apache.dubbo.rpc.Invoker, var769=r0, var2142=org.apache.dubbo.common.URL, var2767=org.apache.dubbo.common.Node, var1856=r1, var3038=r2, var3020=org.apache.dubbo.rpc.model.ServiceModel, var3720=$r3, var1964=org.apache.dubbo.rpc.model.ServiceDescriptor, var1450=$r4, var544=r5, var1729=r7, var2252=i0, var1665=$i3}
; {org.apache.dubbo.rpc.protocol.tri.TriplePathResolver=var757, r6=var1095, org.apache.dubbo.rpc.Invoker=var66, r0=var769, org.apache.dubbo.common.URL=var2142, org.apache.dubbo.common.Node=var2767, r1=var1856, r2=var3038, org.apache.dubbo.rpc.model.ServiceModel=var3020, $r3=var3720, org.apache.dubbo.rpc.model.ServiceDescriptor=var1964, $r4=var1450, r5=var544, r7=var1729, i0=var2252, $i3=var1665}
;seq <java.lang.String: int lastIndexOf(int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1}
;stmts r6 := @this: org.apache.dubbo.rpc.protocol.tri.TriplePathResolver;	r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ServiceModel getServiceModel()>();	$r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.model.ServiceModel: org.apache.dubbo.rpc.model.ServiceDescriptor getServiceModel()>();	r5 = interfaceinvoke $r4.<org.apache.dubbo.rpc.model.ServiceDescriptor: java.lang.String getInterfaceName()>();	specialinvoke r6.<org.apache.dubbo.rpc.protocol.tri.TriplePathResolver: void register0(java.lang.String,java.lang.String,org.apache.dubbo.rpc.Invoker,org.apache.dubbo.common.URL)>(r2, r5, r0, r1);	r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	i0 = virtualinvoke r7.<java.lang.String: int lastIndexOf(int)>(47);	$i3 = (int) -1;	if i0 != $i3 goto $r16 = new java.lang.StringBuilder;	return
;block_num 2