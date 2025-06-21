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

(declare-sort var2810 0)
(declare-sort var2254 0)
(declare-sort var1047 0)
(declare-sort var1798 0)
(declare-sort var1882 0)
(declare-sort var3698 0)
(declare-sort var3163 0)
(declare-sort var2646 0)
(declare-sort var1738 0)
(declare-sort var2971 0)
(declare-sort var2653 0)
(declare-sort var1785 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun listeners/-775390699 (var2810) var1798)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3698_bootstrap$/-755290455 (var2810 String String) var1882)
(declare-fun var1798_computeIfAbsent/-354326494 (var1798 var3163 var1882) var3163)
(declare-fun cast-from-String-to-var3163 (String) var3163)
(declare-fun cast-from-var3163-to-var2646 (var3163) var2646)
(declare-fun addListener/1217255180 (var2646 var1047) void)
(declare-fun dubboConfig/-775390699 (var2810) var1738)
(declare-fun var2653_singleton/1342501442 (var3163) var2971)
(declare-fun var1738_addChangeListener/28058182 (var1738 var1785 var2971) void)
(declare-fun cast-from-var2646-to-var1785 (var2646) var1785)
(declare-const null-var2810 var2810)
(declare-const null-String String)
(declare-const null-var1047 var1047)
(declare-const var963 var2810) ; Statement: r0 := @this: org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration 
(assert (not (= var963 null-var2810)))
(declare-const var360 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var360 null-String)))
(declare-const var2639 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var2639 null-String)))
(declare-const var1713 var1047) ; Statement: r11 := @parameter2: org.apache.dubbo.common.config.configcenter.ConfigurationListener 
(assert (not (= var1713 null-var1047)))
(define-const var2706 var1798 (listeners/-775390699 var963)) ; Statement: $r2 = r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: java.util.concurrent.ConcurrentMap listeners> 
(define-const var1660 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1660)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1660!1 String)
(assert (= var1660!1 ""))
(assert true)
(define-const var184 String (append/672562846 var1660!1 var2639)) ; Statement: $r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var1660!2 String)
(assert (= var1660!2 (str.++ var1660!1 var2639)))
(assert true)
(define-const var864 String (append/672562846 var184 var360)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var184!1 String)
(assert (= var184!1 (str.++ var184 var360)))
(assert true)
(define-const var3157 String (toString/-2075883882 var864)) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var871 var1882 (var3698_bootstrap$/-755290455 var963 var360 var2639)) ; Statement: $r7 = staticinvoke <org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration$lambda_addListener_1__597: java.util.function.Function bootstrap$(org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration,java.lang.String,java.lang.String)>(r0, r4, r3) 
(define-const var580 var3163 (var1798_computeIfAbsent/-354326494 var2706 (cast-from-String-to-var3163 var3157) var871)) ; Statement: $r9 = interfaceinvoke $r2.<java.util.concurrent.ConcurrentMap: java.lang.Object computeIfAbsent(java.lang.Object,java.util.function.Function)>($r8, $r7) 
(define-const var2275 var2646 (cast-from-var3163-to-var2646 var580)) ; Statement: r10 = (org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration$ApolloListener) $r9 
(assert true)
;(assert (addListener/1217255180 var2275 var1713)) ; Statement: virtualinvoke r10.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration$ApolloListener: void addListener(org.apache.dubbo.common.config.configcenter.ConfigurationListener)>(r11) 

(declare-const var2275!1 var2646)
(declare-const var1713!1 var1047)
(define-const var1249 var1738 (dubboConfig/-775390699 var963)) ; Statement: $r12 = r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: com.ctrip.framework.apollo.Config dubboConfig> 
(define-const var746 var2971 (var2653_singleton/1342501442 (cast-from-String-to-var3163 var360))) ; Statement: $r13 = staticinvoke <java.util.Collections: java.util.Set singleton(java.lang.Object)>(r4) 
;(assert (var1738_addChangeListener/28058182 var1249 (cast-from-var2646-to-var1785 var2275!1) var746)) ; Statement: interfaceinvoke $r12.<com.ctrip.framework.apollo.Config: void addChangeListener(com.ctrip.framework.apollo.ConfigChangeListener,java.util.Set)>(r10, $r13) 

(declare-const var1249!1 var1738)
(declare-const var2275!2 var2646)
(declare-const var746!1 var2971)
 ; Statement: return 
(check-sat)
; {listeners/-775390699=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration], java.util.concurrent.ConcurrentMap), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3698_bootstrap$/-755290455=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration, java.lang.String, java.lang.String], java.util.function.Function), var1798_computeIfAbsent/-354326494=([java.util.concurrent.ConcurrentMap, java.lang.Object, java.util.function.Function], java.lang.Object), cast-from-String-to-var3163=([java.lang.String], java.lang.Object), cast-from-var3163-to-var2646=([java.lang.Object], org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration$ApolloListener), addListener/1217255180=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration$ApolloListener, org.apache.dubbo.common.config.configcenter.ConfigurationListener], void), dubboConfig/-775390699=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration], com.ctrip.framework.apollo.Config), var2653_singleton/1342501442=([java.lang.Object], java.util.Set), var1738_addChangeListener/28058182=([com.ctrip.framework.apollo.Config, com.ctrip.framework.apollo.ConfigChangeListener, java.util.Set], void), cast-from-var2646-to-var1785=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration$ApolloListener], com.ctrip.framework.apollo.ConfigChangeListener)}
; {var2810=org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration, var963=r0, var360=r4, var2254=null_type, var2639=r3, var1047=org.apache.dubbo.common.config.configcenter.ConfigurationListener, var1713=r11, var1798=java.util.concurrent.ConcurrentMap, var2706=$r2, var1660=$r1, var184=$r5, var864=$r6, var3157=$r8, var1882=java.util.function.Function, var3698=org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration$lambda_addListener_1__597, var871=$r7, var3163=java.lang.Object, var580=$r9, var2646=org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration$ApolloListener, var2275=r10, var1738=com.ctrip.framework.apollo.Config, var1249=$r12, var2971=java.util.Set, var2653=java.util.Collections, var746=$r13, var1785=com.ctrip.framework.apollo.ConfigChangeListener}
; {org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration=var2810, r0=var963, r4=var360, null_type=var2254, r3=var2639, org.apache.dubbo.common.config.configcenter.ConfigurationListener=var1047, r11=var1713, java.util.concurrent.ConcurrentMap=var1798, $r2=var2706, $r1=var1660, $r5=var184, $r6=var864, $r8=var3157, java.util.function.Function=var1882, org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration$lambda_addListener_1__597=var3698, $r7=var871, java.lang.Object=var3163, $r9=var580, org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration$ApolloListener=var2646, r10=var2275, com.ctrip.framework.apollo.Config=var1738, $r12=var1249, java.util.Set=var2971, java.util.Collections=var2653, $r13=var746, com.ctrip.framework.apollo.ConfigChangeListener=var1785}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration;	r4 := @parameter0: java.lang.String;	r3 := @parameter1: java.lang.String;	r11 := @parameter2: org.apache.dubbo.common.config.configcenter.ConfigurationListener;	$r2 = r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: java.util.concurrent.ConcurrentMap listeners>;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	$r7 = staticinvoke <org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration$lambda_addListener_1__597: java.util.function.Function bootstrap$(org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration,java.lang.String,java.lang.String)>(r0, r4, r3);	$r9 = interfaceinvoke $r2.<java.util.concurrent.ConcurrentMap: java.lang.Object computeIfAbsent(java.lang.Object,java.util.function.Function)>($r8, $r7);	r10 = (org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration$ApolloListener) $r9;	virtualinvoke r10.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration$ApolloListener: void addListener(org.apache.dubbo.common.config.configcenter.ConfigurationListener)>(r11);	$r12 = r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: com.ctrip.framework.apollo.Config dubboConfig>;	$r13 = staticinvoke <java.util.Collections: java.util.Set singleton(java.lang.Object)>(r4);	interfaceinvoke $r12.<com.ctrip.framework.apollo.Config: void addChangeListener(com.ctrip.framework.apollo.ConfigChangeListener,java.util.Set)>(r10, $r13);	return
;block_num 1