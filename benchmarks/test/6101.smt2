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

(declare-sort var1788 0)
(declare-sort var3609 0)
(declare-sort var3273 0)
(declare-sort var670 0)
(declare-sort var3497 0)
(declare-sort var2149 0)
(declare-sort var3005 0)
(declare-sort var2547 0)
(declare-sort var3746 0)
(declare-sort var277 0)
(declare-sort var2618 0)
(declare-sort var1757 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-1466397989 (var2149 var3273 String var670 var3005 var3497) void)
(declare-fun cast-from-var1788-to-var2149 (var1788) var2149)
(declare-fun var2547-init () var2547)
(declare-fun <init>/-201242697 (var2547) void)
(declare-fun cast-from-var2547-to-var3746 (var2547) var3746)
(declare-fun methods/1401955396 (var1788) var3746)
(declare-fun var277-init () var277)
(declare-fun <init>/-325640736 (var277) void)
(declare-fun cast-from-var277-to-var2618 (var277) var2618)
(declare-fun serviceUrls/1401955396 (var1788) var2618)
(declare-fun lastInvokeTime/1401955396 (var1788) Int)
(declare-fun var1757-init () var1757)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var1757 String) void)
(declare-const null-var1788 var1788)
(declare-const null-String String)
(declare-const null-var3273 var3273)
(declare-const null-var670 var670)
(declare-const null-var3497 var3497)
(declare-const null-NullType var3609)
(declare-const null-var3005 var3005)
(declare-const var3824 var1788) ; Statement: r0 := @this: org.apache.dubbo.rpc.model.ProviderModel 
(assert (not (= var3824 null-var1788)))
(declare-const var3179 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var3179 null-String)))
(declare-const var3035 var3273) ; Statement: r1 := @parameter1: java.lang.Object 
(assert (not (= var3035 null-var3273)))
(declare-const var3895 var670) ; Statement: r3 := @parameter2: org.apache.dubbo.rpc.model.ServiceDescriptor 
(assert (not (= var3895 null-var670)))
(declare-const var655 var3497) ; Statement: r4 := @parameter3: java.lang.ClassLoader 
(assert (not (= var655 null-var3497)))
(assert true)
;(assert (<init>/-1466397989 (cast-from-var1788-to-var2149 var3824) var3035 var3179 var3895 null-var3005 var655)) ; Statement: specialinvoke r0.<org.apache.dubbo.rpc.model.ServiceModel: void <init>(java.lang.Object,java.lang.String,org.apache.dubbo.rpc.model.ServiceDescriptor,org.apache.dubbo.rpc.model.ModuleModel,java.lang.ClassLoader)>(r1, r2, r3, null, r4) 

(declare-const var3824!1 var1788)
(declare-const var3035!1 var3273)
(declare-const var3179!1 String)
(declare-const var3895!1 var670)
(declare-const var1745 var3609)
(declare-const var655!1 var3497)
(define-const var2874 var2547 var2547-init) ; Statement: $r5 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var2874)) ; Statement: specialinvoke $r5.<java.util.HashMap: void <init>()>() 

(declare-const var2874!1 var2547)
(declare-const var3824!2 var1788)
(assert (not (= var3824!2 null-var1788)))
(assert (= (methods/1401955396 var3824!2) (cast-from-var2547-to-var3746 var2874!1))) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.Map methods> = $r5 
(define-const var2128 var277 var277-init) ; Statement: $r6 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2128)) ; Statement: specialinvoke $r6.<java.util.ArrayList: void <init>()>() 

(declare-const var2128!1 var277)
(declare-const var3824!3 var1788)
(assert (not (= var3824!3 null-var1788)))
(assert (= (serviceUrls/1401955396 var3824!3) (cast-from-var277-to-var2618 var2128!1))) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.List serviceUrls> = $r6 
(declare-const var3824!4 var1788)
(assert (not (= var3824!4 null-var1788)))
(assert (= (lastInvokeTime/1401955396 var3824!4) 0)) ; Statement: r0.<org.apache.dubbo.rpc.model.ProviderModel: long lastInvokeTime> = 0L 
 ; Statement: if null != r1 goto $r7 = new java.util.concurrent.CopyOnWriteArrayList 
(assert (not (not (= null-var3273 var3035!1)))) ; Negate: Cond: null != r1  
(define-const var3743 var1757 var1757-init) ; Statement: $r8 = new java.lang.IllegalArgumentException 
(define-const var2167 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2167)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2167!1 String)
(assert (= var2167!1 ""))
(assert true)
(define-const var1989 String (append/672562846 var2167!1 "Service[")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Service[") 
(declare-const var2167!2 String)
(assert (= var2167!2 (str.++ var2167!1 "Service[")))
(assert true)
(define-const var2265 String (append/672562846 var1989 var3179!1)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var1989!1 String)
(assert (= var1989!1 (str.++ var1989 var3179!1)))
(assert true)
(define-const var1380 String (append/672562846 var2265 "]Target is NULL.")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]Target is NULL.") 
(declare-const var2265!1 String)
(assert (= var2265!1 (str.++ var2265 "]Target is NULL.")))
(assert true)
(define-const var926 String (toString/-2075883882 var1380)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var3743 var926)) ; Statement: specialinvoke $r8.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r13) 

(declare-const var3743!1 var1757)
(declare-const var926!1 String)
 ; Statement: throw $r8 
(check-sat)
; {<init>/-1466397989=([org.apache.dubbo.rpc.model.ServiceModel, java.lang.Object, java.lang.String, org.apache.dubbo.rpc.model.ServiceDescriptor, org.apache.dubbo.rpc.model.ModuleModel, java.lang.ClassLoader], void), cast-from-var1788-to-var2149=([org.apache.dubbo.rpc.model.ProviderModel], org.apache.dubbo.rpc.model.ServiceModel), var2547-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), cast-from-var2547-to-var3746=([java.util.HashMap], java.util.Map), methods/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], java.util.Map), var277-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), cast-from-var277-to-var2618=([java.util.ArrayList], java.util.List), serviceUrls/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], java.util.List), lastInvokeTime/1401955396=([org.apache.dubbo.rpc.model.ProviderModel], long), var1757-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var1788=org.apache.dubbo.rpc.model.ProviderModel, var3824=r0, var3179=r2, var3609=null_type, var3273=java.lang.Object, var3035=r1, var670=org.apache.dubbo.rpc.model.ServiceDescriptor, var3895=r3, var3497=java.lang.ClassLoader, var655=r4, var2149=org.apache.dubbo.rpc.model.ServiceModel, var3005=org.apache.dubbo.rpc.model.ModuleModel, var1745=null, var2547=java.util.HashMap, var2874=$r5, var3746=java.util.Map, var277=java.util.ArrayList, var2128=$r6, var2618=java.util.List, var1757=java.lang.IllegalArgumentException, var3743=$r8, var2167=$r9, var1989=$r10, var2265=$r11, var1380=$r12, var926=$r13}
; {org.apache.dubbo.rpc.model.ProviderModel=var1788, r0=var3824, r2=var3179, null_type=var3609, java.lang.Object=var3273, r1=var3035, org.apache.dubbo.rpc.model.ServiceDescriptor=var670, r3=var3895, java.lang.ClassLoader=var3497, r4=var655, org.apache.dubbo.rpc.model.ServiceModel=var2149, org.apache.dubbo.rpc.model.ModuleModel=var3005, null=var1745, java.util.HashMap=var2547, $r5=var2874, java.util.Map=var3746, java.util.ArrayList=var277, $r6=var2128, java.util.List=var2618, java.lang.IllegalArgumentException=var1757, $r8=var3743, $r9=var2167, $r10=var1989, $r11=var2265, $r12=var1380, $r13=var926}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.model.ProviderModel;	r2 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.Object;	r3 := @parameter2: org.apache.dubbo.rpc.model.ServiceDescriptor;	r4 := @parameter3: java.lang.ClassLoader;	specialinvoke r0.<org.apache.dubbo.rpc.model.ServiceModel: void <init>(java.lang.Object,java.lang.String,org.apache.dubbo.rpc.model.ServiceDescriptor,org.apache.dubbo.rpc.model.ModuleModel,java.lang.ClassLoader)>(r1, r2, r3, null, r4);	$r5 = new java.util.HashMap;	specialinvoke $r5.<java.util.HashMap: void <init>()>();	r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.Map methods> = $r5;	$r6 = new java.util.ArrayList;	specialinvoke $r6.<java.util.ArrayList: void <init>()>();	r0.<org.apache.dubbo.rpc.model.ProviderModel: java.util.List serviceUrls> = $r6;	r0.<org.apache.dubbo.rpc.model.ProviderModel: long lastInvokeTime> = 0L;	if null != r1 goto $r7 = new java.util.concurrent.CopyOnWriteArrayList;	$r8 = new java.lang.IllegalArgumentException;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Service[");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]Target is NULL.");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r8.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r13);	throw $r8
;block_num 2