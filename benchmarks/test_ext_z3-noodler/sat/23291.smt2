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

(declare-sort var1896 0)
(declare-sort var860 0)
(declare-sort var3778 0)
(declare-sort var2065 0)
(declare-sort var1979 0)
(declare-sort var2313 0)
(declare-sort var757 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2065_getUrl/-275947851 (var2065) var3778)
(declare-fun cast-from-var1896-to-var2065 (var1896) var2065)
(declare-fun var2313_getReflectionServiceDescriptor/-718652752 (var3778) var1979)
(declare-fun var757-init () var757)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-592620141 (var757 String) void)
(declare-const null-var1896 var1896)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const null-var1979 var1979)
(declare-const var2535 var1896) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var2535 null-var1896)))
(declare-const var3293 String) ; Statement: r4 := @parameter1: java.lang.String 
(assert (not (= var3293 null-String)))
(declare-const var3886 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var3886 null-Bool)))
 ; Statement: if z0 == 0 goto $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert (= (ite var3886 1 0) 0)) ; Cond: z0 == 0 
(define-const var3952 var3778 (var2065_getUrl/-275947851 (cast-from-var1896-to-var2065 var2535))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(define-const var2731 var1979 (var2313_getReflectionServiceDescriptor/-718652752 var3952)) ; Statement: r9 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.DescriptorUtils: org.apache.dubbo.rpc.model.ServiceDescriptor getReflectionServiceDescriptor(org.apache.dubbo.common.URL)>($r1) 
(assert true) ; Non Conditional
 ; Statement: if r9 != null goto return r9 
(assert (not (not (= var2731 null-var1979)))) ; Negate: Cond: r9 != null  
(define-const var1857 var757 var757-init) ; Statement: $r2 = new org.apache.dubbo.remoting.http12.exception.UnimplementedException 
(define-const var3606 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3606)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3606!1 String)
(assert (= var3606!1 ""))
(assert true)
(define-const var3569 String (append/672562846 var3606!1 "service:")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("service:") 
(declare-const var3606!2 String)
(assert (= var3606!2 (str.++ var3606!1 "service:")))
(assert true)
(define-const var71 String (append/672562846 var3569 var3293)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var3569!1 String)
(assert (= var3569!1 (str.++ var3569 var3293)))
(assert true)
(define-const var19 String (toString/-2075883882 var71)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-592620141 var1857 var19)) ; Statement: specialinvoke $r2.<org.apache.dubbo.remoting.http12.exception.UnimplementedException: void <init>(java.lang.String)>($r7) 

(declare-const var1857!1 var757)
(declare-const var19!1 String)
 ; Statement: throw $r2 
(check-sat)
; {var2065_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var1896-to-var2065=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), var2313_getReflectionServiceDescriptor/-718652752=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ServiceDescriptor), var757-init=([], org.apache.dubbo.remoting.http12.exception.UnimplementedException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-592620141=([org.apache.dubbo.remoting.http12.exception.UnimplementedException, java.lang.String], void)}
; {var1896=org.apache.dubbo.rpc.Invoker, var2535=r0, var3293=r4, var860=null_type, var3886=z0, var3778=org.apache.dubbo.common.URL, var2065=org.apache.dubbo.common.Node, var3952=$r1, var1979=org.apache.dubbo.rpc.model.ServiceDescriptor, var2313=org.apache.dubbo.rpc.protocol.tri.DescriptorUtils, var2731=r9, var757=org.apache.dubbo.remoting.http12.exception.UnimplementedException, var1857=$r2, var3606=$r3, var3569=$r5, var71=$r6, var19=$r7}
; {org.apache.dubbo.rpc.Invoker=var1896, r0=var2535, r4=var3293, null_type=var860, z0=var3886, org.apache.dubbo.common.URL=var3778, org.apache.dubbo.common.Node=var2065, $r1=var3952, org.apache.dubbo.rpc.model.ServiceDescriptor=var1979, org.apache.dubbo.rpc.protocol.tri.DescriptorUtils=var2313, r9=var2731, org.apache.dubbo.remoting.http12.exception.UnimplementedException=var757, $r2=var1857, $r3=var3606, $r5=var3569, $r6=var71, $r7=var19}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	r4 := @parameter1: java.lang.String;	z0 := @parameter2: boolean;	if z0 == 0 goto $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r9 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.DescriptorUtils: org.apache.dubbo.rpc.model.ServiceDescriptor getReflectionServiceDescriptor(org.apache.dubbo.common.URL)>($r1);	if r9 != null goto return r9;	$r2 = new org.apache.dubbo.remoting.http12.exception.UnimplementedException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("service:");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<org.apache.dubbo.remoting.http12.exception.UnimplementedException: void <init>(java.lang.String)>($r7);	throw $r2
;block_num 4