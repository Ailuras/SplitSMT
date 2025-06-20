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

(declare-sort var1831 0)
(declare-sort var3834 0)
(declare-sort var1272 0)
(declare-sort var3073 0)
(declare-sort var291 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getInterface/326199548 (var3834) String)
(declare-fun cast-from-var1831-to-var3834 (var1831) var3834)
(declare-fun var1272_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var3073-init () var3073)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var291) String)
(declare-fun cast-from-var1831-to-var291 (var1831) var291)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var3073 String) void)
(declare-const null-var1831 var1831)
(declare-const var1275 var1831) ; Statement: r0 := @parameter0: org.apache.dubbo.config.ReferenceConfigBase 
(assert (not (= var1275 null-var1831)))
(assert true)
(define-const var545 String (getInterface/326199548 (cast-from-var1831-to-var3834 var1275))) ; Statement: r10 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String getInterface()>() 
(define-const var3425 Bool (var1272_isBlank/-523695098 (cast-from-String-to-String var545))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r10) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r10) 
(assert (= (ite var3425 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2619 Bool (var1272_isBlank/-523695098 (cast-from-String-to-String var545))) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r10) 
 ; Statement: if $z1 == 0 goto $r2 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String getGroup()>() 
(assert (not (= (ite var2619 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var3689 var3073 var3073-init) ; Statement: $r4 = new java.lang.IllegalArgumentException 
(define-const var2524 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2524)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2524!1 String)
(assert (= var2524!1 ""))
(assert true)
(define-const var2278 String (append/672562846 var2524!1 "No interface info in ReferenceConfig")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No interface info in ReferenceConfig") 
(declare-const var2524!2 String)
(assert (= var2524!2 (str.++ var2524!1 "No interface info in ReferenceConfig")))
(assert true)
(define-const var3337 String (append/-1031950772 var2278 (cast-from-var1831-to-var291 var1275))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var2278!1 String)
(assert (str.prefixof var2278 var2278!1))
(assert true)
(define-const var3645 String (toString/-2075883882 var3337)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var3689 var3645)) ; Statement: specialinvoke $r4.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r8) 

(declare-const var3689!1 var3073)
(declare-const var3645!1 String)
 ; Statement: throw $r4 
(check-sat)
; {getInterface/326199548=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), cast-from-var1831-to-var3834=([org.apache.dubbo.config.ReferenceConfigBase], org.apache.dubbo.config.AbstractInterfaceConfig), var1272_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var3073-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1831-to-var291=([org.apache.dubbo.config.ReferenceConfigBase], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var1831=org.apache.dubbo.config.ReferenceConfigBase, var1275=r0, var3834=org.apache.dubbo.config.AbstractInterfaceConfig, var545=r10, var1272=org.apache.dubbo.common.utils.StringUtils, var3425=$z0, var2619=$z1, var3073=java.lang.IllegalArgumentException, var3689=$r4, var2524=$r5, var2278=$r6, var291=java.lang.Object, var3337=$r7, var3645=$r8}
; {org.apache.dubbo.config.ReferenceConfigBase=var1831, r0=var1275, org.apache.dubbo.config.AbstractInterfaceConfig=var3834, r10=var545, org.apache.dubbo.common.utils.StringUtils=var1272, $z0=var3425, $z1=var2619, java.lang.IllegalArgumentException=var3073, $r4=var3689, $r5=var2524, $r6=var2278, java.lang.Object=var291, $r7=var3337, $r8=var3645}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 2,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.config.ReferenceConfigBase;	r10 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String getInterface()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r10);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r10);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r10);	if $z1 == 0 goto $r2 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String getGroup()>();	$r4 = new java.lang.IllegalArgumentException;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No interface info in ReferenceConfig");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r4.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r8);	throw $r4
;block_num 3