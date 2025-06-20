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

(declare-sort var1686 0)
(declare-sort var2727 0)
(declare-sort var872 0)
(declare-sort var1624 0)
(declare-sort var3627 0)
(declare-sort var541 0)
(declare-sort var2465 0)
(declare-sort var2324 0)
(declare-sort var1488 0)
(declare-sort var1196 0)
(declare-sort var1092 0)
(declare-sort var3916 0)
(declare-sort var1630 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/38451521 (var2324 var872 String var1624 var3627 var541 var2465) void)
(declare-fun cast-from-var1686-to-var2324 (var1686) var2324)
(declare-fun var1488-init () var1488)
(declare-fun <init>/-201242697 (var1488) void)
(declare-fun cast-from-var1488-to-var1196 (var1488) var1196)
(declare-fun methods/1401955396 (var1686) var1196)
(declare-fun var1092-init () var1092)
(declare-fun <init>/-325640736 (var1092) void)
(declare-fun cast-from-var1092-to-var3916 (var1092) var3916)
(declare-fun serviceUrls/1401955396 (var1686) var3916)
(declare-fun lastInvokeTime/1401955396 (var1686) Int)
(declare-fun var1630-init () var1630)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var1630 String) void)
(declare-const null-var1686 var1686)
(declare-const null-String String)
(declare-const null-var872 var872)
(declare-const null-var1624 var1624)
(declare-const null-var3627 var3627)
(declare-const null-var541 var541)
(declare-const null-var2465 var2465)
(declare-const var3369 var1686) ; Statement: r0 := @this: org.apache.dubbo.rpc.model.ProviderModel 
(assert (not (= var3369 null-var1686)))
(declare-const var2 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2 null-String)))
(declare-const var2919 var872) ; Statement: r1 := @parameter1: java.lang.Object 
(assert (not (= var2919 null-var872)))
(declare-const var1523 var1624) ; Statement: r3 := @parameter2: org.apache.dubbo.rpc.model.ServiceDescriptor 
(assert (not (= var1523 null-var1624)))
(declare-const var613 var3627) ; Statement: r4 := @parameter3: org.apache.dubbo.rpc.model.ModuleModel 
(assert (not (= var613 null-var3627)))
(declare-const var55 var541) ; Statement: r5 := @parameter4: org.apache.dubbo.rpc.model.ServiceMetadata 
(assert (not (= var55 null-var541)))
(declare-const var1429 var2465) ; Statement: r6 := @parameter5: java.lang.ClassLoader 
(assert (not (= var1429 null-var2465)))
(assert true)
;(assert (<init>/38451521 (cast-from-var1686-to-var2324 var3369) var2919 var2 var1523 var613 var55 var1429)) ; Statement: specialinvoke r0.<org.apache.dubbo.rpc.model.ServiceModel: void <init>(java.lang.Object,java.lang.String,org.apache.dubbo.rpc.model.ServiceDescriptor,org.apache.dubbo.rpc.model.ModuleModel,org.apache.dubbo.rpc.model.ServiceMetadata,java.lang.ClassLoader)>(r1, r2, r3, r4, r5, r6) 

(declare-const var3369!1 var1686)
(declare-const var2919!1 var872)
(declare-const var2!1 String)
(declare-const var1523!1 var1624)
(declare-const var613!1 var3627)
(declare-const var55!1 var541)
(declare-const var1429!1 var2465)
(define-const var2821 var1488 var1488-init) ; Statement: $r7 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var2821)) ; Statement: specialinvoke $r7.<java.util.HashMap: void <init>()>() 

(declare-const var2821!1 var1488)
(declare-const var3369!2 var1686)
(assert (not (= var3369!2 null-var1686)))
(assert (= (methods/1401955396 var3369!2) (cast-from-var1488-to-var1196 var2821!1))) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.Map methods> = $r7 
(define-const var2134 var1092 var1092-init) ; Statement: $r8 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2134)) ; Statement: specialinvoke $r8.<java.util.ArrayList: void <init>()>() 

(declare-const var2134!1 var1092)
(declare-const var3369!3 var1686)
(assert (not (= var3369!3 null-var1686)))
(assert (= (serviceUrls/1401955396 var3369!3) (cast-from-var1092-to-var3916 var2134!1))) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.List serviceUrls> = $r8 
(declare-const var3369!4 var1686)
(assert (not (= var3369!4 null-var1686)))
(assert (= (lastInvokeTime/1401955396 var3369!4) 0)) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: long lastInvokeTime> = 0L 
 ; Statement: if null != r1 goto $r9 = interfaceinvoke r3.<org.apache.dubbo.rpc.model.ServiceDescriptor: java.lang.Class getServiceInterfaceClass()>() 
(assert (not (not (= null-var872 var2919!1)))) ; Negate: Cond: null != r1  
(define-const var3016 var1630 var1630-init) ; Statement: $r11 = new java.lang.IllegalArgumentException 
(define-const var260 String String-init) ; Statement: $r12 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var260)) ; Statement: specialinvoke $r12.<java.lang.StringBuilder: void <init>()>() 
(declare-const var260!1 String)
(assert (= var260!1 ""))
(assert true)
(define-const var1939 String (append/672562846 var260!1 "Service[")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Service[") 
(declare-const var260!2 String)
(assert (= var260!2 (str.++ var260!1 "Service[")))
(assert true)
(define-const var2902 String (append/672562846 var1939 var2!1)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var1939!1 String)
(assert (= var1939!1 (str.++ var1939 var2!1)))
(assert true)
(define-const var44 String (append/672562846 var2902 "]Target is NULL.")) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]Target is NULL.") 
(declare-const var2902!1 String)
(assert (= var2902!1 (str.++ var2902 "]Target is NULL.")))
(assert true)
(define-const var2820 String (toString/-2075883882 var44)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var3016 var2820)) ; Statement: specialinvoke $r11.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r16) 

(declare-const var3016!1 var1630)
(declare-const var2820!1 String)
 ; Statement: throw $r11 
(check-sat)
; {<init>/38451521=([org.apache.dubbo.rpc.model.ServiceModel, java.lang.Object, java.lang.String, org.apache.dubbo.rpc.model.ServiceDescriptor, org.apache.dubbo.rpc.model.ModuleModel, org.apache.dubbo.rpc.model.ServiceMetadata, java.lang.ClassLoader], void), cast-from-var1686-to-var2324=([org.apache.dubbo.rpc.model.ProviderModel], org.apache.dubbo.rpc.model.ServiceModel), var1488-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), cast-from-var1488-to-var1196=([java.util.HashMap], java.util.Map), methods/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], java.util.Map), var1092-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), cast-from-var1092-to-var3916=([java.util.ArrayList], java.util.List), serviceUrls/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], java.util.List), lastInvokeTime/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], long), var1630-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var1686=org.apache.dubbo.rpc.model.ProviderModel, var3369=r0, var2=r2, var2727=null_type, var872=java.lang.Object, var2919=r1, var1624=org.apache.dubbo.rpc.model.ServiceDescriptor, var1523=r3, var3627=org.apache.dubbo.rpc.model.ModuleModel, var613=r4, var541=org.apache.dubbo.rpc.model.ServiceMetadata, var55=r5, var2465=java.lang.ClassLoader, var1429=r6, var2324=org.apache.dubbo.rpc.model.ServiceModel, var1488=java.util.HashMap, var2821=$r7, var1196=java.util.Map, var1092=java.util.ArrayList, var2134=$r8, var3916=java.util.List, var1630=java.lang.IllegalArgumentException, var3016=$r11, var260=$r12, var1939=$r13, var2902=$r14, var44=$r15, var2820=$r16}
; {org.apache.dubbo.rpc.model.ProviderModel=var1686, r0=var3369, r2=var2, null_type=var2727, java.lang.Object=var872, r1=var2919, org.apache.dubbo.rpc.model.ServiceDescriptor=var1624, r3=var1523, org.apache.dubbo.rpc.model.ModuleModel=var3627, r4=var613, org.apache.dubbo.rpc.model.ServiceMetadata=var541, r5=var55, java.lang.ClassLoader=var2465, r6=var1429, org.apache.dubbo.rpc.model.ServiceModel=var2324, java.util.HashMap=var1488, $r7=var2821, java.util.Map=var1196, java.util.ArrayList=var1092, $r8=var2134, java.util.List=var3916, java.lang.IllegalArgumentException=var1630, $r11=var3016, $r12=var260, $r13=var1939, $r14=var2902, $r15=var44, $r16=var2820}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.model.ProviderModel;	r2 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.Object;	r3 := @parameter2: org.apache.dubbo.rpc.model.ServiceDescriptor;	r4 := @parameter3: org.apache.dubbo.rpc.model.ModuleModel;	r5 := @parameter4: org.apache.dubbo.rpc.model.ServiceMetadata;	r6 := @parameter5: java.lang.ClassLoader;	specialinvoke r0.<org.apache.dubbo.rpc.model.ServiceModel: void <init>(java.lang.Object,java.lang.String,org.apache.dubbo.rpc.model.ServiceDescriptor,org.apache.dubbo.rpc.model.ModuleModel,org.apache.dubbo.rpc.model.ServiceMetadata,java.lang.ClassLoader)>(r1, r2, r3, r4, r5, r6);	$r7 = new java.util.HashMap;	specialinvoke $r7.<java.util.HashMap: void <init>()>();	r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.Map methods> = $r7;	$r8 = new java.util.ArrayList;	specialinvoke $r8.<java.util.ArrayList: void <init>()>();	r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.List serviceUrls> = $r8;	r0.<org.apache.dubbo.rpc.model.ProviderModel: long lastInvokeTime> = 0L;	if null != r1 goto $r9 = interfaceinvoke r3.<org.apache.dubbo.rpc.model.ServiceDescriptor: java.lang.Class getServiceInterfaceClass()>();	$r11 = new java.lang.IllegalArgumentException;	$r12 = new java.lang.StringBuilder;	specialinvoke $r12.<java.lang.StringBuilder: void <init>()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Service[");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]Target is NULL.");	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r11.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r16);	throw $r11
;block_num 2