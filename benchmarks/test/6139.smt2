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

(declare-sort var3230 0)
(declare-sort var3312 0)
(declare-sort var1714 0)
(declare-sort var428 0)
(declare-sort var2722 0)
(declare-sort var2481 0)
(declare-sort var2615 0)
(declare-sort var3728 0)
(declare-sort var124 0)
(declare-sort var2244 0)
(declare-sort var2010 0)
(declare-sort var2772 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-1466397989 (var2481 var1714 String var428 var2615 var2722) void)
(declare-fun cast-from-var3230-to-var2481 (var3230) var2481)
(declare-fun var3728-init () var3728)
(declare-fun <init>/-201242697 (var3728) void)
(declare-fun cast-from-var3728-to-var124 (var3728) var124)
(declare-fun methods/1401955396 (var3230) var124)
(declare-fun var2244-init () var2244)
(declare-fun <init>/-325640736 (var2244) void)
(declare-fun cast-from-var2244-to-var2010 (var2244) var2010)
(declare-fun serviceUrls/1401955396 (var3230) var2010)
(declare-fun lastInvokeTime/1401955396 (var3230) Int)
(declare-fun var2772-init () var2772)
(declare-fun <init>/-1826010324 (var2772) void)
(declare-fun cast-from-var2772-to-var2010 (var2772) var2010)
(declare-fun urls/1401955396 (var3230) var2010)
(declare-const null-var3230 var3230)
(declare-const null-String String)
(declare-const null-var1714 var1714)
(declare-const null-var428 var428)
(declare-const null-var2722 var2722)
(declare-const null-NullType var3312)
(declare-const null-var2615 var2615)
(declare-const var1068 var3230) ; Statement: r0 := @this: org.apache.dubbo.rpc.model.ProviderModel 
(assert (not (= var1068 null-var3230)))
(declare-const var1110 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1110 null-String)))
(declare-const var1634 var1714) ; Statement: r1 := @parameter1: java.lang.Object 
(assert (not (= var1634 null-var1714)))
(declare-const var1956 var428) ; Statement: r3 := @parameter2: org.apache.dubbo.rpc.model.ServiceDescriptor 
(assert (not (= var1956 null-var428)))
(declare-const var2314 var2722) ; Statement: r4 := @parameter3: java.lang.ClassLoader 
(assert (not (= var2314 null-var2722)))
(assert true)
;(assert (<init>/-1466397989 (cast-from-var3230-to-var2481 var1068) var1634 var1110 var1956 null-var2615 var2314)) ; Statement: specialinvoke r0.<org.apache.dubbo.rpc.model.ServiceModel: void <init>(java.lang.Object,java.lang.String,org.apache.dubbo.rpc.model.ServiceDescriptor,org.apache.dubbo.rpc.model.ModuleModel,java.lang.ClassLoader)>(r1, r2, r3, null, r4) 

(declare-const var1068!1 var3230)
(declare-const var1634!1 var1714)
(declare-const var1110!1 String)
(declare-const var1956!1 var428)
(declare-const var3183 var3312)
(declare-const var2314!1 var2722)
(define-const var875 var3728 var3728-init) ; Statement: $r5 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var875)) ; Statement: specialinvoke $r5.<java.util.HashMap: void <init>()>() 

(declare-const var875!1 var3728)
(declare-const var1068!2 var3230)
(assert (not (= var1068!2 null-var3230)))
(assert (= (methods/1401955396 var1068!2) (cast-from-var3728-to-var124 var875!1))) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.Map methods> = $r5 
(define-const var3177 var2244 var2244-init) ; Statement: $r6 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var3177)) ; Statement: specialinvoke $r6.<java.util.ArrayList: void <init>()>() 

(declare-const var3177!1 var2244)
(declare-const var1068!3 var3230)
(assert (not (= var1068!3 null-var3230)))
(assert (= (serviceUrls/1401955396 var1068!3) (cast-from-var2244-to-var2010 var3177!1))) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.List serviceUrls> = $r6 
(declare-const var1068!4 var3230)
(assert (not (= var1068!4 null-var3230)))
(assert (= (lastInvokeTime/1401955396 var1068!4) 0)) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: long lastInvokeTime> = 0L 
 ; Statement: if null != r1 goto $r7 = new java.util.concurrent.CopyOnWriteArrayList 
(assert (not (= null-var1714 var1634!1))) ; Cond: null != r1 
(define-const var3257 var2772 var2772-init) ; Statement: $r7 = new java.util.concurrent.CopyOnWriteArrayList 
(assert true)
;(assert (<init>/-1826010324 var3257)) ; Statement: specialinvoke $r7.<java.util.concurrent.CopyOnWriteArrayList: void <init>()>() 

(declare-const var3257!1 var2772)
(declare-const var1068!5 var3230)
(assert (not (= var1068!5 null-var3230)))
(assert (= (urls/1401955396 var1068!5) (cast-from-var2772-to-var2010 var3257!1))) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.List urls> = $r7 
 ; Statement: return 
(check-sat)
; {<init>/-1466397989=([org.apache.dubbo.rpc.model.ServiceModel, java.lang.Object, java.lang.String, org.apache.dubbo.rpc.model.ServiceDescriptor, org.apache.dubbo.rpc.model.ModuleModel, java.lang.ClassLoader], void), cast-from-var3230-to-var2481=([org.apache.dubbo.rpc.model.ProviderModel], org.apache.dubbo.rpc.model.ServiceModel), var3728-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), cast-from-var3728-to-var124=([java.util.HashMap], java.util.Map), methods/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], java.util.Map), var2244-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), cast-from-var2244-to-var2010=([java.util.ArrayList], java.util.List), serviceUrls/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], java.util.List), lastInvokeTime/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], long), var2772-init=([], java.util.concurrent.CopyOnWriteArrayList), <init>/-1826010324=([java.util.concurrent.CopyOnWriteArrayList], void), cast-from-var2772-to-var2010=([java.util.concurrent.CopyOnWriteArrayList], java.util.List), urls/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], java.util.List)}
; {var3230=org.apache.dubbo.rpc.model.ProviderModel, var1068=r0, var1110=r2, var3312=null_type, var1714=java.lang.Object, var1634=r1, var428=org.apache.dubbo.rpc.model.ServiceDescriptor, var1956=r3, var2722=java.lang.ClassLoader, var2314=r4, var2481=org.apache.dubbo.rpc.model.ServiceModel, var2615=org.apache.dubbo.rpc.model.ModuleModel, var3183=null, var3728=java.util.HashMap, var875=$r5, var124=java.util.Map, var2244=java.util.ArrayList, var3177=$r6, var2010=java.util.List, var2772=java.util.concurrent.CopyOnWriteArrayList, var3257=$r7}
; {org.apache.dubbo.rpc.model.ProviderModel=var3230, r0=var1068, r2=var1110, null_type=var3312, java.lang.Object=var1714, r1=var1634, org.apache.dubbo.rpc.model.ServiceDescriptor=var428, r3=var1956, java.lang.ClassLoader=var2722, r4=var2314, org.apache.dubbo.rpc.model.ServiceModel=var2481, org.apache.dubbo.rpc.model.ModuleModel=var2615, null=var3183, java.util.HashMap=var3728, $r5=var875, java.util.Map=var124, java.util.ArrayList=var2244, $r6=var3177, java.util.List=var2010, java.util.concurrent.CopyOnWriteArrayList=var2772, $r7=var3257}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.rpc.model.ProviderModel;	r2 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.Object;	r3 := @parameter2: org.apache.dubbo.rpc.model.ServiceDescriptor;	r4 := @parameter3: java.lang.ClassLoader;	specialinvoke r0.<org.apache.dubbo.rpc.model.ServiceModel: void <init>(java.lang.Object,java.lang.String,org.apache.dubbo.rpc.model.ServiceDescriptor,org.apache.dubbo.rpc.model.ModuleModel,java.lang.ClassLoader)>(r1, r2, r3, null, r4);	$r5 = new java.util.HashMap;	specialinvoke $r5.<java.util.HashMap: void <init>()>();	r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.Map methods> = $r5;	$r6 = new java.util.ArrayList;	specialinvoke $r6.<java.util.ArrayList: void <init>()>();	r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.List serviceUrls> = $r6;	r0.<org.apache.dubbo.rpc.model.ProviderModel: long lastInvokeTime> = 0L;	if null != r1 goto $r7 = new java.util.concurrent.CopyOnWriteArrayList;	$r7 = new java.util.concurrent.CopyOnWriteArrayList;	specialinvoke $r7.<java.util.concurrent.CopyOnWriteArrayList: void <init>()>();	r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.List urls> = $r7;	return
;block_num 2