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

(declare-sort var2558 0)
(declare-sort var3357 0)
(declare-sort var1303 0)
(declare-sort var3267 0)
(declare-sort var2785 0)
(declare-sort var1261 0)
(declare-sort var565 0)
(declare-sort var2466 0)
(declare-sort var3436 0)
(declare-sort var697 0)
(declare-sort var2461 0)
(declare-sort var2913 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/38451521 (var565 var1303 String var3267 var2466 var2785 var1261) void)
(declare-fun cast-from-var2558-to-var565 (var2558) var565)
(declare-fun var3436-init () var3436)
(declare-fun <init>/-201242697 (var3436) void)
(declare-fun cast-from-var3436-to-var697 (var3436) var697)
(declare-fun methods/1401955396 (var2558) var697)
(declare-fun var2461-init () var2461)
(declare-fun <init>/-325640736 (var2461) void)
(declare-fun cast-from-var2461-to-var2913 (var2461) var2913)
(declare-fun serviceUrls/1401955396 (var2558) var2913)
(declare-fun lastInvokeTime/1401955396 (var2558) Int)
(declare-fun var3267_getServiceInterfaceClass/1002592465 (var3267) ClassObject)
(declare-fun initMethod/-1201237592 (var2558 ClassObject) void)
(declare-fun <init>/1228603609 (var2461 Int) void)
(declare-fun urls/1401955396 (var2558) var2913)
(declare-const null-var2558 var2558)
(declare-const null-String String)
(declare-const null-var1303 var1303)
(declare-const null-var3267 var3267)
(declare-const null-var2785 var2785)
(declare-const null-var1261 var1261)
(declare-const null-NullType var3357)
(declare-const null-var2466 var2466)
(declare-const var3246 var2558) ; Statement: r0 := @this: org.apache.dubbo.rpc.model.ProviderModel 
(assert (not (= var3246 null-var2558)))
(declare-const var2851 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2851 null-String)))
(declare-const var2734 var1303) ; Statement: r1 := @parameter1: java.lang.Object 
(assert (not (= var2734 null-var1303)))
(declare-const var510 var3267) ; Statement: r3 := @parameter2: org.apache.dubbo.rpc.model.ServiceDescriptor 
(assert (not (= var510 null-var3267)))
(declare-const var3691 var2785) ; Statement: r4 := @parameter3: org.apache.dubbo.rpc.model.ServiceMetadata 
(assert (not (= var3691 null-var2785)))
(declare-const var464 var1261) ; Statement: r5 := @parameter4: java.lang.ClassLoader 
(assert (not (= var464 null-var1261)))
(assert true)
;(assert (<init>/38451521 (cast-from-var2558-to-var565 var3246) var2734 var2851 var510 null-var2466 var3691 var464)) ; Statement: specialinvoke r0.<org.apache.dubbo.rpc.model.ServiceModel: void <init>(java.lang.Object,java.lang.String,org.apache.dubbo.rpc.model.ServiceDescriptor,org.apache.dubbo.rpc.model.ModuleModel,org.apache.dubbo.rpc.model.ServiceMetadata,java.lang.ClassLoader)>(r1, r2, r3, null, r4, r5) 

(declare-const var3246!1 var2558)
(declare-const var2734!1 var1303)
(declare-const var2851!1 String)
(declare-const var510!1 var3267)
(declare-const var2935 var3357)
(declare-const var3691!1 var2785)
(declare-const var464!1 var1261)
(define-const var1817 var3436 var3436-init) ; Statement: $r6 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var1817)) ; Statement: specialinvoke $r6.<java.util.HashMap: void <init>()>() 

(declare-const var1817!1 var3436)
(declare-const var3246!2 var2558)
(assert (not (= var3246!2 null-var2558)))
(assert (= (methods/1401955396 var3246!2) (cast-from-var3436-to-var697 var1817!1))) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.Map methods> = $r6 
(define-const var1211 var2461 var2461-init) ; Statement: $r7 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var1211)) ; Statement: specialinvoke $r7.<java.util.ArrayList: void <init>()>() 

(declare-const var1211!1 var2461)
(declare-const var3246!3 var2558)
(assert (not (= var3246!3 null-var2558)))
(assert (= (serviceUrls/1401955396 var3246!3) (cast-from-var2461-to-var2913 var1211!1))) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.List serviceUrls> = $r7 
(declare-const var3246!4 var2558)
(assert (not (= var3246!4 null-var2558)))
(assert (= (lastInvokeTime/1401955396 var3246!4) 0)) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: long lastInvokeTime> = 0L 
 ; Statement: if null != r1 goto $r8 = interfaceinvoke r3.<org.apache.dubbo.rpc.model.ServiceDescriptor: java.lang.Class getServiceInterfaceClass()>() 
(assert (not (= null-var1303 var2734!1))) ; Cond: null != r1 
(define-const var3435 ClassObject (var3267_getServiceInterfaceClass/1002592465 var510!1)) ; Statement: $r8 = interfaceinvoke r3.<org.apache.dubbo.rpc.model.ServiceDescriptor: java.lang.Class getServiceInterfaceClass()>() 
(assert true)
;(assert (initMethod/-1201237592 var3246!4 var3435)) ; Statement: specialinvoke r0.<org.apache.dubbo.rpc.model.ProviderModel: void initMethod(java.lang.Class)>($r8) 

(declare-const var3246!5 var2558)
(declare-const var3435!1 ClassObject)
(define-const var1065 var2461 var2461-init) ; Statement: $r9 = new java.util.ArrayList 
(assert true)
;(assert (<init>/1228603609 var1065 1)) ; Statement: specialinvoke $r9.<java.util.ArrayList: void <init>(int)>(1) 

(declare-const var1065!1 var2461)
(declare-const var758 Int)
(declare-const var3246!6 var2558)
(assert (not (= var3246!6 null-var2558)))
(assert (= (urls/1401955396 var3246!6) (cast-from-var2461-to-var2913 var1065!1))) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.List urls> = $r9 
 ; Statement: return 
(check-sat)
; {<init>/38451521=([org.apache.dubbo.rpc.model.ServiceModel, java.lang.Object, java.lang.String, org.apache.dubbo.rpc.model.ServiceDescriptor, org.apache.dubbo.rpc.model.ModuleModel, org.apache.dubbo.rpc.model.ServiceMetadata, java.lang.ClassLoader], void), cast-from-var2558-to-var565=([org.apache.dubbo.rpc.model.ProviderModel], org.apache.dubbo.rpc.model.ServiceModel), var3436-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), cast-from-var3436-to-var697=([java.util.HashMap], java.util.Map), methods/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], java.util.Map), var2461-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), cast-from-var2461-to-var2913=([java.util.ArrayList], java.util.List), serviceUrls/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], java.util.List), lastInvokeTime/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], long), var3267_getServiceInterfaceClass/1002592465=([org.apache.dubbo.rpc.model.ServiceDescriptor], java.lang.Class), initMethod/-1201237592=([org.apache.dubbo.rpc.model.ProviderModel, java.lang.Class], void), <init>/1228603609=([java.util.ArrayList, int], void), urls/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], java.util.List)}
; {var2558=org.apache.dubbo.rpc.model.ProviderModel, var3246=r0, var2851=r2, var3357=null_type, var1303=java.lang.Object, var2734=r1, var3267=org.apache.dubbo.rpc.model.ServiceDescriptor, var510=r3, var2785=org.apache.dubbo.rpc.model.ServiceMetadata, var3691=r4, var1261=java.lang.ClassLoader, var464=r5, var565=org.apache.dubbo.rpc.model.ServiceModel, var2466=org.apache.dubbo.rpc.model.ModuleModel, var2935=null, var3436=java.util.HashMap, var1817=$r6, var697=java.util.Map, var2461=java.util.ArrayList, var1211=$r7, var2913=java.util.List, var3435=$r8, var1065=$r9, var758=1}
; {org.apache.dubbo.rpc.model.ProviderModel=var2558, r0=var3246, r2=var2851, null_type=var3357, java.lang.Object=var1303, r1=var2734, org.apache.dubbo.rpc.model.ServiceDescriptor=var3267, r3=var510, org.apache.dubbo.rpc.model.ServiceMetadata=var2785, r4=var3691, java.lang.ClassLoader=var1261, r5=var464, org.apache.dubbo.rpc.model.ServiceModel=var565, org.apache.dubbo.rpc.model.ModuleModel=var2466, null=var2935, java.util.HashMap=var3436, $r6=var1817, java.util.Map=var697, java.util.ArrayList=var2461, $r7=var1211, java.util.List=var2913, $r8=var3435, $r9=var1065, 1=var758}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.rpc.model.ProviderModel;	r2 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.Object;	r3 := @parameter2: org.apache.dubbo.rpc.model.ServiceDescriptor;	r4 := @parameter3: org.apache.dubbo.rpc.model.ServiceMetadata;	r5 := @parameter4: java.lang.ClassLoader;	specialinvoke r0.<org.apache.dubbo.rpc.model.ServiceModel: void <init>(java.lang.Object,java.lang.String,org.apache.dubbo.rpc.model.ServiceDescriptor,org.apache.dubbo.rpc.model.ModuleModel,org.apache.dubbo.rpc.model.ServiceMetadata,java.lang.ClassLoader)>(r1, r2, r3, null, r4, r5);	$r6 = new java.util.HashMap;	specialinvoke $r6.<java.util.HashMap: void <init>()>();	r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.Map methods> = $r6;	$r7 = new java.util.ArrayList;	specialinvoke $r7.<java.util.ArrayList: void <init>()>();	r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.List serviceUrls> = $r7;	r0.<org.apache.dubbo.rpc.model.ProviderModel: long lastInvokeTime> = 0L;	if null != r1 goto $r8 = interfaceinvoke r3.<org.apache.dubbo.rpc.model.ServiceDescriptor: java.lang.Class getServiceInterfaceClass()>();	$r8 = interfaceinvoke r3.<org.apache.dubbo.rpc.model.ServiceDescriptor: java.lang.Class getServiceInterfaceClass()>();	specialinvoke r0.<org.apache.dubbo.rpc.model.ProviderModel: void initMethod(java.lang.Class)>($r8);	$r9 = new java.util.ArrayList;	specialinvoke $r9.<java.util.ArrayList: void <init>(int)>(1);	r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.List urls> = $r9;	return
;block_num 2