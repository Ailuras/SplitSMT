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

(declare-sort var1587 0)
(declare-sort var748 0)
(declare-sort var3915 0)
(declare-sort var2848 0)
(declare-sort var2850 0)
(declare-sort var3465 0)
(declare-sort var1958 0)
(declare-sort var3992 0)
(declare-sort var1557 0)
(declare-sort var3489 0)
(declare-sort var145 0)
(declare-sort var2473 0)
(declare-sort var195 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/38451521 (var1958 var3915 String var2848 var3992 var2850 var3465) void)
(declare-fun cast-from-var1587-to-var1958 (var1587) var1958)
(declare-fun var1557-init () var1557)
(declare-fun <init>/-201242697 (var1557) void)
(declare-fun cast-from-var1557-to-var3489 (var1557) var3489)
(declare-fun methods/1401955396 (var1587) var3489)
(declare-fun var145-init () var145)
(declare-fun <init>/-325640736 (var145) void)
(declare-fun cast-from-var145-to-var2473 (var145) var2473)
(declare-fun serviceUrls/1401955396 (var1587) var2473)
(declare-fun lastInvokeTime/1401955396 (var1587) Int)
(declare-fun var195-init () var195)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var195 String) void)
(declare-const null-var1587 var1587)
(declare-const null-String String)
(declare-const null-var3915 var3915)
(declare-const null-var2848 var2848)
(declare-const null-var2850 var2850)
(declare-const null-var3465 var3465)
(declare-const null-NullType var748)
(declare-const null-var3992 var3992)
(declare-const var3128 var1587) ; Statement: r0 := @this: org.apache.dubbo.rpc.model.ProviderModel 
(assert (not (= var3128 null-var1587)))
(declare-const var2037 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2037 null-String)))
(declare-const var2777 var3915) ; Statement: r1 := @parameter1: java.lang.Object 
(assert (not (= var2777 null-var3915)))
(declare-const var532 var2848) ; Statement: r3 := @parameter2: org.apache.dubbo.rpc.model.ServiceDescriptor 
(assert (not (= var532 null-var2848)))
(declare-const var885 var2850) ; Statement: r4 := @parameter3: org.apache.dubbo.rpc.model.ServiceMetadata 
(assert (not (= var885 null-var2850)))
(declare-const var1096 var3465) ; Statement: r5 := @parameter4: java.lang.ClassLoader 
(assert (not (= var1096 null-var3465)))
(assert true)
;(assert (<init>/38451521 (cast-from-var1587-to-var1958 var3128) var2777 var2037 var532 null-var3992 var885 var1096)) ; Statement: specialinvoke r0.<org.apache.dubbo.rpc.model.ServiceModel: void <init>(java.lang.Object,java.lang.String,org.apache.dubbo.rpc.model.ServiceDescriptor,org.apache.dubbo.rpc.model.ModuleModel,org.apache.dubbo.rpc.model.ServiceMetadata,java.lang.ClassLoader)>(r1, r2, r3, null, r4, r5) 

(declare-const var3128!1 var1587)
(declare-const var2777!1 var3915)
(declare-const var2037!1 String)
(declare-const var532!1 var2848)
(declare-const var367 var748)
(declare-const var885!1 var2850)
(declare-const var1096!1 var3465)
(define-const var1797 var1557 var1557-init) ; Statement: $r6 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var1797)) ; Statement: specialinvoke $r6.<java.util.HashMap: void <init>()>() 

(declare-const var1797!1 var1557)
(declare-const var3128!2 var1587)
(assert (not (= var3128!2 null-var1587)))
(assert (= (methods/1401955396 var3128!2) (cast-from-var1557-to-var3489 var1797!1))) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.Map methods> = $r6 
(define-const var796 var145 var145-init) ; Statement: $r7 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var796)) ; Statement: specialinvoke $r7.<java.util.ArrayList: void <init>()>() 

(declare-const var796!1 var145)
(declare-const var3128!3 var1587)
(assert (not (= var3128!3 null-var1587)))
(assert (= (serviceUrls/1401955396 var3128!3) (cast-from-var145-to-var2473 var796!1))) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.List serviceUrls> = $r7 
(declare-const var3128!4 var1587)
(assert (not (= var3128!4 null-var1587)))
(assert (= (lastInvokeTime/1401955396 var3128!4) 0)) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: long lastInvokeTime> = 0L 
 ; Statement: if null != r1 goto $r8 = interfaceinvoke r3.<org.apache.dubbo.rpc.model.ServiceDescriptor: java.lang.Class getServiceInterfaceClass()>() 
(assert (not (not (= null-var3915 var2777!1)))) ; Negate: Cond: null != r1  
(define-const var2774 var195 var195-init) ; Statement: $r10 = new java.lang.IllegalArgumentException 
(define-const var1007 String String-init) ; Statement: $r11 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1007)) ; Statement: specialinvoke $r11.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1007!1 String)
(assert (= var1007!1 ""))
(assert true)
(define-const var85 String (append/672562846 var1007!1 "Service[")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Service[") 
(declare-const var1007!2 String)
(assert (= var1007!2 (str.++ var1007!1 "Service[")))
(assert true)
(define-const var2111 String (append/672562846 var85 var2037!1)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var85!1 String)
(assert (= var85!1 (str.++ var85 var2037!1)))
(assert true)
(define-const var2660 String (append/672562846 var2111 "]Target is NULL.")) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]Target is NULL.") 
(declare-const var2111!1 String)
(assert (= var2111!1 (str.++ var2111 "]Target is NULL.")))
(assert true)
(define-const var322 String (toString/-2075883882 var2660)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var2774 var322)) ; Statement: specialinvoke $r10.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r15) 

(declare-const var2774!1 var195)
(declare-const var322!1 String)
 ; Statement: throw $r10 
(check-sat)
; {<init>/38451521=([org.apache.dubbo.rpc.model.ServiceModel, java.lang.Object, java.lang.String, org.apache.dubbo.rpc.model.ServiceDescriptor, org.apache.dubbo.rpc.model.ModuleModel, org.apache.dubbo.rpc.model.ServiceMetadata, java.lang.ClassLoader], void), cast-from-var1587-to-var1958=([org.apache.dubbo.rpc.model.ProviderModel], org.apache.dubbo.rpc.model.ServiceModel), var1557-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), cast-from-var1557-to-var3489=([java.util.HashMap], java.util.Map), methods/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], java.util.Map), var145-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), cast-from-var145-to-var2473=([java.util.ArrayList], java.util.List), serviceUrls/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], java.util.List), lastInvokeTime/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], long), var195-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var1587=org.apache.dubbo.rpc.model.ProviderModel, var3128=r0, var2037=r2, var748=null_type, var3915=java.lang.Object, var2777=r1, var2848=org.apache.dubbo.rpc.model.ServiceDescriptor, var532=r3, var2850=org.apache.dubbo.rpc.model.ServiceMetadata, var885=r4, var3465=java.lang.ClassLoader, var1096=r5, var1958=org.apache.dubbo.rpc.model.ServiceModel, var3992=org.apache.dubbo.rpc.model.ModuleModel, var367=null, var1557=java.util.HashMap, var1797=$r6, var3489=java.util.Map, var145=java.util.ArrayList, var796=$r7, var2473=java.util.List, var195=java.lang.IllegalArgumentException, var2774=$r10, var1007=$r11, var85=$r12, var2111=$r13, var2660=$r14, var322=$r15}
; {org.apache.dubbo.rpc.model.ProviderModel=var1587, r0=var3128, r2=var2037, null_type=var748, java.lang.Object=var3915, r1=var2777, org.apache.dubbo.rpc.model.ServiceDescriptor=var2848, r3=var532, org.apache.dubbo.rpc.model.ServiceMetadata=var2850, r4=var885, java.lang.ClassLoader=var3465, r5=var1096, org.apache.dubbo.rpc.model.ServiceModel=var1958, org.apache.dubbo.rpc.model.ModuleModel=var3992, null=var367, java.util.HashMap=var1557, $r6=var1797, java.util.Map=var3489, java.util.ArrayList=var145, $r7=var796, java.util.List=var2473, java.lang.IllegalArgumentException=var195, $r10=var2774, $r11=var1007, $r12=var85, $r13=var2111, $r14=var2660, $r15=var322}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.model.ProviderModel;	r2 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.Object;	r3 := @parameter2: org.apache.dubbo.rpc.model.ServiceDescriptor;	r4 := @parameter3: org.apache.dubbo.rpc.model.ServiceMetadata;	r5 := @parameter4: java.lang.ClassLoader;	specialinvoke r0.<org.apache.dubbo.rpc.model.ServiceModel: void <init>(java.lang.Object,java.lang.String,org.apache.dubbo.rpc.model.ServiceDescriptor,org.apache.dubbo.rpc.model.ModuleModel,org.apache.dubbo.rpc.model.ServiceMetadata,java.lang.ClassLoader)>(r1, r2, r3, null, r4, r5);	$r6 = new java.util.HashMap;	specialinvoke $r6.<java.util.HashMap: void <init>()>();	r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.Map methods> = $r6;	$r7 = new java.util.ArrayList;	specialinvoke $r7.<java.util.ArrayList: void <init>()>();	r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.List serviceUrls> = $r7;	r0.<org.apache.dubbo.rpc.model.ProviderModel: long lastInvokeTime> = 0L;	if null != r1 goto $r8 = interfaceinvoke r3.<org.apache.dubbo.rpc.model.ServiceDescriptor: java.lang.Class getServiceInterfaceClass()>();	$r10 = new java.lang.IllegalArgumentException;	$r11 = new java.lang.StringBuilder;	specialinvoke $r11.<java.lang.StringBuilder: void <init>()>();	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Service[");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]Target is NULL.");	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r10.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r15);	throw $r10
;block_num 2