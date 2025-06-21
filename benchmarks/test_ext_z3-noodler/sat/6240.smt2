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

(declare-sort var940 0)
(declare-sort var250 0)
(declare-sort var3531 0)
(declare-sort var1900 0)
(declare-sort var3602 0)
(declare-sort var637 0)
(declare-sort var3224 0)
(declare-sort var3265 0)
(declare-sort var3776 0)
(declare-sort var3380 0)
(declare-sort var2355 0)
(declare-sort var2626 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/38451521 (var3265 var3531 String var1900 var3602 var637 var3224) void)
(declare-fun cast-from-var940-to-var3265 (var940) var3265)
(declare-fun var3776-init () var3776)
(declare-fun <init>/-201242697 (var3776) void)
(declare-fun cast-from-var3776-to-var3380 (var3776) var3380)
(declare-fun methods/1401955396 (var940) var3380)
(declare-fun var2355-init () var2355)
(declare-fun <init>/-325640736 (var2355) void)
(declare-fun cast-from-var2355-to-var2626 (var2355) var2626)
(declare-fun serviceUrls/1401955396 (var940) var2626)
(declare-fun lastInvokeTime/1401955396 (var940) Int)
(declare-fun var1900_getServiceInterfaceClass/1002592465 (var1900) ClassObject)
(declare-fun initMethod/-1201237592 (var940 ClassObject) void)
(declare-fun <init>/1228603609 (var2355 Int) void)
(declare-fun urls/1401955396 (var940) var2626)
(declare-const null-var940 var940)
(declare-const null-String String)
(declare-const null-var3531 var3531)
(declare-const null-var1900 var1900)
(declare-const null-var3602 var3602)
(declare-const null-var637 var637)
(declare-const null-var3224 var3224)
(declare-const var1887 var940) ; Statement: r0 := @this: org.apache.dubbo.rpc.model.ProviderModel 
(assert (not (= var1887 null-var940)))
(declare-const var3090 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var3090 null-String)))
(declare-const var2501 var3531) ; Statement: r1 := @parameter1: java.lang.Object 
(assert (not (= var2501 null-var3531)))
(declare-const var1313 var1900) ; Statement: r3 := @parameter2: org.apache.dubbo.rpc.model.ServiceDescriptor 
(assert (not (= var1313 null-var1900)))
(declare-const var3447 var3602) ; Statement: r4 := @parameter3: org.apache.dubbo.rpc.model.ModuleModel 
(assert (not (= var3447 null-var3602)))
(declare-const var1083 var637) ; Statement: r5 := @parameter4: org.apache.dubbo.rpc.model.ServiceMetadata 
(assert (not (= var1083 null-var637)))
(declare-const var3465 var3224) ; Statement: r6 := @parameter5: java.lang.ClassLoader 
(assert (not (= var3465 null-var3224)))
(assert true)
;(assert (<init>/38451521 (cast-from-var940-to-var3265 var1887) var2501 var3090 var1313 var3447 var1083 var3465)) ; Statement: specialinvoke r0.<org.apache.dubbo.rpc.model.ServiceModel: void <init>(java.lang.Object,java.lang.String,org.apache.dubbo.rpc.model.ServiceDescriptor,org.apache.dubbo.rpc.model.ModuleModel,org.apache.dubbo.rpc.model.ServiceMetadata,java.lang.ClassLoader)>(r1, r2, r3, r4, r5, r6) 

(declare-const var1887!1 var940)
(declare-const var2501!1 var3531)
(declare-const var3090!1 String)
(declare-const var1313!1 var1900)
(declare-const var3447!1 var3602)
(declare-const var1083!1 var637)
(declare-const var3465!1 var3224)
(define-const var2099 var3776 var3776-init) ; Statement: $r7 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var2099)) ; Statement: specialinvoke $r7.<java.util.HashMap: void <init>()>() 

(declare-const var2099!1 var3776)
(declare-const var1887!2 var940)
(assert (not (= var1887!2 null-var940)))
(assert (= (methods/1401955396 var1887!2) (cast-from-var3776-to-var3380 var2099!1))) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.Map methods> = $r7 
(define-const var962 var2355 var2355-init) ; Statement: $r8 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var962)) ; Statement: specialinvoke $r8.<java.util.ArrayList: void <init>()>() 

(declare-const var962!1 var2355)
(declare-const var1887!3 var940)
(assert (not (= var1887!3 null-var940)))
(assert (= (serviceUrls/1401955396 var1887!3) (cast-from-var2355-to-var2626 var962!1))) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.List serviceUrls> = $r8 
(declare-const var1887!4 var940)
(assert (not (= var1887!4 null-var940)))
(assert (= (lastInvokeTime/1401955396 var1887!4) 0)) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: long lastInvokeTime> = 0L 
 ; Statement: if null != r1 goto $r9 = interfaceinvoke r3.<org.apache.dubbo.rpc.model.ServiceDescriptor: java.lang.Class getServiceInterfaceClass()>() 
(assert (not (= null-var3531 var2501!1))) ; Cond: null != r1 
(define-const var2163 ClassObject (var1900_getServiceInterfaceClass/1002592465 var1313!1)) ; Statement: $r9 = interfaceinvoke r3.<org.apache.dubbo.rpc.model.ServiceDescriptor: java.lang.Class getServiceInterfaceClass()>() 
(assert true)
;(assert (initMethod/-1201237592 var1887!4 var2163)) ; Statement: specialinvoke r0.<org.apache.dubbo.rpc.model.ProviderModel: void initMethod(java.lang.Class)>($r9) 

(declare-const var1887!5 var940)
(declare-const var2163!1 ClassObject)
(define-const var3787 var2355 var2355-init) ; Statement: $r10 = new java.util.ArrayList 
(assert true)
;(assert (<init>/1228603609 var3787 1)) ; Statement: specialinvoke $r10.<java.util.ArrayList: void <init>(int)>(1) 

(declare-const var3787!1 var2355)
(declare-const var3084 Int)
(declare-const var1887!6 var940)
(assert (not (= var1887!6 null-var940)))
(assert (= (urls/1401955396 var1887!6) (cast-from-var2355-to-var2626 var3787!1))) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.List urls> = $r10 
 ; Statement: return 
(check-sat)
; {<init>/38451521=([org.apache.dubbo.rpc.model.ServiceModel, java.lang.Object, java.lang.String, org.apache.dubbo.rpc.model.ServiceDescriptor, org.apache.dubbo.rpc.model.ModuleModel, org.apache.dubbo.rpc.model.ServiceMetadata, java.lang.ClassLoader], void), cast-from-var940-to-var3265=([org.apache.dubbo.rpc.model.ProviderModel], org.apache.dubbo.rpc.model.ServiceModel), var3776-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), cast-from-var3776-to-var3380=([java.util.HashMap], java.util.Map), methods/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], java.util.Map), var2355-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), cast-from-var2355-to-var2626=([java.util.ArrayList], java.util.List), serviceUrls/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], java.util.List), lastInvokeTime/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], long), var1900_getServiceInterfaceClass/1002592465=([org.apache.dubbo.rpc.model.ServiceDescriptor], java.lang.Class), initMethod/-1201237592=([org.apache.dubbo.rpc.model.ProviderModel, java.lang.Class], void), <init>/1228603609=([java.util.ArrayList, int], void), urls/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], java.util.List)}
; {var940=org.apache.dubbo.rpc.model.ProviderModel, var1887=r0, var3090=r2, var250=null_type, var3531=java.lang.Object, var2501=r1, var1900=org.apache.dubbo.rpc.model.ServiceDescriptor, var1313=r3, var3602=org.apache.dubbo.rpc.model.ModuleModel, var3447=r4, var637=org.apache.dubbo.rpc.model.ServiceMetadata, var1083=r5, var3224=java.lang.ClassLoader, var3465=r6, var3265=org.apache.dubbo.rpc.model.ServiceModel, var3776=java.util.HashMap, var2099=$r7, var3380=java.util.Map, var2355=java.util.ArrayList, var962=$r8, var2626=java.util.List, var2163=$r9, var3787=$r10, var3084=1}
; {org.apache.dubbo.rpc.model.ProviderModel=var940, r0=var1887, r2=var3090, null_type=var250, java.lang.Object=var3531, r1=var2501, org.apache.dubbo.rpc.model.ServiceDescriptor=var1900, r3=var1313, org.apache.dubbo.rpc.model.ModuleModel=var3602, r4=var3447, org.apache.dubbo.rpc.model.ServiceMetadata=var637, r5=var1083, java.lang.ClassLoader=var3224, r6=var3465, org.apache.dubbo.rpc.model.ServiceModel=var3265, java.util.HashMap=var3776, $r7=var2099, java.util.Map=var3380, java.util.ArrayList=var2355, $r8=var962, java.util.List=var2626, $r9=var2163, $r10=var3787, 1=var3084}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.rpc.model.ProviderModel;	r2 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.Object;	r3 := @parameter2: org.apache.dubbo.rpc.model.ServiceDescriptor;	r4 := @parameter3: org.apache.dubbo.rpc.model.ModuleModel;	r5 := @parameter4: org.apache.dubbo.rpc.model.ServiceMetadata;	r6 := @parameter5: java.lang.ClassLoader;	specialinvoke r0.<org.apache.dubbo.rpc.model.ServiceModel: void <init>(java.lang.Object,java.lang.String,org.apache.dubbo.rpc.model.ServiceDescriptor,org.apache.dubbo.rpc.model.ModuleModel,org.apache.dubbo.rpc.model.ServiceMetadata,java.lang.ClassLoader)>(r1, r2, r3, r4, r5, r6);	$r7 = new java.util.HashMap;	specialinvoke $r7.<java.util.HashMap: void <init>()>();	r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.Map methods> = $r7;	$r8 = new java.util.ArrayList;	specialinvoke $r8.<java.util.ArrayList: void <init>()>();	r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.List serviceUrls> = $r8;	r0.<org.apache.dubbo.rpc.model.ProviderModel: long lastInvokeTime> = 0L;	if null != r1 goto $r9 = interfaceinvoke r3.<org.apache.dubbo.rpc.model.ServiceDescriptor: java.lang.Class getServiceInterfaceClass()>();	$r9 = interfaceinvoke r3.<org.apache.dubbo.rpc.model.ServiceDescriptor: java.lang.Class getServiceInterfaceClass()>();	specialinvoke r0.<org.apache.dubbo.rpc.model.ProviderModel: void initMethod(java.lang.Class)>($r9);	$r10 = new java.util.ArrayList;	specialinvoke $r10.<java.util.ArrayList: void <init>(int)>(1);	r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.List urls> = $r10;	return
;block_num 2