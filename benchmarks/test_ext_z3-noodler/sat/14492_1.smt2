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

(declare-sort var671 0)
(declare-sort var1852 0)
(declare-sort var714 0)
(declare-sort var20 0)
(declare-sort var2121 0)
(declare-sort var2263 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/1991509242 (var714 var1852) void)
(declare-fun cast-from-var671-to-var714 (var671) var714)
(declare-fun var20-init () var20)
(declare-fun <init>/-325640736 (var20) void)
(declare-fun cast-from-var20-to-var2121 (var20) var2121)
(declare-fun listeners/-2130159109 (var671) var2121)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getApplicationModel/723682732 (var1852) var2263)
(declare-fun getApplicationName/1861025684 (var2263) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun initWith/710174258 (var714 String) void)
(declare-const null-var671 var671)
(declare-const null-var1852 var1852)
(declare-const var110 var671) ; Statement: r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory$ConsumerConfigurationListener 
(assert (not (= var110 null-var671)))
(declare-const var2415 var1852) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.model.ModuleModel 
(assert (not (= var2415 null-var1852)))
(assert true)
;(assert (<init>/1991509242 (cast-from-var671-to-var714 var110) var2415)) ; Statement: specialinvoke r0.<org.apache.dubbo.registry.integration.AbstractConfiguratorListener: void <init>(org.apache.dubbo.rpc.model.ModuleModel)>(r1) 

(declare-const var110!1 var671)
(declare-const var2415!1 var1852)
(define-const var1865 var20 var20-init) ; Statement: $r2 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var1865)) ; Statement: specialinvoke $r2.<java.util.ArrayList: void <init>()>() 

(declare-const var1865!1 var20)
(declare-const var110!2 var671)
(assert (not (= var110!2 null-var671)))
(assert (= (listeners/-2130159109 var110!2) (cast-from-var20-to-var2121 var1865!1))) ; Statement: r0.<org.apache.dubbo.registry.integration.RegistryDirectory$ConsumerConfigurationListener: java.util.List listeners> = $r2 
(define-const var2437 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2437)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2437!1 String)
(assert (= var2437!1 ""))
(assert true)
(define-const var1689 var2263 (getApplicationModel/723682732 var2415!1)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>() 
(assert true)
(define-const var2736 String (getApplicationName/1861025684 var1689)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.rpc.model.ApplicationModel: java.lang.String getApplicationName()>() 
(assert true)
(define-const var3323 String (append/672562846 var2437!1 var2736)) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var2437!2 String)
(assert (= var2437!2 (str.++ var2437!1 var2736)))
(assert true)
(define-const var987 String (append/672562846 var3323 ".configurators")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".configurators") 
(declare-const var3323!1 String)
(assert (= var3323!1 (str.++ var3323 ".configurators")))
(assert true)
(define-const var1535 String (toString/-2075883882 var987)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (initWith/710174258 (cast-from-var671-to-var714 var110!2) var1535)) ; Statement: virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory$ConsumerConfigurationListener: void initWith(java.lang.String)>($r8) 

(declare-const var110!3 var671)
(declare-const var1535!1 String)
 ; Statement: return 
(check-sat)
; {<init>/1991509242=([org.apache.dubbo.registry.integration.AbstractConfiguratorListener, org.apache.dubbo.rpc.model.ModuleModel], void), cast-from-var671-to-var714=([org.apache.dubbo.registry.integration.RegistryDirectory$ConsumerConfigurationListener], org.apache.dubbo.registry.integration.AbstractConfiguratorListener), var20-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), cast-from-var20-to-var2121=([java.util.ArrayList], java.util.List), listeners/-2130159109=([org.apache.dubbo.registry.integration.RegistryDirectory$ConsumerConfigurationListener], java.util.List), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getApplicationModel/723682732=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ApplicationModel), getApplicationName/1861025684=([org.apache.dubbo.rpc.model.ApplicationModel], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), initWith/710174258=([org.apache.dubbo.registry.integration.AbstractConfiguratorListener, java.lang.String], void)}
; {var671=org.apache.dubbo.registry.integration.RegistryDirectory$ConsumerConfigurationListener, var110=r0, var1852=org.apache.dubbo.rpc.model.ModuleModel, var2415=r1, var714=org.apache.dubbo.registry.integration.AbstractConfiguratorListener, var20=java.util.ArrayList, var1865=$r2, var2121=java.util.List, var2437=$r3, var2263=org.apache.dubbo.rpc.model.ApplicationModel, var1689=$r4, var2736=$r5, var3323=$r6, var987=$r7, var1535=$r8}
; {org.apache.dubbo.registry.integration.RegistryDirectory$ConsumerConfigurationListener=var671, r0=var110, org.apache.dubbo.rpc.model.ModuleModel=var1852, r1=var2415, org.apache.dubbo.registry.integration.AbstractConfiguratorListener=var714, java.util.ArrayList=var20, $r2=var1865, java.util.List=var2121, $r3=var2437, org.apache.dubbo.rpc.model.ApplicationModel=var2263, $r4=var1689, $r5=var2736, $r6=var3323, $r7=var987, $r8=var1535}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory$ConsumerConfigurationListener;	r1 := @parameter0: org.apache.dubbo.rpc.model.ModuleModel;	specialinvoke r0.<org.apache.dubbo.registry.integration.AbstractConfiguratorListener: void <init>(org.apache.dubbo.rpc.model.ModuleModel)>(r1);	$r2 = new java.util.ArrayList;	specialinvoke $r2.<java.util.ArrayList: void <init>()>();	r0.<org.apache.dubbo.registry.integration.RegistryDirectory$ConsumerConfigurationListener: java.util.List listeners> = $r2;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>();	$r5 = virtualinvoke $r4.<org.apache.dubbo.rpc.model.ApplicationModel: java.lang.String getApplicationName()>();	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".configurators");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory$ConsumerConfigurationListener: void initWith(java.lang.String)>($r8);	return
;block_num 1