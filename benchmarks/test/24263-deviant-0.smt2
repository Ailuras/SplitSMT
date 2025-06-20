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

(declare-sort var381 0)
(declare-sort var3037 0)
(declare-sort var3706 0)
(declare-sort var3649 0)
(declare-sort var3369 0)
(declare-sort var223 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3649_getUrl/-275947851 (var3649) var3706)
(declare-fun cast-from-var3037-to-var3649 (var3037) var3649)
(declare-fun getServiceKey/1456125852 (var3706) String)
(declare-fun getServiceModel/-1482396633 (var3706) var3369)
(declare-fun getServiceModel/-1583884111 (var3369) var223)
(declare-fun var223_getInterfaceName/228305574 (var223) String)
(declare-fun register0/2124677208 (var381 String String var3037 var3706) void)
(declare-fun getPath/898047937 (var3706) String)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun getGroup/1342955253 (var3706) String)
(declare-fun getVersion/189836348 (var3706) String)
(declare-fun var3706_buildKey/1628109746 (String String String) String)
(declare-const null-var381 var381)
(declare-const null-var3037 var3037)
(declare-const var3482 var381) ; Statement: r6 := @this: org.apache.dubbo.rpc.protocol.tri.TriplePathResolver 
(assert (not (= var3482 null-var381)))
(declare-const var528 var3037) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var528 null-var3037)))
(define-const var2241 var3706 (var3649_getUrl/-275947851 (cast-from-var3037-to-var3649 var528))) ; Statement: r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3826 String (getServiceKey/1456125852 var2241)) ; Statement: r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(assert true)
(define-const var3500 var3369 (getServiceModel/-1482396633 var2241)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ServiceModel getServiceModel()>() 
(assert true)
(define-const var2186 var223 (getServiceModel/-1583884111 var3500)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.model.ServiceModel: org.apache.dubbo.rpc.model.ServiceDescriptor getServiceModel()>() 
(define-const var1013 String (var223_getInterfaceName/228305574 var2186)) ; Statement: r5 = interfaceinvoke $r4.<org.apache.dubbo.rpc.model.ServiceDescriptor: java.lang.String getInterfaceName()>() 
(assert true)
;(assert (register0/2124677208 var3482 var3826 var1013 var528 var2241)) ; Statement: specialinvoke r6.<org.apache.dubbo.rpc.protocol.tri.TriplePathResolver: void register0(java.lang.String,java.lang.String,org.apache.dubbo.rpc.Invoker,org.apache.dubbo.common.URL)>(r2, r5, r0, r1) 

(declare-const var3482!1 var381)
(declare-const var3826!1 String)
(declare-const var1013!1 String)
(declare-const var528!1 var3037)
(declare-const var2241!1 var3706)
(assert true)
(define-const var1702 String (getPath/898047937 var2241!1)) ; Statement: r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert true)
(define-const var2049 Int (lastIndexOf/-1292097097 var1702 47)) ; Statement: i0 = virtualinvoke r7.<java.lang.String: int lastIndexOf(int)>(47) 
(define-const var3665 Int (cast-from-Int-to-Int -1)) ; Statement: $i3 = (int) -1 
 ; Statement: if i0 != $i3 goto $r16 = new java.lang.StringBuilder 
(assert (not (= var2049 var3665))) ; Cond: i0 != $i3 
(define-const var3953 String String-init) ; Statement: $r16 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3953)) ; Statement: specialinvoke $r16.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3953!1 String)
(assert (= var3953!1 ""))
(define-const var70 Int (+ var2049 1)) ; Statement: $i1 = i0 + 1 
(assert (not (and true (and (>= 0 0) (>= (str.len var1702) var70) (>= var70 0)))))
(check-sat)
; {var3649_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var3037-to-var3649=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), getServiceModel/-1482396633=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ServiceModel), getServiceModel/-1583884111=([org.apache.dubbo.rpc.model.ServiceModel], org.apache.dubbo.rpc.model.ServiceDescriptor), var223_getInterfaceName/228305574=([org.apache.dubbo.rpc.model.ServiceDescriptor], java.lang.String), register0/2124677208=([org.apache.dubbo.rpc.protocol.tri.TriplePathResolver, java.lang.String, java.lang.String, org.apache.dubbo.rpc.Invoker, org.apache.dubbo.common.URL], void), getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), lastIndexOf/-1292097097=([java.lang.String, int], int), cast-from-Int-to-Int=([int], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), substring/-1240304868=([java.lang.String, int, int], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), getGroup/1342955253=([org.apache.dubbo.common.URL], java.lang.String), getVersion/189836348=([org.apache.dubbo.common.URL], java.lang.String), var3706_buildKey/1628109746=([java.lang.String, java.lang.String, java.lang.String], java.lang.String)}
; {var381=org.apache.dubbo.rpc.protocol.tri.TriplePathResolver, var3482=r6, var3037=org.apache.dubbo.rpc.Invoker, var528=r0, var3706=org.apache.dubbo.common.URL, var3649=org.apache.dubbo.common.Node, var2241=r1, var3826=r2, var3369=org.apache.dubbo.rpc.model.ServiceModel, var3500=$r3, var223=org.apache.dubbo.rpc.model.ServiceDescriptor, var2186=$r4, var1013=r5, var1702=r7, var2049=i0, var3665=$i3, var3953=$r16, var70=$i1, var2542=$r9, var803=$r10, var1694=$r11, var285=r12, var1066=$r14, var2189=$r13, var1184=$r15}
; {org.apache.dubbo.rpc.protocol.tri.TriplePathResolver=var381, r6=var3482, org.apache.dubbo.rpc.Invoker=var3037, r0=var528, org.apache.dubbo.common.URL=var3706, org.apache.dubbo.common.Node=var3649, r1=var2241, r2=var3826, org.apache.dubbo.rpc.model.ServiceModel=var3369, $r3=var3500, org.apache.dubbo.rpc.model.ServiceDescriptor=var223, $r4=var2186, r5=var1013, r7=var1702, i0=var2049, $i3=var3665, $r16=var3953, $i1=var70, $r9=var2542, $r10=var803, $r11=var1694, r12=var285, $r14=var1066, $r13=var2189, $r15=var1184}
;seq <java.lang.String: int lastIndexOf(int)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r6 := @this: org.apache.dubbo.rpc.protocol.tri.TriplePathResolver;	r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ServiceModel getServiceModel()>();	$r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.model.ServiceModel: org.apache.dubbo.rpc.model.ServiceDescriptor getServiceModel()>();	r5 = interfaceinvoke $r4.<org.apache.dubbo.rpc.model.ServiceDescriptor: java.lang.String getInterfaceName()>();	specialinvoke r6.<org.apache.dubbo.rpc.protocol.tri.TriplePathResolver: void register0(java.lang.String,java.lang.String,org.apache.dubbo.rpc.Invoker,org.apache.dubbo.common.URL)>(r2, r5, r0, r1);	r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	i0 = virtualinvoke r7.<java.lang.String: int lastIndexOf(int)>(47);	$i3 = (int) -1;	if i0 != $i3 goto $r16 = new java.lang.StringBuilder;	$r16 = new java.lang.StringBuilder;	specialinvoke $r16.<java.lang.StringBuilder: void <init>()>();	$i1 = i0 + 1;	$r9 = virtualinvoke r7.<java.lang.String: java.lang.String substring(int,int)>(0, $i1);	$r10 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5);	r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	$r14 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	$r13 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getVersion()>();	$r15 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String buildKey(java.lang.String,java.lang.String,java.lang.String)>(r7, $r14, $r13);	specialinvoke r6.<org.apache.dubbo.rpc.protocol.tri.TriplePathResolver: void register0(java.lang.String,java.lang.String,org.apache.dubbo.rpc.Invoker,org.apache.dubbo.common.URL)>($r15, r12, r0, r1);	return
;block_num 2