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

(declare-sort var3970 0)
(declare-sort var2072 0)
(declare-sort var126 0)
(declare-sort var867 0)
(declare-sort var1976 0)
(declare-sort var959 0)
(declare-sort var129 0)
(declare-sort var2203 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun moduleModel/737601183 (var3970) var126)
(declare-fun getConfigManager/-335416425 (var126) var867)
(declare-fun getConfig/-202802450 (var867 ClassObject String) var1976)
(declare-fun orElse/-757175127 (var1976 var959) var959)
(declare-fun cast-from-var959-to-var129 (var959) var129)
(declare-fun var2203-init () var2203)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var2203 String) void)
(declare-const null-var3970 var3970)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const null-NullType var2072)
(declare-const null-var959 var959)
(declare-const null-var129 var129)
(declare-const var1905 var3970) ; Statement: r0 := @this: org.apache.dubbo.config.spring.reference.ReferenceCreator 
(assert (not (= var1905 null-var3970)))
(declare-const var3687 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var3687 null-String)))
(declare-const var2358 ClassObject) ; Statement: r2 := @parameter1: java.lang.Class 
(assert (not (= var2358 null-ClassObject)))
(define-const var673 var126 (moduleModel/737601183 var1905)) ; Statement: $r1 = r0.<org.apache.dubbo.config.spring.reference.ReferenceCreator: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert true)
(define-const var201 var867 (getConfigManager/-335416425 var673)) ; Statement: $r4 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.config.context.ModuleConfigManager getConfigManager()>() 
(assert true)
(define-const var2928 var1976 (getConfig/-202802450 var201 var2358 var3687)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.config.context.ModuleConfigManager: java.util.Optional getConfig(java.lang.Class,java.lang.String)>(r2, r3) 
(assert true)
(define-const var2466 var959 (orElse/-757175127 var2928 null-var959)) ; Statement: $r6 = virtualinvoke $r5.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>(null) 
(define-const var3747 var129 (cast-from-var959-to-var129 var2466)) ; Statement: r17 = (org.apache.dubbo.config.AbstractConfig) $r6 
 ; Statement: if r17 != null goto (branch) 
(assert (not (= var3747 null-var129))) ; Cond: r17 != null 
 ; Statement: if r17 != null goto return r17 
(assert (not (not (= var3747 null-var129)))) ; Negate: Cond: r17 != null  
(define-const var980 var2203 var2203-init) ; Statement: $r7 = new java.lang.IllegalArgumentException 
(define-const var3002 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3002)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3002!1 String)
(assert (= var3002!1 ""))
(assert true)
(define-const var3775 String (getSimpleName/-390194377 var2358)) ; Statement: $r9 = virtualinvoke r2.<java.lang.Class: java.lang.String getSimpleName()>() 
(assert true)
(define-const var3050 String (append/672562846 var3002!1 var3775)) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var3002!2 String)
(assert (= var3002!2 (str.++ var3002!1 var3775)))
(assert true)
(define-const var3928 String (append/672562846 var3050 " not found: ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" not found: ") 
(declare-const var3050!1 String)
(assert (= var3050!1 (str.++ var3050 " not found: ")))
(assert true)
(define-const var3301 String (append/672562846 var3928 var3687)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var3928!1 String)
(assert (= var3928!1 (str.++ var3928 var3687)))
(assert true)
(define-const var3261 String (toString/-2075883882 var3301)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var980 var3261)) ; Statement: specialinvoke $r7.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r13) 

(declare-const var980!1 var2203)
(declare-const var3261!1 String)
 ; Statement: throw $r7 
(check-sat)
; {moduleModel/737601183=([org.apache.dubbo.config.spring.reference.ReferenceCreator], org.apache.dubbo.rpc.model.ModuleModel), getConfigManager/-335416425=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.config.context.ModuleConfigManager), getConfig/-202802450=([org.apache.dubbo.config.context.ModuleConfigManager, java.lang.Class, java.lang.String], java.util.Optional), orElse/-757175127=([java.util.Optional, java.lang.Object], java.lang.Object), cast-from-var959-to-var129=([java.lang.Object], org.apache.dubbo.config.AbstractConfig), var2203-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getSimpleName/-390194377=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var3970=org.apache.dubbo.config.spring.reference.ReferenceCreator, var1905=r0, var3687=r3, var2072=null_type, var2358=r2, var126=org.apache.dubbo.rpc.model.ModuleModel, var673=$r1, var867=org.apache.dubbo.config.context.ModuleConfigManager, var201=$r4, var1976=java.util.Optional, var2928=$r5, var959=java.lang.Object, var2466=$r6, var129=org.apache.dubbo.config.AbstractConfig, var3747=r17, var2203=java.lang.IllegalArgumentException, var980=$r7, var3002=$r8, var3775=$r9, var3050=$r10, var3928=$r11, var3301=$r12, var3261=$r13}
; {org.apache.dubbo.config.spring.reference.ReferenceCreator=var3970, r0=var1905, r3=var3687, null_type=var2072, r2=var2358, org.apache.dubbo.rpc.model.ModuleModel=var126, $r1=var673, org.apache.dubbo.config.context.ModuleConfigManager=var867, $r4=var201, java.util.Optional=var1976, $r5=var2928, java.lang.Object=var959, $r6=var2466, org.apache.dubbo.config.AbstractConfig=var129, r17=var3747, java.lang.IllegalArgumentException=var2203, $r7=var980, $r8=var3002, $r9=var3775, $r10=var3050, $r11=var3928, $r12=var3301, $r13=var3261}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.config.spring.reference.ReferenceCreator;	r3 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.Class;	$r1 = r0.<org.apache.dubbo.config.spring.reference.ReferenceCreator: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r4 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.config.context.ModuleConfigManager getConfigManager()>();	$r5 = virtualinvoke $r4.<org.apache.dubbo.config.context.ModuleConfigManager: java.util.Optional getConfig(java.lang.Class,java.lang.String)>(r2, r3);	$r6 = virtualinvoke $r5.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>(null);	r17 = (org.apache.dubbo.config.AbstractConfig) $r6;	if r17 != null goto (branch);	if r17 != null goto return r17;	$r7 = new java.lang.IllegalArgumentException;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke r2.<java.lang.Class: java.lang.String getSimpleName()>();	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" not found: ");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r7.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r13);	throw $r7
;block_num 3