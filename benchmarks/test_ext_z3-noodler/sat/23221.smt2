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

(declare-sort var2449 0)
(declare-sort var2850 0)
(declare-sort var916 0)
(declare-sort var2114 0)
(declare-sort var273 0)
(declare-sort var112 0)
(declare-sort var1451 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2114_getUrl/-275947851 (var2114) var916)
(declare-fun cast-from-var2449-to-var2114 (var2449) var2114)
(declare-fun var112_getStubServiceDescriptor/-686957074 (var916 String) var273)
(declare-fun var1451-init () var1451)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-592620141 (var1451 String) void)
(declare-const null-var2449 var2449)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const null-var273 var273)
(declare-const var3145 var2449) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var3145 null-var2449)))
(declare-const var1014 String) ; Statement: r4 := @parameter1: java.lang.String 
(assert (not (= var1014 null-String)))
(declare-const var2920 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var2920 null-Bool)))
 ; Statement: if z0 == 0 goto $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert (not (= (ite var2920 1 0) 0))) ; Negate: Cond: z0 == 0  
(define-const var2001 var916 (var2114_getUrl/-275947851 (cast-from-var2449-to-var2114 var3145))) ; Statement: $r8 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(define-const var2745 var273 (var112_getStubServiceDescriptor/-686957074 var2001 var1014)) ; Statement: r9 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.DescriptorUtils: org.apache.dubbo.rpc.model.ServiceDescriptor getStubServiceDescriptor(org.apache.dubbo.common.URL,java.lang.String)>($r8, r4) 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if r9 != null goto return r9 
(assert (not (not (= var2745 null-var273)))) ; Negate: Cond: r9 != null  
(define-const var925 var1451 var1451-init) ; Statement: $r2 = new org.apache.dubbo.remoting.http12.exception.UnimplementedException 
(define-const var663 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var663)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var663!1 String)
(assert (= var663!1 ""))
(assert true)
(define-const var1730 String (append/672562846 var663!1 "service:")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("service:") 
(declare-const var663!2 String)
(assert (= var663!2 (str.++ var663!1 "service:")))
(assert true)
(define-const var1847 String (append/672562846 var1730 var1014)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var1730!1 String)
(assert (= var1730!1 (str.++ var1730 var1014)))
(assert true)
(define-const var246 String (toString/-2075883882 var1847)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-592620141 var925 var246)) ; Statement: specialinvoke $r2.<org.apache.dubbo.remoting.http12.exception.UnimplementedException: void <init>(java.lang.String)>($r7) 

(declare-const var925!1 var1451)
(declare-const var246!1 String)
 ; Statement: throw $r2 
(check-sat)
; {var2114_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var2449-to-var2114=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), var112_getStubServiceDescriptor/-686957074=([org.apache.dubbo.common.URL, java.lang.String], org.apache.dubbo.rpc.model.ServiceDescriptor), var1451-init=([], org.apache.dubbo.remoting.http12.exception.UnimplementedException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-592620141=([org.apache.dubbo.remoting.http12.exception.UnimplementedException, java.lang.String], void)}
; {var2449=org.apache.dubbo.rpc.Invoker, var3145=r0, var1014=r4, var2850=null_type, var2920=z0, var916=org.apache.dubbo.common.URL, var2114=org.apache.dubbo.common.Node, var2001=$r8, var273=org.apache.dubbo.rpc.model.ServiceDescriptor, var112=org.apache.dubbo.rpc.protocol.tri.DescriptorUtils, var2745=r9, var1451=org.apache.dubbo.remoting.http12.exception.UnimplementedException, var925=$r2, var663=$r3, var1730=$r5, var1847=$r6, var246=$r7}
; {org.apache.dubbo.rpc.Invoker=var2449, r0=var3145, r4=var1014, null_type=var2850, z0=var2920, org.apache.dubbo.common.URL=var916, org.apache.dubbo.common.Node=var2114, $r8=var2001, org.apache.dubbo.rpc.model.ServiceDescriptor=var273, org.apache.dubbo.rpc.protocol.tri.DescriptorUtils=var112, r9=var2745, org.apache.dubbo.remoting.http12.exception.UnimplementedException=var1451, $r2=var925, $r3=var663, $r5=var1730, $r6=var1847, $r7=var246}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	r4 := @parameter1: java.lang.String;	z0 := @parameter2: boolean;	if z0 == 0 goto $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r8 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r9 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.DescriptorUtils: org.apache.dubbo.rpc.model.ServiceDescriptor getStubServiceDescriptor(org.apache.dubbo.common.URL,java.lang.String)>($r8, r4);	goto [?= (branch)];	if r9 != null goto return r9;	$r2 = new org.apache.dubbo.remoting.http12.exception.UnimplementedException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("service:");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<org.apache.dubbo.remoting.http12.exception.UnimplementedException: void <init>(java.lang.String)>($r7);	throw $r2
;block_num 4